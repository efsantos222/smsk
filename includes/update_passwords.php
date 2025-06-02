<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    // Atualizar senhas na tabela users (seletores)
    $stmt = $db->prepare("SELECT id, password FROM users WHERE role = 'selector'");
    $stmt->execute();
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($users as $user) {
        // Converte a senha atual para MD5
        $md5Password = md5($user['password']);
        
        // Atualiza no banco
        $updateStmt = $db->prepare("UPDATE users SET password = ? WHERE id = ?");
        $updateStmt->execute([$md5Password, $user['id']]);
        
        echo "Senha atualizada para o usuário ID: {$user['id']}\n";
    }
    
    // Atualizar senhas na tabela candidates
    $stmt = $db->prepare("SELECT id, password FROM candidates");
    $stmt->execute();
    $candidates = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach ($candidates as $candidate) {
        // Converte a senha atual para MD5
        $md5Password = md5($candidate['password']);
        
        // Atualiza no banco
        $updateStmt = $db->prepare("UPDATE candidates SET password = ? WHERE id = ?");
        $updateStmt->execute([$md5Password, $candidate['id']]);
        
        echo "Senha atualizada para o candidato ID: {$candidate['id']}\n";
    }
    
    echo "\nTodas as senhas foram atualizadas com sucesso para o formato MD5!\n";
    
} catch (PDOException $e) {
    echo "Erro ao atualizar senhas: " . $e->getMessage() . "\n";
}
