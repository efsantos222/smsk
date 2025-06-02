<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    // Hash MD5 da senha 'sysmanager25'
    $correctPassword = md5('sysmanager25');
    
    // Lista de emails para atualizar
    $emails = [
        'pdl2025@sysmanager.com.br',
        'ezequiel.santos@sysmanager.com.br',
        'ezequielsantos@sysmanager.com.br',
        'karen.ribeiro@sysmanager.com.br',
        'ana.reis@sysmanager.com.br',
        'caroline.daudt@sysmanager.com.br',
        'tamires.lourenco@sysmanager.com.br'
    ];
    
    // Atualizar senha para cada usuário
    foreach ($emails as $email) {
        $stmt = $db->prepare("UPDATE users SET password = ? WHERE email = ? AND role = 'selector'");
        $result = $stmt->execute([$correctPassword, $email]);
        
        if ($result && $stmt->rowCount() > 0) {
            echo "Senha atualizada com sucesso para o usuário: $email\n";
        } else {
            echo "Nenhuma atualização necessária para: $email\n";
        }
    }
    
    echo "\nProcesso de atualização concluído!\n";
    
} catch (PDOException $e) {
    echo "Erro ao atualizar senhas: " . $e->getMessage() . "\n";
}
