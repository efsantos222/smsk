<?php
session_start();

// Conexão com o novo banco de dados
$servername = "localhost";
$username = "efsantos_disc";
$password = "Kyew1802";
$dbname = "efsantos_disc_sysmanager";

// Criar conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexão
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Lógica para identificar o tenant
$tenant_id = $_SESSION['tenant_id'] ?? null;
if (!$tenant_id) {
    // Redirecionar para login ou seleção de tenant
    header('Location: /login.php');
    exit();
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Hero Section -->
        <div class="hero-section">
            <h1>Bem-vindo ao Sistema SaaS Multi-Tenant</h1>
            <p>Esta é a interface inicial do sistema.</p>
        </div>
    </div>
</body>
</html>
