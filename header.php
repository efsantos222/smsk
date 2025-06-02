<?php
// Determinar a página atual
$current_page = basename($_SERVER['PHP_SELF']);

// Definir o título e o caminho de volta para cada página
$page_config = [
    'superadmin_dashboard.php' => ['title' => 'Painel do Superadmin', 'back' => ''],
    'superadmin_panel.php' => ['title' => 'Gerenciamento de Usuários', 'back' => 'superadmin_dashboard.php'],
    'manage_admins.php' => ['title' => 'Gerenciar Administradores', 'back' => 'superadmin_dashboard.php'],
    'register_admin.php' => ['title' => 'Registrar Administrador', 'back' => 'manage_admins.php'],
    'register_candidate.php' => ['title' => 'Registrar Candidato DISC', 'back' => 'view_candidates.php'],
    'view_candidates.php' => ['title' => 'Candidatos DISC', 'back' => isset($_SESSION['superadmin_authenticated']) ? 'superadmin_panel.php' : 'admin_dashboard.php'],
    'register_candidate_mbti.php' => ['title' => 'Registrar Candidato MBTI', 'back' => 'view_candidates_mbti.php'],
    'view_candidates_mbti.php' => ['title' => 'Candidatos MBTI', 'back' => isset($_SESSION['superadmin_authenticated']) ? 'superadmin_panel.php' : 'admin_dashboard.php'],
    'register_candidate_bigfive.php' => ['title' => 'Registrar Candidato Big Five', 'back' => 'view_candidates_bigfive.php'],
    'view_candidates_bigfive.php' => ['title' => 'Candidatos Big Five', 'back' => isset($_SESSION['superadmin_authenticated']) ? 'superadmin_panel.php' : 'admin_dashboard.php'],
    'admin_dashboard.php' => ['title' => 'Painel do Administrador', 'back' => ''],
    'reports.php' => ['title' => 'Relatórios', 'back' => 'admin_dashboard.php'],
    'comparison.php' => ['title' => 'DISC vs. MBTI vs. Big Five', 'back' => isset($_SESSION['superadmin_authenticated']) ? 'superadmin_dashboard.php' : 'admin_dashboard.php']
];

$page_info = isset($page_config[$current_page]) ? $page_config[$current_page] : ['title' => 'Sistema DISC/MBTI', 'back' => ''];

// URL do sistema
$home_url = "/disc/";

?>

<div class="navigation-header mb-4">
    <div class="d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center">
            <a href="<?php echo htmlspecialchars($home_url); ?>" class="me-4">
                <img src="./assets/images/LOGO-Sys-Manager-horizontal-COLOR.png" alt="SysManager Logo" height="40">
            </a>

            <?php if ($page_info['back']): ?>
            <a href="<?php echo htmlspecialchars($page_info['back']); ?>" class="btn btn-outline-primary me-2">
                <i class="bi bi-arrow-left"></i> Voltar
            </a>
            <?php endif; ?>
            
            <a href="<?php echo htmlspecialchars($home_url); ?>" class="btn btn-outline-secondary">
                <i class="bi bi-house"></i> Home
            </a>

            <?php if (isset($_SESSION['admin_authenticated']) || isset($_SESSION['superadmin_authenticated'])): ?>
            <div class="dropdown d-inline-block ms-2">
                <button class="btn btn-primary dropdown-toggle" type="button" id="avaliacoesDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-clipboard-check"></i> Avaliações
                </button>
                <ul class="dropdown-menu" aria-labelledby="avaliacoesDropdown">
                    <li><h6 class="dropdown-header">DISC</h6></li>
                    <li><a class="dropdown-item" href="register_candidate.php"><i class="bi bi-person-plus"></i> Novo Candidato</a></li>
                    <li><a class="dropdown-item" href="view_candidates.php"><i class="bi bi-people"></i> Ver Candidatos</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><h6 class="dropdown-header">MBTI</h6></li>
                    <li><a class="dropdown-item" href="register_candidate_mbti.php"><i class="bi bi-person-plus"></i> Novo Candidato</a></li>
                    <li><a class="dropdown-item" href="view_candidates_mbti.php"><i class="bi bi-people"></i> Ver Candidatos</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><h6 class="dropdown-header">Big Five</h6></li>
                    <li><a class="dropdown-item" href="register_candidate_bigfive.php"><i class="bi bi-person-plus"></i> Novo Candidato</a></li>
                    <li><a class="dropdown-item" href="view_candidates_bigfive.php"><i class="bi bi-people"></i> Ver Candidatos</a></li>
                </ul>
            </div>

            <a href="comparison.php" class="btn btn-info ms-2">
                <i class="bi bi-info-circle"></i> DISC vs. MBTI vs. Big Five
            </a>
            <?php endif; ?>
        </div>
        
        <h2 class="mb-0"><?php echo htmlspecialchars($page_info['title']); ?></h2>
        
        <div>
            <span class="me-2">
                Olá, <?php echo htmlspecialchars(isset($_SESSION['superadmin_nome']) ? $_SESSION['superadmin_nome'] : $_SESSION['admin_nome']); ?>
            </span>
            <a href="logout.php" class="btn btn-secondary">
                <i class="bi bi-box-arrow-right"></i> Sair
            </a>
        </div>
    </div>
</div>

<style>
.navigation-header {
    background-color: #fff;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.navigation-header h2 {
    color: #2c3e50;
    font-size: 1.5rem;
}

.btn-outline-primary, .btn-outline-secondary {
    border-width: 2px;
}

.btn-outline-primary:hover, .btn-outline-secondary:hover {
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
</style>
