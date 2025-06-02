<?php
class ChatGPTAnalyzer {
    private $api_key;
    private $model;
    private $db;
    
    public function __construct($db = null) {
        $config = require __DIR__ . '/../config/api_config.php';
        $this->api_key = $config['openai_api_key'];
        $this->model = $config['model'];
        $this->db = $db;
    }
    
    public function analyzeTestResults($testType, $results, $testResultId = null) {
        // Se temos um ID de resultado e conexão com o banco, tentamos buscar do cache
        if ($testResultId && $this->db) {
            $cachedAnalysis = $this->getCachedAnalysis($testResultId);
            if ($cachedAnalysis) {
                return $cachedAnalysis;
            }
        }
        
        // Se não encontrou no cache ou não temos ID, gera nova análise
        $prompt = $this->generatePrompt($testType, $results);
        $analysis = $this->callChatGPT($prompt);
        
        // Se temos ID e conexão com o banco, salvamos no cache
        if ($testResultId && $this->db && $analysis) {
            $this->cacheAnalysis($testResultId, $analysis);
        }
        
        return $analysis;
    }
    
    private function generatePrompt($testType, $results) {
        switch ($testType) {
            case 'disc':
                return $this->generateDiscPrompt($results);
            case 'mbti':
                return $this->generateMbtiPrompt($results);
            case 'bigfive':
                return $this->generateBigFivePrompt($results);
            case 'jss':
                return $this->generateJssPrompt($results);
            default:
                throw new Exception("Tipo de teste não suportado");
        }
    }
    
    private function generateDiscPrompt($results) {
        $counts = [
            'D' => 0, 'I' => 0, 'S' => 0, 'C' => 0
        ];
        
        foreach ($results as $answer) {
            if (isset($counts[$answer])) {
                $counts[$answer] += 5;
            }
        }
        
        return "Analise o seguinte perfil DISC:\n" .
               "Dominância (D): {$counts['D']}%\n" .
               "Influência (I): {$counts['I']}%\n" .
               "Estabilidade (S): {$counts['S']}%\n" .
               "Conformidade (C): {$counts['C']}%\n\n" .
               "Forneça uma análise detalhada do perfil comportamental, incluindo:\n" .
               "1. Principais características\n" .
               "2. Pontos fortes\n" .
               "3. Possíveis áreas de desenvolvimento\n" .
               "4. Sugestões para comunicação efetiva com este perfil";
    }
    
    private function generateMbtiPrompt($results) {
        return "Analise o seguinte perfil MBTI {$results['type']}:\n" .
               "E/I: {$results['dimensions']['E']}/{$results['dimensions']['I']}\n" .
               "S/N: {$results['dimensions']['S']}/{$results['dimensions']['N']}\n" .
               "T/F: {$results['dimensions']['T']}/{$results['dimensions']['F']}\n" .
               "J/P: {$results['dimensions']['J']}/{$results['dimensions']['P']}\n\n" .
               "Forneça uma análise detalhada do tipo de personalidade, incluindo:\n" .
               "1. Características principais\n" .
               "2. Estilo de trabalho\n" .
               "3. Comunicação preferida\n" .
               "4. Possíveis carreiras compatíveis";
    }
    
    private function generateBigFivePrompt($results) {
        $dimensions = $results['dimensions'];
        return "Analise o seguinte perfil Big Five:\n" .
               "Abertura à Experiência: {$dimensions['Abertura']} de 5\n" .
               "Conscienciosidade: {$dimensions['Conscienciosidade']} de 5\n" .
               "Extroversão: {$dimensions['Extroversão']} de 5\n" .
               "Amabilidade: {$dimensions['Amabilidade']} de 5\n" .
               "Neuroticismo: {$dimensions['Neuroticismo']} de 5\n\n" .
               "Forneça uma análise detalhada da personalidade, incluindo:\n" .
               "1. Interpretação de cada dimensão\n" .
               "2. Pontos fortes no ambiente profissional\n" .
               "3. Sugestões para desenvolvimento pessoal\n" .
               "4. Compatibilidade com diferentes tipos de trabalho";
    }
    
    private function generateJssPrompt($results) {
        $content = "Analise os seguintes níveis de estresse ocupacional:\n";
        foreach ($results['scores'] as $category => $data) {
            $content .= "{$category}: {$data['average']} de 5\n";
        }
        $content .= "\nForneça uma análise detalhada, incluindo:\n" .
                   "1. Principais fontes de estresse identificadas\n" .
                   "2. Possíveis impactos no desempenho e bem-estar\n" .
                   "3. Recomendações para gestão do estresse\n" .
                   "4. Sugestões para melhorias no ambiente de trabalho";
        return $content;
    }
    
    private function getCachedAnalysis($testResultId) {
        try {
            $stmt = $this->db->prepare("
                SELECT analysis_text 
                FROM test_results_ai_analysis 
                WHERE test_result_id = ?
            ");
            $stmt->execute([$testResultId]);
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            
            return $result ? $result['analysis_text'] : null;
        } catch (Exception $e) {
            error_log("Erro ao buscar análise em cache: " . $e->getMessage());
            return null;
        }
    }
    
    private function cacheAnalysis($testResultId, $analysis) {
        try {
            // Primeiro verifica se já existe uma análise para este resultado
            $stmt = $this->db->prepare("
                SELECT id FROM test_results_ai_analysis 
                WHERE test_result_id = ?
            ");
            $stmt->execute([$testResultId]);
            $existing = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($existing) {
                // Atualiza análise existente
                $stmt = $this->db->prepare("
                    UPDATE test_results_ai_analysis 
                    SET analysis_text = ?, 
                        created_at = CURRENT_TIMESTAMP 
                    WHERE test_result_id = ?
                ");
                $stmt->execute([$analysis, $testResultId]);
            } else {
                // Insere nova análise
                $stmt = $this->db->prepare("
                    INSERT INTO test_results_ai_analysis 
                    (test_result_id, analysis_text) 
                    VALUES (?, ?)
                ");
                $stmt->execute([$testResultId, $analysis]);
            }
        } catch (Exception $e) {
            error_log("Erro ao salvar análise em cache: " . $e->getMessage());
        }
    }
    
    private function callChatGPT($prompt) {
        $url = 'https://api.openai.com/v1/chat/completions';
        $headers = [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $this->api_key
        ];
        
        $data = [
            'model' => $this->model,
            'messages' => [
                [
                    'role' => 'system',
                    'content' => 'Você é um especialista em análise de testes psicométricos e comportamentais.'
                ],
                [
                    'role' => 'user',
                    'content' => $prompt
                ]
            ],
            'temperature' => 0.7,
            'max_tokens' => 800
        ];
        
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        
        $response = curl_exec($ch);
        $error = curl_error($ch);
        curl_close($ch);
        
        if ($error) {
            throw new Exception("Erro na chamada da API: " . $error);
        }
        
        $result = json_decode($response, true);
        if (isset($result['error'])) {
            throw new Exception("Erro da API do ChatGPT: " . $result['error']['message']);
        }
        
        return $result['choices'][0]['message']['content'];
    }
}
