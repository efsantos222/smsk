<?php
require_once 'db.php';

try {
    $db = getDbConnection();
    
    // Verificar usuários admin/superadmin
    $stmt = $db->query("SELECT id, email, role, password FROM users WHERE role IN ('admin', 'superadmin')");
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo "=== Usuários Admin/Superadmin encontrados ===\n";
    foreach ($users as $user) {
        echo "ID: {$user['id']}\n";
        echo "Email: {$user['email']}\n";
        echo "Role: {$user['role']}\n";
        echo "Password Hash: {$user['password']}\n";
        echo "------------------------\n";
    }
    
    if (empty($users)) {
        echo "Nenhum usuário admin/superadmin encontrado!\n";
    }
    
} catch (PDOException $e) {
    echo "Erro: " . $e->getMessage() . "\n";
}
