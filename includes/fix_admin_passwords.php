<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    // Configuração dos admins
    $admins = [
        [
            'email' => 'recursoshumanos@sysmanager.com.br',
            'password' => 'SysManager25',
            'role' => 'superadmin',
            'name' => 'Recursos Humanos'
        ],
        [
            'email' => 'ezequielsantos@sysmanager.com.br',
            'password' => 'sysmanager25',
            'role' => 'superadmin',
            'name' => 'Ezequiel Santos'
        ]
    ];
    
    // Primeiro, remover os usuários existentes para evitar conflitos
    $stmt = $db->prepare("DELETE FROM users WHERE email IN (?, ?)");
    $stmt->execute([$admins[0]['email'], $admins[1]['email']]);
    
    foreach ($admins as $admin) {
        // Hash MD5 da senha
        $passwordHash = md5($admin['password']);
        
        // Inserir admin
        $stmt = $db->prepare("INSERT INTO users (email, password, role, name) VALUES (?, ?, ?, ?)");
        $result = $stmt->execute([$admin['email'], $passwordHash, $admin['role'], $admin['name']]);
        
        if ($result) {
            echo "Usuário criado/atualizado com sucesso:\n";
            echo "Email: {$admin['email']}\n";
            echo "Role: {$admin['role']}\n";
            echo "Nome: {$admin['name']}\n";
            echo "Hash MD5: $passwordHash\n";
            echo "------------------------\n";
        } else {
            echo "Erro ao criar/atualizar: {$admin['email']}\n";
        }
    }
    
    echo "\nProcesso de atualização concluído!\n";
    
} catch (PDOException $e) {
    echo "Erro ao atualizar senhas: " . $e->getMessage() . "\n";
}
