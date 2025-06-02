<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    $email = 'recursoshumanos@sysmanager.com.br';
    $password = 'SysManager25';
    $role = 'superadmin';
    $name = 'Recursos Humanos';
    
    // Hash MD5 da senha
    $passwordHash = md5($password);
    
    // Inserir usuário RH
    $stmt = $db->prepare("INSERT INTO users (email, password, role, name) VALUES (?, ?, ?, ?)");
    $result = $stmt->execute([$email, $passwordHash, $role, $name]);
    
    if ($result) {
        echo "Usuário RH criado com sucesso:\n";
        echo "Email: $email\n";
        echo "Role: $role\n";
        echo "Nome: $name\n";
        echo "Hash MD5: $passwordHash\n";
    } else {
        echo "Erro ao criar usuário RH\n";
    }
    
} catch (PDOException $e) {
    echo "Erro: " . $e->getMessage() . "\n";
}
