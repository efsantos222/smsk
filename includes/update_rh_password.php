<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    $email = 'recursoshumanos@sysmanager.com.br';
    $newPassword = 'sysmanager25';
    
    // Hash MD5 da nova senha
    $passwordHash = md5($newPassword);
    
    // Atualizar senha do usuário RH
    $stmt = $db->prepare("UPDATE users SET password = ? WHERE email = ? AND role = 'superadmin'");
    $result = $stmt->execute([$passwordHash, $email]);
    
    if ($result && $stmt->rowCount() > 0) {
        echo "Senha atualizada com sucesso para o usuário RH:\n";
        echo "Email: $email\n";
        echo "Nova senha: $newPassword\n";
        echo "Novo hash MD5: $passwordHash\n";
    } else {
        echo "Erro ao atualizar senha ou usuário não encontrado\n";
    }
    
} catch (PDOException $e) {
    echo "Erro: " . $e->getMessage() . "\n";
}
