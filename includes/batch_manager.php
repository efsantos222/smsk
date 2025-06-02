<?php
class BatchManager {
    private $db;

    public function __construct($db) {
        $this->db = $db;
    }

    /**
     * Busca todos os batches (grupos) de testes de um candidato
     * Agrupados por data de conclusão
     */
    public function getCandidateBatches($candidateId) {
        error_log("Debug - Getting batches for candidate: " . $candidateId);
        
        $stmt = $this->db->prepare("
            SELECT 
                DATE(completed_at) as batch_date,
                COUNT(*) as completed_tests,
                MIN(completed_at) as created_at
            FROM test_results
            WHERE candidate_id = ?
            GROUP BY DATE(completed_at)
            ORDER BY completed_at DESC
        ");
        
        $stmt->execute([$candidateId]);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        error_log("Debug - Found batches: " . print_r($results, true));
        return $results;
    }

    /**
     * Busca resultados de um batch (grupo) específico por data
     */
    public function getBatchResults($batchDate, $candidateId) {
        error_log("Debug - Getting results for date: " . $batchDate . " and candidate: " . $candidateId);
        
        $stmt = $this->db->prepare("
            SELECT 
                id,
                test_type,
                results,
                completed_at
            FROM test_results
            WHERE candidate_id = ?
            AND DATE(completed_at) = ?
            ORDER BY completed_at
        ");
        
        $stmt->execute([$candidateId, $batchDate]);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        error_log("Debug - Found results: " . print_r($results, true));
        return $results;
    }

    /**
     * Verifica se um candidato pode iniciar novos testes
     * Agora verifica se há testes atribuídos não completados
     */
    public function canStartNewTests($candidateId) {
        $stmt = $this->db->prepare("
            SELECT 
                COUNT(ta.id) as total_assignments,
                COUNT(tr.id) as completed_tests
            FROM test_assignments ta
            LEFT JOIN test_results tr ON ta.candidate_id = tr.candidate_id 
                AND ta.test_type = tr.test_type
            WHERE ta.candidate_id = ?
        ");
        $stmt->execute([$candidateId]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        return $result['total_assignments'] === $result['completed_tests'];
    }
}
