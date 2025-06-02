<?php
function getDbConnection() {
    $host = 'localhost';
    $dbname = 'efsantos_disc_sysmanager';
    $username = 'efsantos_disc';
    $password = 'Kyew1802';

    try {
        $db = new PDO(
            "mysql:host=$host;dbname=$dbname;charset=utf8mb4",
            $username,
            $password,
            [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"
            ]
        );
        return $db;
    } catch (PDOException $e) {
        error_log("Erro de conexão com o banco: " . $e->getMessage());
        throw new Exception("Erro ao conectar com o banco de dados");
    }
}
