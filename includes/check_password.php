<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    $email = 'pdl2025@sysmanager.com.br';
    
    // Verificar a senha atual no banco
    $stmt = $db->prepare("SELECT id, name, password FROM users WHERE email = ? AND role = 'selector'");
    $stmt->execute([$email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($user) {
        echo "Usuário encontrado:\n";
        echo "ID: " . $user['id'] . "\n";
        echo "Nome: " . $user['name'] . "\n";
        echo "Hash atual da senha: " . $user['password'] . "\n";
        
        // Mostrar o hash MD5 que deveria estar
        echo "\nHash MD5 que deveria estar: " . md5('sysmanager25') . "\n";
    } else {
        echo "Usuário não encontrado\n";
    }
    
} catch (PDOException $e) {
    echo "Erro: " . $e->getMessage() . "\n";
}
