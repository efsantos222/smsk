<?php
require_once 'includes/auth.php';
require_once 'includes/db.php';

$auth = new Auth();
if (!$auth->isLoggedIn() || $auth->getCurrentUserRole() !== 'selector') {
    header('Location: login.php');
    exit;
}

try {
    $db = getDbConnection();

    // Processar logout
    if (isset($_GET['action']) && $_GET['action'] === 'logout') {
        $auth->logout();
        header('Location: ./index.php');
        exit;
    }

    // Processar adição de candidato
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'add_candidate') {
        $name = $_POST['name'] ?? '';
        $email = $_POST['email'] ?? '';
        $cargo = $_POST['cargo'] ?? '';
        $tests = $_POST['tests'] ?? [];

        if ($name && $email && $cargo && !empty($tests)) {
            try {
                $db->beginTransaction();

                // Gerar senha aleatória
                $password = substr(str_shuffle('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'), 0, 8);
                $passwordHash = md5($password);

                // Inserir candidato
                $stmt = $db->prepare("INSERT INTO candidates (name, email, password, cargo, selector_id) VALUES (?, ?, ?, ?, ?)");
                $stmt->execute([$name, $email, $passwordHash, $cargo, $auth->getCurrentUserId()]);
                $candidateId = $db->lastInsertId();

                // Atribuir testes
                $stmt = $db->prepare("INSERT INTO test_assignments (candidate_id, test_type, assigned_by, created_at) VALUES (?, ?, ?, NOW())");
                foreach ($tests as $testType) {
                    $stmt->execute([$candidateId, $testType, $auth->getCurrentUserId()]);
                }

                $db->commit();
                $_SESSION['success_message'] = "Candidato adicionado com sucesso! A senha é: $password";
            } catch (Exception $e) {
                $db->rollBack();
                $_SESSION['error_message'] = "Erro ao adicionar candidato: " . $e->getMessage();
            }
        } else {
            $_SESSION['error_message'] = "Por favor, preencha todos os campos e selecione pelo menos um teste.";
        }
        
        header('Location: selector_panel.php');
        exit;
    }

    // Processar alteração de senha
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'change_password') {
        $candidateId = $_POST['candidate_id'] ?? null;
        $newPassword = $_POST['new_password'] ?? null;
        
        if ($candidateId && $newPassword) {
            // Validar se o candidato pertence ao seletor atual
            $stmt = $db->prepare("SELECT id FROM candidates WHERE id = ? AND selector_id = ?");
            $stmt->execute([$candidateId, $auth->getCurrentUserId()]);
            
            if ($stmt->fetch()) {
                $stmt = $db->prepare("UPDATE candidates SET password = ? WHERE id = ?");
                $stmt->execute([$newPassword, $candidateId]);
                $_SESSION['success_message'] = "Senha alterada com sucesso!";
            } else {
                $_SESSION['error_message'] = "Candidato não encontrado ou sem permissão.";
            }
        } else {
            $_SESSION['error_message'] = "Dados incompletos para alteração de senha.";
        }
        
        header('Location: selector_panel.php');
        exit;
    }

    // Processar alteração de senha do selecionador
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'change_selector_password') {
        $currentPassword = $_POST['current_password'] ?? '';
        $newPassword = $_POST['new_password'] ?? '';
        $confirmPassword = $_POST['confirm_password'] ?? '';
        
        if ($currentPassword && $newPassword && $confirmPassword) {
            if ($newPassword === $confirmPassword) {
                // Verificar senha atual
                $stmt = $db->prepare("SELECT password FROM users WHERE id = ? AND role = 'selector'");
                $stmt->execute([$auth->getCurrentUserId()]);
                $user = $stmt->fetch(PDO::FETCH_ASSOC);
                
                if ($user && md5($currentPassword) === $user['password']) {
                    // Atualizar senha
                    $stmt = $db->prepare("UPDATE users SET password = ? WHERE id = ? AND role = 'selector'");
                    if ($stmt->execute([md5($newPassword), $auth->getCurrentUserId()])) {
                        $_SESSION['success_message'] = "Senha alterada com sucesso!";
                    } else {
                        $_SESSION['error_message'] = "Erro ao alterar a senha.";
                    }
                } else {
                    $_SESSION['error_message'] = "Senha atual incorreta.";
                }
            } else {
                $_SESSION['error_message'] = "As novas senhas não coincidem.";
            }
        } else {
            $_SESSION['error_message'] = "Todos os campos são obrigatórios.";
        }
        
        header('Location: selector_panel.php');
        exit;
    }

    // Processar exclusão de candidato
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'delete_candidate') {
        $candidateId = $_POST['candidate_id'] ?? null;
        
        if ($candidateId) {
            try {
                $db->beginTransaction();

                // Verificar se o candidato pertence ao seletor atual
                $stmt = $db->prepare("SELECT id FROM candidates WHERE id = ? AND selector_id = ?");
                $stmt->execute([$candidateId, $auth->getCurrentUserId()]);
                
                if ($stmt->fetch()) {
                    // Deletar resultados dos testes
                    $stmt = $db->prepare("DELETE FROM test_results WHERE candidate_id = ?");
                    $stmt->execute([$candidateId]);
                    
                    // Deletar atribuições de testes
                    $stmt = $db->prepare("DELETE FROM test_assignments WHERE candidate_id = ?");
                    $stmt->execute([$candidateId]);
                    
                    // Deletar o candidato
                    $stmt = $db->prepare("DELETE FROM candidates WHERE id = ?");
                    $stmt->execute([$candidateId]);
                    
                    $db->commit();
                    $_SESSION['success_message'] = "Candidato excluído com sucesso!";
                } else {
                    $_SESSION['error_message'] = "Candidato não encontrado ou sem permissão.";
                }
            } catch (Exception $e) {
                $db->rollBack();
                $_SESSION['error_message'] = "Erro ao excluir candidato: " . $e->getMessage();
            }
        } else {
            $_SESSION['error_message'] = "ID do candidato não fornecido.";
        }
        
        header('Location: selector_panel.php');
        exit;
    }

    // Buscar candidatos do seletor atual
    $stmt = $db->prepare("
        SELECT 
            c.*,
            COUNT(DISTINCT ta.test_type) as total_tests,
            COUNT(DISTINCT tr.id) as completed_tests
        FROM candidates c
        LEFT JOIN test_assignments ta ON c.id = ta.candidate_id
        LEFT JOIN test_results tr ON c.id = tr.candidate_id AND tr.test_type = ta.test_type
        WHERE c.selector_id = ?
        GROUP BY c.id
        ORDER BY c.name
    ");
    $stmt->execute([$auth->getCurrentUserId()]);
    $candidates = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Buscar testes pendentes
    $stmt = $db->prepare("
        SELECT 
            c.id as candidate_id,
            c.name as candidate_name,
            c.email as candidate_email,
            ta.test_type,
            ta.created_at as assigned_at
        FROM candidates c
        INNER JOIN test_assignments ta ON c.id = ta.candidate_id
        LEFT JOIN test_results tr ON c.id = tr.candidate_id AND tr.test_type = ta.test_type
        WHERE c.selector_id = ? AND tr.id IS NULL
        ORDER BY ta.created_at DESC
    ");
    $stmt->execute([$auth->getCurrentUserId()]);
    $pending_tests = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Buscar resultados dos testes
    $stmt = $db->prepare("
        SELECT 
            c.id as candidate_id,
            c.name as candidate_name,
            c.email as candidate_email,
            c.cargo,
            ta.test_type,
            tr.completed_at,
            tr.results
        FROM candidates c
        INNER JOIN test_assignments ta ON c.id = ta.candidate_id
        INNER JOIN test_results tr ON c.id = tr.candidate_id AND tr.test_type = ta.test_type
        WHERE c.selector_id = ?
        ORDER BY tr.completed_at DESC
    ");
    $stmt->execute([$auth->getCurrentUserId()]);
    $test_results = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    error_log("Erro no banco de dados: " . $e->getMessage());
    die("Ocorreu um erro ao carregar os dados. Por favor, tente novamente mais tarde.");
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do(a) Avaliador(a) - Sistema de Avaliação</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <style>
        .nav-tabs .nav-link {
            color: #495057;
        }
        .nav-tabs .nav-link.active {
            color: #0d6efd;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="./assets/images/LOGO-Sys-Manager-horizontal-COLOR.png" alt="SysManager Logo" height="40">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <span class="nav-link">
                            <i class="bi bi-person-circle"></i>
                            <?php echo htmlspecialchars($_SESSION['user_name']); ?>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#changeSelectorPasswordModal">
                            <i class="bi bi-key"></i> Alterar Senha
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="?action=logout">
                            <i class="bi bi-box-arrow-right"></i> Sair
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <?php if (isset($_SESSION['success_message'])): ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <?php 
                echo htmlspecialchars($_SESSION['success_message']);
                unset($_SESSION['success_message']);
                ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <?php if (isset($_SESSION['error_message'])): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <?php 
                echo htmlspecialchars($_SESSION['error_message']);
                unset($_SESSION['error_message']);
                ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <ul class="nav nav-tabs mb-4" id="selectorTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="candidates-tab" data-bs-toggle="tab" href="#candidates" role="tab">
                    <i class="bi bi-people"></i> Candidatos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="pending-tab" data-bs-toggle="tab" href="#pending" role="tab">
                    <i class="bi bi-hourglass-split"></i> Testes Pendentes
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="results-tab" data-bs-toggle="tab" href="#results" role="tab">
                    <i class="bi bi-graph-up"></i> Resultados
                </a>
            </li>
        </ul>

        <div class="tab-content" id="selectorTabsContent">
            <!-- Aba Candidatos -->
            <div class="tab-pane fade show active" id="candidates" role="tabpanel">
                <div class="card">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h4 class="card-title mb-0">
                            <i class="bi bi-people"></i>
                            Gerenciamento de Candidatos
                        </h4>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCandidateModal">
                            <i class="bi bi-person-plus"></i>
                            Novo Candidato
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover" id="candidatesTable">
                                <thead>
                                    <tr>
                                        <th>Nome</th>
                                        <th>Email</th>
                                        <th>Cargo</th>
                                        <th>Testes Concluídos</th>
                                        <th>Ações</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($candidates as $candidate): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($candidate['name']); ?></td>
                                            <td><?php echo htmlspecialchars($candidate['email']); ?></td>
                                            <td><?php echo htmlspecialchars($candidate['cargo'] ?? 'Não informado'); ?></td>
                                            <td>
                                                <?php echo $candidate['completed_tests']; ?>/<?php echo $candidate['total_tests']; ?>
                                            </td>
                                            <td>
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-sm btn-outline-primary" 
                                                            onclick="showChangePasswordModal(<?php echo $candidate['id']; ?>, '<?php echo htmlspecialchars($candidate['name']); ?>')">
                                                        <i class="bi bi-key"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="showDeleteConfirmation(<?php echo $candidate['id']; ?>, '<?php echo htmlspecialchars($candidate['name']); ?>')">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Aba Testes Pendentes -->
            <div class="tab-pane fade" id="pending" role="tabpanel">
                <div class="card">
                    <div class="card-header bg-white">
                        <h4 class="card-title mb-0">
                            <i class="bi bi-hourglass-split"></i>
                            Testes Pendentes
                        </h4>
                    </div>
                    <div class="card-body">
                        <?php if (empty($pending_tests)): ?>
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle me-2"></i>
                                Não há testes pendentes no momento.
                            </div>
                        <?php else: ?>
                            <div class="table-responsive">
                                <table class="table table-hover" id="pendingTable">
                                    <thead>
                                        <tr>
                                            <th>Candidato</th>
                                            <th>Email</th>
                                            <th>Tipo de Teste</th>
                                            <th>Data de Atribuição</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($pending_tests as $test): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($test['candidate_name']); ?></td>
                                                <td><?php echo htmlspecialchars($test['candidate_email']); ?></td>
                                                <td>
                                                    <?php
                                                    switch ($test['test_type']) {
                                                        case 'disc':
                                                            echo 'DISC';
                                                            break;
                                                        case 'mbti':
                                                            echo 'MBTI';
                                                            break;
                                                        case 'bigfive':
                                                            echo 'Big Five';
                                                            break;
                                                        case 'jss':
                                                            echo 'JSS';
                                                            break;
                                                    }
                                                    ?>
                                                </td>
                                                <td><?php echo date('d/m/Y H:i', strtotime($test['assigned_at'])); ?></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>

            <!-- Aba Resultados -->
            <div class="tab-pane fade" id="results" role="tabpanel">
                <div class="card">
                    <div class="card-header bg-white">
                        <h4 class="card-title mb-0">
                            <i class="bi bi-graph-up"></i>
                            Resultados dos Testes
                        </h4>
                    </div>
                    <div class="card-body">
                        <?php if (empty($test_results)): ?>
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle me-2"></i>
                                Nenhum resultado encontrado.
                            </div>
                        <?php else: ?>
                            <div class="table-responsive">
                                <table class="table table-hover" id="resultsTable">
                                    <thead>
                                        <tr>
                                            <th>Candidato</th>
                                            <th>Email</th>
                                            <th>Cargo</th>
                                            <th>Tipo de Teste</th>
                                            <th>Data de Conclusão</th>
                                            <th>Ações</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($test_results as $result): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($result['candidate_name']); ?></td>
                                                <td><?php echo htmlspecialchars($result['candidate_email']); ?></td>
                                                <td><?php echo htmlspecialchars($result['cargo'] ?? 'Não informado'); ?></td>
                                                <td>
                                                    <?php
                                                    switch ($result['test_type']) {
                                                        case 'disc':
                                                            echo 'DISC';
                                                            break;
                                                        case 'mbti':
                                                            echo 'MBTI';
                                                            break;
                                                        case 'bigfive':
                                                            echo 'Big Five';
                                                            break;
                                                        case 'jss':
                                                            echo 'JSS';
                                                            break;
                                                    }
                                                    ?>
                                                </td>
                                                <td><?php echo date('d/m/Y H:i', strtotime($result['completed_at'])); ?></td>
                                                <td>
                                                    <a href="view_results.php?candidate_id=<?php echo $result['candidate_id']; ?>&type=<?php echo $result['test_type']; ?>" 
                                                       class="btn btn-sm btn-primary">
                                                        <i class="bi bi-graph-up"></i>
                                                        Ver
                                                    </a>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modais -->
    <?php 
    include 'includes/selector_modals.php';
    include 'includes/selector_change_password_modal.php';
    ?>
    <div class="modal fade" id="changeSelectorPasswordModal" tabindex="-1" aria-labelledby="changeSelectorPasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changeSelectorPasswordModalLabel">Alterar Senha</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="" method="post">
                        <input type="hidden" name="action" value="change_selector_password">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Senha Atual:</label>
                            <input type="password" class="form-control" id="currentPassword" name="current_password" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Nova Senha:</label>
                            <input type="password" class="form-control" id="newPassword" name="new_password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirmar Nova Senha:</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirm_password" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Alterar Senha</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            // Inicializar DataTables
            $('#candidatesTable, #pendingTable, #resultsTable').DataTable({
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/pt-BR.json'
                }
            });
        });

        function showChangePasswordModal(candidateId, candidateName) {
            document.getElementById('changePasswordCandidateId').value = candidateId;
            document.getElementById('candidateName').textContent = candidateName;
            var modal = new bootstrap.Modal(document.getElementById('changePasswordModal'));
            modal.show();
        }

        function showDeleteConfirmation(candidateId, candidateName) {
            document.getElementById('deleteCandidateId').value = candidateId;
            document.getElementById('deleteCandidateName').textContent = candidateName;
            var modal = new bootstrap.Modal(document.getElementById('deleteCandidateModal'));
            modal.show();
        }
    </script>
</body>
</html>
