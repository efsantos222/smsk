<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    $email = 'daniel.cesar@sysmanager.com.br';
    $password = 'sysmanager25';
    
    // Hash MD5 da senha
    $passwordHash = md5($password);
    
    // Atualizar senha do candidato
    $stmt = $db->prepare("UPDATE candidates SET password = ? WHERE email = ?");
    $result = $stmt->execute([$passwordHash, $email]);
    
    if ($result && $stmt->rowCount() > 0) {
        echo "Senha atualizada com sucesso para o candidato:\n";
        echo "Email: $email\n";
        echo "Hash MD5: $passwordHash\n";
    } else {
        echo "Erro ao atualizar senha ou candidato não encontrado\n";
    }
    
} catch (PDOException $e) {
    echo "Erro: " . $e->getMessage() . "\n";
}
