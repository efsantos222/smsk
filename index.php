<?php
session_start();
require_once 'includes/auth.php';

// Processar logout
if (isset($_GET['action']) && $_GET['action'] === 'logout') {
    $auth = new Auth();
    $auth->logout();
    header('Location: index.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Avaliação</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8eb 100%);
            padding-top: 50px;
        }
        .container {
            max-width: 1200px;
            padding: 20px;
        }
        .hero-section {
            text-align: center;
            margin-bottom: 50px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
        }
        .hero-section img {
            max-width: 200px;
            height: auto;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }
        .hero-section img:hover {
            transform: scale(1.05);
        }
        .hero-section h1 {
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .hero-section p {
            color: #34495e;
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto;
        }
        .card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            background: white;
            position: relative;
            cursor: pointer;
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #4b6cb7 0%, #182848 100%);
            transform: scaleX(0);
            transition: transform 0.3s ease;
            transform-origin: left;
        }
        .card:hover::before {
            transform: scaleX(1);
        }
        .card-body {
            padding: 2rem;
            text-align: center;
            position: relative;
            z-index: 1;
        }
        .card .bi {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            color: #4b6cb7;
            transition: all 0.3s ease;
        }
        .card:hover .bi {
            transform: scale(1.1);
            color: #182848;
        }
        .card-title {
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .card-text {
            color: #7f8c8d;
            margin-bottom: 1.5rem;
            font-size: 1rem;
            line-height: 1.6;
        }
        .btn-primary {
            background: linear-gradient(90deg, #4b6cb7 0%, #182848 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(75, 108, 183, 0.4);
        }
        .btn-primary::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, #182848 0%, #4b6cb7 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .btn-primary:hover::after {
            opacity: 1;
        }
        .btn-primary span {
            position: relative;
            z-index: 1;
        }
        .footer {
            text-align: center;
            margin-top: 50px;
            padding: 20px;
            color: #7f8c8d;
            font-size: 0.9rem;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
        }
        .footer img {
            max-width: 150px;
            height: auto;
            margin-bottom: 10px;
            opacity: 0.8;
            transition: opacity 0.3s ease;
        }
        .footer img:hover {
            opacity: 1;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .row > div {
            animation: fadeIn 0.6s ease backwards;
        }
        .row > div:nth-child(1) { animation-delay: 0.2s; }
        .row > div:nth-child(2) { animation-delay: 0.4s; }
        .row > div:nth-child(3) { animation-delay: 0.6s; }

        /* Cores específicas para cada área */
        .card.candidate-card::before { background: linear-gradient(90deg, #2ecc71 0%, #27ae60 100%); }
        .card.candidate-card .bi { color: #2ecc71; }
        .card.candidate-card:hover .bi { color: #27ae60; }
        .card.candidate-card .btn-primary { background: linear-gradient(90deg, #2ecc71 0%, #27ae60 100%); }
        .card.candidate-card .btn-primary::after { background: linear-gradient(90deg, #27ae60 0%, #2ecc71 100%); }

        .card.selector-card::before { background: linear-gradient(90deg, #3498db 0%, #2980b9 100%); }
        .card.selector-card .bi { color: #3498db; }
        .card.selector-card:hover .bi { color: #2980b9; }
        .card.selector-card .btn-primary { background: linear-gradient(90deg, #3498db 0%, #2980b9 100%); }
        .card.selector-card .btn-primary::after { background: linear-gradient(90deg, #2980b9 0%, #3498db 100%); }

        .card.admin-card::before { background: linear-gradient(90deg, #e74c3c 0%, #c0392b 100%); }
        .card.admin-card .bi { color: #e74c3c; }
        .card.admin-card:hover .bi { color: #c0392b; }
        .card.admin-card .btn-primary { background: linear-gradient(90deg, #e74c3c 0%, #c0392b 100%); }
        .card.admin-card .btn-primary::after { background: linear-gradient(90deg, #c0392b 0%, #e74c3c 100%); }
    </style>
</head>
<body>
    <?php if (isset($_SESSION['user_id'])): ?>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">Sistema de Avaliação</a>
            <div class="ms-auto">
                <span class="navbar-text me-3">
                    <i class="bi bi-person-circle"></i>
                    Olá, <?php echo htmlspecialchars($_SESSION['user_name']); ?>
                </span>
                <a href="?action=logout" class="btn btn-light">
                    <i class="bi bi-box-arrow-right"></i>
                    Sair
                </a>
            </div>
        </div>
    </nav>
    <?php endif; ?>

    <div class="container">
        <?php if (!isset($_SESSION['user_id'])): ?>
        <div class="hero-section">
            <img src="./assets/images/LOGO-Sys-Manager-horizontal-COLOR.png" alt="SysManager Logo" class="img-fluid mb-4">
            <h1>Sistema de Avaliação</h1>
            <p class="lead mb-4">Bem-vindo ao sistema de avaliação da SysManager. Escolha seu tipo de acesso para continuar.</p>
        </div>

        <!-- Access Cards -->
        <div class="row g-4">
            <!-- Candidato -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm candidate-card">
                    <div class="card-body text-center">
                        <i class="bi bi-person-badge display-4"></i>
                        <h5 class="card-title mt-3">Candidato</h5>
                        <p class="card-text">Acesse para realizar seus testes</p>
                        <a href="login.php?role=candidate" class="btn btn-primary">Acessar como Candidato</a>
                    </div>
                </div>
            </div>

            <!-- Avaliador -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm selector-card">
                    <div class="card-body text-center">
                        <i class="bi bi-person-workspace display-4"></i>
                        <h5 class="card-title mt-3">Avaliador</h5>
                        <p class="card-text">Gerencie candidatos e visualize resultados</p>
                        <a href="login.php?role=selector" class="btn btn-primary">Acessar como Avaliador</a>
                    </div>
                </div>
            </div>

            <!-- Super Admin -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm admin-card">
                    <div class="card-body text-center">
                        <i class="bi bi-shield-lock display-4"></i>
                        <h5 class="card-title mt-3">Super Admin</h5>
                        <p class="card-text">Acesso administrativo ao sistema</p>
                        <a href="login.php?role=superadmin" class="btn btn-primary">Acessar como Super Admin</a>
                    </div>
                </div>
            </div>
        </div>
        <?php else: ?>
        <!-- Conteúdo para usuários logados -->
        <?php endif; ?>
        <!-- Footer -->
        <div class="footer">
            <img src="https://proftest.com.br/wp-content/uploads/2023/12/smalllogo2.png" alt="ProfTest Logo">
            <p><?php echo date('Y'); ?> Proftest. Todos os direitos reservados.</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
