<?php
session_start();
require_once 'includes/auth.php';
require_once 'includes/db.php';

$auth = new Auth();
if (!$auth->isLoggedIn() || $auth->getCurrentUserRole() !== 'candidate') {
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

    // Processar alteração de senha do candidato
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'change_candidate_password') {
        $currentPassword = $_POST['current_password'] ?? '';
        $newPassword = $_POST['new_password'] ?? '';
        $confirmPassword = $_POST['confirm_password'] ?? '';
        
        if ($currentPassword && $newPassword && $confirmPassword) {
            if ($newPassword === $confirmPassword) {
                // Verificar senha atual
                $stmt = $db->prepare("SELECT password FROM candidates WHERE id = ?");
                $stmt->execute([$auth->getCurrentUserId()]);
                $candidate = $stmt->fetch(PDO::FETCH_ASSOC);
                
                if ($candidate && md5($currentPassword) === $candidate['password']) {
                    // Atualizar senha
                    $stmt = $db->prepare("UPDATE candidates SET password = ? WHERE id = ?");
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
        
        header('Location: candidate_panel.php');
        exit;
    }

    // Buscar informações do candidato
    $stmt = $db->prepare("SELECT * FROM candidates WHERE id = ?");
    $stmt->execute([$auth->getCurrentUserId()]);
    $candidate = $stmt->fetch(PDO::FETCH_ASSOC);

    // Buscar testes atribuídos
    $stmt = $db->prepare("
        SELECT ta.*, tr.id as result_id 
        FROM test_assignments ta 
        LEFT JOIN test_results tr ON tr.candidate_id = ta.candidate_id 
            AND tr.test_type = ta.test_type 
        WHERE ta.candidate_id = ?
        ORDER BY ta.created_at DESC
    ");
    $stmt->execute([$auth->getCurrentUserId()]);
    $assignments = $stmt->fetchAll(PDO::FETCH_ASSOC);

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
    <title>Painel do Candidato - Sistema de Testes</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .test-card {
            margin-bottom: 20px;
        }
        .navbar-brand img {
            max-height: 40px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="./assets/images/LOGO-Sys-Manager-horizontal-COLOR.png" alt="SysManager Logo">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <span class="nav-link">
                            <i class="bi bi-person"></i>
                            <?php echo htmlspecialchars($candidate['name']); ?>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#changeCandidatePasswordModal">
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
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <?php if (isset($_SESSION['error_message'])): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <?php 
                echo htmlspecialchars($_SESSION['error_message']);
                unset($_SESSION['error_message']);
                ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <?php endif; ?>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-white">
                        <h4 class="card-title mb-0">
                            <i class="bi bi-clipboard-check"></i>
                            Meus Testes
                        </h4>
                    </div>
                    <div class="card-body">
                        <?php if (empty($assignments)): ?>
                            <p class="text-muted">Nenhum teste atribuído no momento.</p>
                        <?php else: ?>
                            <div class="row">
                                <?php foreach ($assignments as $assignment): ?>
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card test-card">
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <?php echo htmlspecialchars(ucfirst($assignment['test_type'])); ?>
                                                </h5>
                                                <p class="card-text">
                                                    Status: 
                                                    <?php if ($assignment['result_id']): ?>
                                                        <span class="badge bg-success">Concluído</span>
                                                    <?php else: ?>
                                                        <span class="badge bg-warning">Pendente</span>
                                                    <?php endif; ?>
                                                </p>
                                                <?php if (!$assignment['result_id']): ?>
                                                    <a href="tests/<?php echo $assignment['test_type']; ?>.php?id=<?php echo $assignment['id']; ?>" 
                                                       class="btn btn-primary">
                                                        Iniciar Teste
                                                    </a>
                                                <?php endif; ?>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Alteração de Senha -->
    <?php include 'includes/candidate_change_password_modal.php'; ?>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
