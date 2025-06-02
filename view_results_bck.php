<?php
require_once 'includes/auth.php';
require_once 'includes/db.php';
require_once 'includes/batch_manager.php';

$auth = new Auth();
if (!$auth->isLoggedIn()) {
    header('Location: login.php');
    exit;
}

try {
    $db = getDbConnection();
    $batchManager = new BatchManager($db);

    // Obter ID do candidato da URL
    $candidateId = $_GET['candidate_id'] ?? null;
    $batchDate = $_GET['batch_date'] ?? null;

    error_log("Debug - Candidate ID: " . $candidateId);
    error_log("Debug - Batch Date: " . $batchDate);

    if (!$candidateId) {
        die("ID do candidato não fornecido");
    }

    // Verificar permissão
    if ($auth->getCurrentUserRole() === 'candidate' && $auth->getCurrentUserId() != $candidateId) {
        die("Acesso não autorizado");
    }

    // Buscar informações do candidato
    $stmt = $db->prepare("SELECT * FROM candidates WHERE id = ?");
    $stmt->execute([$candidateId]);
    $candidate = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$candidate) {
        die("Candidato não encontrado");
    }

    error_log("Debug - Candidate found: " . print_r($candidate, true));

    // Buscar batches do candidato
    $batches = $batchManager->getCandidateBatches($candidateId);
    error_log("Debug - Batches found: " . print_r($batches, true));

    // Se uma data específica foi fornecida, buscar resultados daquela data
    $batchResults = null;
    if ($batchDate) {
        $batchResults = $batchManager->getBatchResults($batchDate, $candidateId);
        error_log("Debug - Batch results: " . print_r($batchResults, true));
    }
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
    <title>Resultados dos Testes - <?php echo htmlspecialchars($candidate['name']); ?></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .test-card {
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .test-card:hover {
            transform: translateY(-5px);
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
                        <a class="nav-link" href="<?php echo $auth->getCurrentUserRole() === 'candidate' ? 'candidate_panel.php' : 'selector_panel.php'; ?>">
                            <i class="bi bi-arrow-left"></i> Voltar
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-white">
                        <h4 class="card-title mb-0">
                            <i class="bi bi-person"></i>
                            Resultados de <?php echo htmlspecialchars($candidate['name']); ?>
                        </h4>
                    </div>
                    <div class="card-body">
                        <?php if (empty($batches)): ?>
                            <p class="text-muted">Nenhum teste concluído ainda.</p>
                        <?php else: ?>
                            <?php if (!$batchDate): ?>
                                <!-- Lista de batches -->
                                <div class="list-group">
                                    <?php foreach ($batches as $batch): ?>
                                        <a href="?candidate_id=<?php echo $candidateId; ?>&batch_date=<?php echo $batch['batch_date']; ?>" 
                                           class="list-group-item list-group-item-action">
                                            <div class="d-flex w-100 justify-content-between">
                                                <h5 class="mb-1">
                                                    Testes de <?php echo date('d/m/Y', strtotime($batch['created_at'])); ?>
                                                </h5>
                                                <span class="badge bg-primary rounded-pill">
                                                    <?php echo $batch['completed_tests']; ?> teste(s)
                                                </span>
                                            </div>
                                        </a>
                                    <?php endforeach; ?>
                                </div>
                            <?php else: ?>
                                <!-- Resultados do batch específico -->
                                <a href="?candidate_id=<?php echo $candidateId; ?>" class="btn btn-outline-primary mb-4">
                                    <i class="bi bi-arrow-left"></i> Voltar para lista
                                </a>
                                
                                <h5 class="mb-4">
                                    Testes concluídos em <?php echo date('d/m/Y', strtotime($batchDate)); ?>
                                </h5>

                                <div class="row">
                                    <?php foreach ($batchResults as $result): ?>
                                        <div class="col-md-6">
                                            <div class="card test-card">
                                                <div class="card-body">
                                                    <h5 class="card-title">
                                                        <?php
                                                        $testName = '';
                                                        switch ($result['test_type']) {
                                                            case 'disc':
                                                                $testName = 'DISC';
                                                                break;
                                                            case 'mbti':
                                                                $testName = 'MBTI';
                                                                break;
                                                            case 'bigfive':
                                                                $testName = 'Big Five';
                                                                break;
                                                            case 'jss':
                                                                $testName = 'JSS';
                                                                break;
                                                        }
                                                        echo htmlspecialchars($testName);
                                                        ?>
                                                    </h5>
                                                    <p class="card-text">
                                                        Concluído em: 
                                                        <?php echo date('d/m/Y H:i', strtotime($result['completed_at'])); ?>
                                                    </p>
                                                    <button class="btn btn-primary view-results" 
                                                            data-results='<?php echo htmlspecialchars($result['results'], ENT_QUOTES); ?>'
                                                            data-test-type="<?php echo $result['test_type']; ?>">
                                                        <i class="bi bi-graph-up"></i>
                                                        Ver Resultados
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    <?php endforeach; ?>
                                </div>
                            <?php endif; ?>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para exibir resultados -->
    <div class="modal fade" id="resultsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Resultados do Teste</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="resultsContent">
                    <!-- Conteúdo será preenchido via JavaScript -->
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const resultsModal = new bootstrap.Modal(document.getElementById('resultsModal'));
            const resultsContent = document.getElementById('resultsContent');
            
            document.querySelectorAll('.view-results').forEach(button => {
                button.addEventListener('click', function() {
                    try {
                        const testType = this.dataset.testType;
                        const resultsStr = this.dataset.results;
                        console.log('Test type:', testType);
                        console.log('Raw results:', resultsStr);
                        
                        let results;
                        try {
                            results = JSON.parse(resultsStr);
                        } catch (e) {
                            console.error('Error parsing results:', e);
                            throw new Error('Erro ao processar os resultados do teste');
                        }
                        
                        console.log('Parsed results:', results);
                        let content = '';
                        const chartId = 'resultChart';
                        
                        switch (testType) {
                            case 'disc':
                                // Código do DISC permanece o mesmo, pois já está funcionando
                                content = '<div><canvas id="' + chartId + '"></canvas></div>';
                                resultsContent.innerHTML = content;
                                
                                const counts = {
                                    'Dominância (D)': 0,
                                    'Influência (I)': 0,
                                    'Estabilidade (S)': 0,
                                    'Conformidade (C)': 0
                                };
                                
                                Object.values(results).forEach(answer => {
                                    switch(answer) {
                                        case 'D': counts['Dominância (D)'] += 5; break;
                                        case 'I': counts['Influência (I)'] += 5; break;
                                        case 'S': counts['Estabilidade (S)'] += 5; break;
                                        case 'C': counts['Conformidade (C)'] += 5; break;
                                    }
                                });
                                
                                new Chart(document.getElementById(chartId), {
                                    type: 'radar',
                                    data: {
                                        labels: Object.keys(counts),
                                        datasets: [{
                                            label: 'Perfil DISC',
                                            data: Object.values(counts),
                                            backgroundColor: 'rgba(75, 108, 183, 0.5)',
                                            borderColor: 'rgba(75, 108, 183, 1)',
                                            borderWidth: 1
                                        }]
                                    },
                                    options: {
                                        scales: {
                                            r: {
                                                beginAtZero: true,
                                                max: 100
                                            }
                                        }
                                    }
                                });
                                break;
                                
                            case 'mbti':
                                content = `
                                    <h4>Tipo MBTI: ${results.type}</h4>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Dimensão</th>
                                                    <th>Pontuação</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>Extroversão (E) / Introversão (I)</td>
                                                    <td>${results.dimensions.E} / ${results.dimensions.I}</td>
                                                </tr>
                                                <tr>
                                                    <td>Sensação (S) / Intuição (N)</td>
                                                    <td>${results.dimensions.S} / ${results.dimensions.N}</td>
                                                </tr>
                                                <tr>
                                                    <td>Pensamento (T) / Sentimento (F)</td>
                                                    <td>${results.dimensions.T} / ${results.dimensions.F}</td>
                                                </tr>
                                                <tr>
                                                    <td>Julgamento (J) / Percepção (P)</td>
                                                    <td>${results.dimensions.J} / ${results.dimensions.P}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="alert alert-info mt-3">
                                            <strong>Interpretação:</strong><br>
                                            E/I: ${results.dimensions.E > results.dimensions.I ? 'Extrovertido' : 'Introvertido'}<br>
                                            S/N: ${results.dimensions.S > results.dimensions.N ? 'Sensorial' : 'Intuitivo'}<br>
                                            T/F: ${results.dimensions.T > results.dimensions.F ? 'Pensamento' : 'Sentimento'}<br>
                                            J/P: ${results.dimensions.J > results.dimensions.P ? 'Julgamento' : 'Percepção'}
                                        </div>
                                    </div>
                                `;
                                resultsContent.innerHTML = content;
                                break;
                                
                            case 'bigfive':
                                content = '<div><canvas id="' + chartId + '"></canvas></div>';
                                resultsContent.innerHTML = content;
                                
                                new Chart(document.getElementById(chartId), {
                                    type: 'radar',
                                    data: {
                                        labels: Object.keys(results.dimensions),
                                        datasets: [{
                                            label: 'Big Five',
                                            data: Object.values(results.dimensions),
                                            backgroundColor: 'rgba(255, 193, 7, 0.5)',
                                            borderColor: 'rgba(255, 193, 7, 1)',
                                            borderWidth: 1
                                        }]
                                    },
                                    options: {
                                        scales: {
                                            r: {
                                                beginAtZero: true,
                                                max: 5
                                            }
                                        }
                                    }
                                });

                                // Adicionar tabela com interpretação
                                resultsContent.innerHTML += `
                                    <div class="table-responsive mt-4">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Dimensão</th>
                                                    <th>Pontuação</th>
                                                    <th>Interpretação</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                ${Object.entries(results.dimensions).map(([dim, score]) => `
                                                    <tr>
                                                        <td>${dim}</td>
                                                        <td>${Number(score).toFixed(2)}</td>
                                                        <td>${interpretBigFiveScore(dim, score)}</td>
                                                    </tr>
                                                `).join('')}
                                            </tbody>
                                        </table>
                                    </div>
                                `;
                                break;
                                
                            case 'jss':
                                content = `
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Categoria</th>
                                                    <th>Pontuação Média</th>
                                                    <th>Interpretação</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                `;
                                
                                Object.entries(results.scores).forEach(([category, data]) => {
                                    const level = interpretJssScore(data.average);
                                    content += `
                                        <tr>
                                            <td>${category}</td>
                                            <td>${Number(data.average).toFixed(2)}</td>
                                            <td>
                                                <span class="badge bg-${level.color}">
                                                    ${level.text}
                                                </span>
                                            </td>
                                        </tr>
                                    `;
                                });
                                
                                content += `
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="alert alert-info mt-3">
                                        <strong>Legenda:</strong><br>
                                        <span class="badge bg-success">Baixo Estresse (1-2)</span>
                                        <span class="badge bg-warning">Estresse Moderado (2-3)</span>
                                        <span class="badge bg-danger">Alto Estresse (3-5)</span>
                                    </div>
                                `;
                                resultsContent.innerHTML = content;
                                break;
                        }
                        
                        resultsModal.show();
                    } catch (error) {
                        console.error('Error processing results:', error);
                        resultsContent.innerHTML = `
                            <div class="alert alert-danger">
                                Erro ao processar resultados: ${error.message}
                            </div>
                        `;
                        resultsModal.show();
                    }
                });
            });

            // Função auxiliar para interpretar pontuações do Big Five
            function interpretBigFiveScore(dimension, score) {
                score = Number(score);
                if (score < 2) return 'Muito Baixo';
                if (score < 3) return 'Baixo';
                if (score < 4) return 'Moderado';
                if (score < 4.5) return 'Alto';
                return 'Muito Alto';
            }

            // Função auxiliar para interpretar pontuações do JSS
            function interpretJssScore(score) {
                score = Number(score);
                if (score <= 2) {
                    return { text: 'Baixo Estresse', color: 'success' };
                } else if (score <= 3) {
                    return { text: 'Estresse Moderado', color: 'warning' };
                } else {
                    return { text: 'Alto Estresse', color: 'danger' };
                }
            }
        });
    </script>
</body>
</html>
