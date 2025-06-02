CREATE TABLE IF NOT EXISTS test_results_ai_analysis (
    id INT PRIMARY KEY AUTO_INCREMENT,
    test_result_id INT NOT NULL,
    analysis_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (test_result_id) REFERENCES test_results(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
