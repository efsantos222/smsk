-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 02/06/2025 às 12:12
-- Versão do servidor: 5.7.23-23
-- Versão do PHP: 8.1.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `efsantos_disc_sysmanager`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `bigfive_questions`
--

CREATE TABLE `bigfive_questions` (
  `id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `dimension` enum('Abertura','Conscienciosidade','Extroversao','Amabilidade','Neuroticismo') NOT NULL,
  `is_inverse` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `bigfive_questions`
--

INSERT INTO `bigfive_questions` (`id`, `question_text`, `dimension`, `is_inverse`, `created_at`) VALUES
(1, 'Gosto de explorar ideias novas e diferentes.', 'Abertura', 0, '2025-03-26 13:14:44'),
(2, 'Tenho uma imaginação ativa e criativa.', 'Abertura', 0, '2025-03-26 13:14:44'),
(3, 'Gosto de aprender sobre tópicos variados.', 'Abertura', 0, '2025-03-26 13:14:44'),
(4, 'Prefiro a novidade em vez de rotinas previsíveis.', 'Abertura', 0, '2025-03-26 13:14:44'),
(5, 'Sou curioso(a) sobre muitas coisas.', 'Abertura', 0, '2025-03-26 13:14:44'),
(6, 'Sou aberto(a) a mudanças e experiências diferentes.', 'Abertura', 0, '2025-03-26 13:14:44'),
(7, 'Gosto de arte, música ou literatura que me faz pensar.', 'Abertura', 0, '2025-03-26 13:14:44'),
(8, 'Prefiro seguir tradições e evitar mudanças.', 'Abertura', 1, '2025-03-26 13:14:44'),
(9, 'Sou organizado(a) e metódico(a).', 'Conscienciosidade', 0, '2025-03-26 13:14:44'),
(10, 'Presto atenção aos detalhes.', 'Conscienciosidade', 0, '2025-03-26 13:14:44'),
(11, 'Planejo antes de agir.', 'Conscienciosidade', 0, '2025-03-26 13:14:44'),
(12, 'Sou responsável e cumpro minhas obrigações.', 'Conscienciosidade', 0, '2025-03-26 13:14:44'),
(13, 'Persisto até concluir tarefas.', 'Conscienciosidade', 0, '2025-03-26 13:14:44'),
(14, 'Sou disciplinado(a) e focado(a).', 'Conscienciosidade', 0, '2025-03-26 13:14:44'),
(15, 'Procrastino e deixo tarefas para depois.', 'Conscienciosidade', 1, '2025-03-26 13:14:44'),
(16, 'Sou extrovertido(a) e sociável.', 'Extroversao', 0, '2025-03-26 13:14:44'),
(17, 'Gosto de estar com pessoas.', 'Extroversao', 0, '2025-03-26 13:14:44'),
(18, 'Inicio conversas facilmente.', 'Extroversao', 0, '2025-03-26 13:14:44'),
(19, 'Sinto-me energizado(a) em grupos.', 'Extroversao', 0, '2025-03-26 13:14:44'),
(20, 'Expresso minhas opiniões com facilidade.', 'Extroversao', 0, '2025-03-26 13:14:44'),
(21, 'Prefiro ficar sozinho(a).', 'Extroversao', 1, '2025-03-26 13:14:44'),
(22, 'Sou reservado(a) em situações sociais.', 'Extroversao', 1, '2025-03-26 13:14:44'),
(23, 'Sou gentil e atencioso(a) com outros.', 'Amabilidade', 0, '2025-03-26 13:14:44'),
(24, 'Procuro ajudar as pessoas.', 'Amabilidade', 0, '2025-03-26 13:14:44'),
(25, 'Considero os sentimentos dos outros.', 'Amabilidade', 0, '2025-03-26 13:14:44'),
(26, 'Coopero em trabalhos em grupo.', 'Amabilidade', 0, '2025-03-26 13:14:44'),
(27, 'Perdoo facilmente.', 'Amabilidade', 0, '2025-03-26 13:14:44'),
(28, 'Sou crítico(a) com outros.', 'Amabilidade', 1, '2025-03-26 13:14:44'),
(29, 'Tenho dificuldade em confiar nas pessoas.', 'Amabilidade', 1, '2025-03-26 13:14:44'),
(30, 'Mantenho a calma sob pressão.', 'Neuroticismo', 1, '2025-03-26 13:14:44'),
(31, 'Lido bem com estresse.', 'Neuroticismo', 1, '2025-03-26 13:14:44'),
(32, 'Adapto-me facilmente a mudanças.', 'Neuroticismo', 1, '2025-03-26 13:14:44'),
(33, 'Mantenho o otimismo em situações difíceis.', 'Neuroticismo', 1, '2025-03-26 13:14:44'),
(34, 'Sou emocionalmente estável.', 'Neuroticismo', 1, '2025-03-26 13:14:44'),
(35, 'Preocupo-me excessivamente.', 'Neuroticismo', 0, '2025-03-26 13:14:44'),
(36, 'Fico ansioso(a) facilmente.', 'Neuroticismo', 0, '2025-03-26 13:14:44'),
(37, 'Mudo de humor com frequência.', 'Neuroticismo', 0, '2025-03-26 13:14:44'),
(38, 'Sinto-me facilmente estressado(a).', 'Neuroticismo', 0, '2025-03-26 13:14:44'),
(39, 'Tenho pensamentos negativos recorrentes.', 'Neuroticismo', 0, '2025-03-26 13:14:44'),
(40, 'Sinto-me sobrecarregado(a) com problemas.', 'Neuroticismo', 0, '2025-03-26 13:14:44');

-- --------------------------------------------------------

--
-- Estrutura para tabela `candidates`
--

CREATE TABLE `candidates` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cargo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selector_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `candidates`
--

INSERT INTO `candidates` (`id`, `name`, `email`, `password`, `cargo`, `selector_id`, `created_at`) VALUES
(12, 'Daniel César', 'daniel.cesar@sysmanager.com.br', '6e7e011c955bba98ab8652251376af4f', 'Gestor', 7, '2025-04-14 13:57:53'),
(13, 'Paulo Felipe', 'paulo.felipe@sysmanager.com.br', '426d2c23700c6b0d9885b145b2113f4a', 'Coordenador', 7, '2025-04-24 17:43:25'),
(15, 'Allana Caetano', 'allana.caetano@sysmanager.com.br', '123456', 'Assistente de Recursos Humanos', 26, '2025-04-24 17:50:30'),
(20, 'Karen Ribeiro', 'karen.ribeiro@sysmanager.com.br', 'eb1f2d5f3e478b7236166e61887e326a', 'Analista de R&S', 17, '2025-04-29 14:48:14'),
(21, 'Karen Ribeiro', 'karenribeiro.nave@gmail.com', 'f4d158dee80d6dd131b1e863f740ec05', 'Analista de R&S', 17, '2025-04-29 17:57:20'),
(22, 'Ana Laura Silva dos Reis', 'ana.reis@sysmanager.com.br', 'c6c414a47db5b32d41a9e92e82ca9190', 'Assistente de RH', 18, '2025-05-14 15:03:56'),
(23, 'Tamires Lourenco', 'tamires.lourenco@sysmanager.com.br', '206e394869c484dcdf51aa4f5fe4b0a8', 'Coord. de DHO', 21, '2025-05-16 16:58:32'),
(24, 'Jaqueline da Silva Amorim', 'jaquelineamorim90@gmail.com', '41343740c70b1655a14aad289db87f8b', 'Assistente', 27, '2025-05-16 17:10:32'),
(25, 'Ezequiel Ferreira', 'efsantos22@hotmail.com', 'ab8154e4f85b2b1d991022dde58c4d4f', 'Analista de TI', 7, '2025-05-28 20:40:24');

-- --------------------------------------------------------

--
-- Estrutura para tabela `disc_questions`
--

CREATE TABLE `disc_questions` (
  `id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_d` text NOT NULL,
  `option_i` text NOT NULL,
  `option_s` text NOT NULL,
  `option_c` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `disc_questions`
--

INSERT INTO `disc_questions` (`id`, `question_text`, `option_d`, `option_i`, `option_s`, `option_c`, `created_at`) VALUES
(1, 'Em uma situação de trabalho, eu geralmente sou...', 'Direto e decisivo', 'Interativo e amigável', 'Estável e paciente', 'Cauteloso e preciso', '2025-03-26 13:17:34'),
(2, 'Quando lido com problemas, eu...', 'Tomo ação imediata', 'Envolvo outros', 'Sou paciente', 'Analiso cuidadosamente', '2025-03-26 13:17:34'),
(3, 'Ao me comunicar, eu...', 'Sou direto', 'Sou expressivo', 'Sou diplomático', 'Sou sistemático', '2025-03-26 13:17:34'),
(4, 'Em projetos, eu prefiro...', 'Liderar', 'Colaborar', 'Dar suporte', 'Organizar detalhes', '2025-03-26 13:17:34'),
(5, 'Quando tomo decisões, eu...', 'Decido rapidamente', 'Considero pessoas', 'Busco consenso', 'Analiso opções', '2025-03-26 13:17:34'),
(6, 'Em reuniões, eu...', 'Vou direto ao ponto', 'Compartilho ideias', 'Ouço atentamente', 'Sigo a agenda', '2025-03-26 13:17:34'),
(7, 'Com prazos, eu...', 'Estabeleço urgência', 'Sou flexível', 'Mantenho rotina', 'Sigo cronograma', '2025-03-26 13:17:34'),
(8, 'Ao resolver conflitos, eu...', 'Enfrento diretamente', 'Expresso sentimentos', 'Busco harmonia', 'Sigo procedimentos', '2025-03-26 13:17:34'),
(9, 'Em equipe, eu valorizo...', 'Resultados', 'Criatividade', 'Cooperação', 'Qualidade', '2025-03-26 13:17:34'),
(10, 'Sob pressão, eu...', 'Tomo controle', 'Motivo outros', 'Mantenho calma', 'Sigo regras', '2025-03-26 13:17:34'),
(11, 'Minha abordagem é...', 'Direta e objetiva', 'Entusiasta', 'Estável', 'Estruturada', '2025-03-26 13:17:34'),
(12, 'Em mudanças, eu...', 'Inicio ação', 'Abraço novidades', 'Mantenho rotina', 'Avalio impactos', '2025-03-26 13:17:34'),
(13, 'Meu foco está em...', 'Objetivos', 'Pessoas', 'Processos', 'Procedimentos', '2025-03-26 13:17:34'),
(14, 'Minha prioridade é...', 'Resultados', 'Interação', 'Estabilidade', 'Precisão', '2025-03-26 13:17:34'),
(15, 'Em desafios, eu...', 'Enfrento', 'Inspiro', 'Apoio', 'Analiso', '2025-03-26 13:17:34'),
(16, 'Ao planejar, eu...', 'Defino metas', 'Gero ideias', 'Mantenho padrões', 'Crio sistemas', '2025-03-26 13:17:34'),
(17, 'Em discussões, eu...', 'Argumento pontos', 'Expresso opiniões', 'Busco acordo', 'Verifico fatos', '2025-03-26 13:17:34'),
(18, 'Meu estilo é...', 'Assertivo', 'Persuasivo', 'Persistente', 'Perfeccionista', '2025-03-26 13:17:34'),
(19, 'Em grupo, eu...', 'Assumo liderança', 'Socializo', 'Coopero', 'Organizo', '2025-03-26 13:17:34'),
(20, 'Ao delegar, eu...', 'Dou direções', 'Motivo equipe', 'Ofereço suporte', 'Detalho tarefas', '2025-03-26 13:17:34');

-- --------------------------------------------------------

--
-- Estrutura para tabela `jss_questions`
--

CREATE TABLE `jss_questions` (
  `id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `category` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `jss_questions`
--

INSERT INTO `jss_questions` (`id`, `question_text`, `category`, `created_at`) VALUES
(1, 'Cumprir prazos muito curtos para entrega de trabalhos', 'Pressão Temporal', '2025-03-26 13:18:25'),
(2, 'Receber cobranças excessivas por resultados', 'Pressão por Desempenho', '2025-03-26 13:18:25'),
(3, 'Lidar com sobrecarga de trabalho e múltiplas demandas', 'Sobrecarga', '2025-03-26 13:18:25'),
(4, 'Ter que tomar decisões importantes com pouco tempo', 'Pressão Temporal', '2025-03-26 13:18:25'),
(5, 'Ser avaliado constantemente por superiores', 'Pressão por Desempenho', '2025-03-26 13:18:25'),
(6, 'Trabalhar além do horário regular', 'Sobrecarga', '2025-03-26 13:18:25'),
(7, 'Ter que responder a múltiplas solicitações urgentes', 'Pressão Temporal', '2025-03-26 13:18:25'),
(8, 'Ser cobrado por metas difíceis de alcançar', 'Pressão por Desempenho', '2025-03-26 13:18:25'),
(9, 'Acumular funções diferentes no trabalho', 'Sobrecarga', '2025-03-26 13:18:25'),
(10, 'Ter que entregar resultados em prazos apertados', 'Pressão Temporal', '2025-03-26 13:18:25'),
(11, 'Ser avaliado por critérios muito exigentes', 'Pressão por Desempenho', '2025-03-26 13:18:25'),
(12, 'Ter que realizar muitas tarefas simultaneamente', 'Sobrecarga', '2025-03-26 13:18:25'),
(13, 'Ter pouco tempo para organizar as demandas', 'Pressão Temporal', '2025-03-26 13:18:25'),
(14, 'Receber feedback negativo sobre desempenho', 'Pressão por Desempenho', '2025-03-26 13:18:25'),
(15, 'Ter que assumir responsabilidades extras', 'Sobrecarga', '2025-03-26 13:18:25'),
(16, 'Lidar com mudanças frequentes de prioridades', 'Pressão Temporal', '2025-03-26 13:18:25'),
(17, 'Ser comparado com colegas mais produtivos', 'Pressão por Desempenho', '2025-03-26 13:18:25'),
(18, 'Não conseguir dar conta de todas as tarefas', 'Sobrecarga', '2025-03-26 13:18:25'),
(19, 'Ter que acelerar o ritmo de trabalho', 'Pressão Temporal', '2025-03-26 13:18:25'),
(20, 'Sentir que seu esforço não é reconhecido', 'Pressão por Desempenho', '2025-03-26 13:18:25');

-- --------------------------------------------------------

--
-- Estrutura para tabela `mbti_questions`
--

CREATE TABLE `mbti_questions` (
  `id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_a` text NOT NULL,
  `option_b` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `mbti_questions`
--

INSERT INTO `mbti_questions` (`id`, `question_text`, `option_a`, `option_b`, `created_at`) VALUES
(1, 'Em uma festa, você geralmente...', 'Interage com muitas pessoas diferentes', 'Interage com poucas pessoas que conhece bem', '2025-03-26 13:19:14'),
(2, 'Você se considera mais...', 'Realista e prático', 'Imaginativo e inovador', '2025-03-26 13:19:14'),
(3, 'É pior ser...', 'Injusto', 'Impiedoso', '2025-03-26 13:19:14'),
(4, 'Você é mais impressionado por...', 'Princípios', 'Emoções', '2025-03-26 13:19:14'),
(5, 'Você tende a ser mais...', 'Objetivo', 'Subjetivo', '2025-03-26 13:19:14'),
(6, 'Você prefere trabalhar...', 'Com prazos definidos', 'Apenas quando inspirado', '2025-03-26 13:19:14'),
(7, 'Você tende a escolher...', 'Com cuidado', 'Impulsivamente', '2025-03-26 13:19:14'),
(8, 'Em festas, você...', 'Fica até tarde, com energia crescente', 'Sai cedo, com energia decrescente', '2025-03-26 13:19:14'),
(9, 'Você é mais atraído por...', 'Pessoas sensatas', 'Pessoas criativas', '2025-03-26 13:19:14'),
(10, 'Você é mais interessado em...', 'O que é real', 'O que é possível', '2025-03-26 13:19:14'),
(11, 'Ao julgar outros, você é mais...', 'Imparcial', 'Compreensivo', '2025-03-26 13:19:14'),
(12, 'Ao abordar outros, você é mais...', 'Objetivo', 'Pessoal', '2025-03-26 13:19:14'),
(13, 'Você é mais...', 'Pontual', 'Despreocupado', '2025-03-26 13:19:14'),
(14, 'Você se incomoda mais tendo...', 'Coisas inacabadas', 'Coisas concluídas', '2025-03-26 13:19:14'),
(15, 'Em grupos, você...', 'Mantém-se atualizado', 'Fica por fora das notícias', '2025-03-26 13:19:14'),
(16, 'Ao fazer coisas comuns, você...', 'Faz da maneira usual', 'Faz da sua própria maneira', '2025-03-26 13:19:14'),
(17, 'Escritores deveriam...', 'Dizer o que pensam', 'Expressar com analogias', '2025-03-26 13:19:14'),
(18, 'Você é mais atraído por...', 'Consistência de pensamento', 'Relações humanas harmoniosas', '2025-03-26 13:19:14'),
(19, 'Você se sente mais confortável...', 'Com julgamentos lógicos', 'Com julgamentos de valor', '2025-03-26 13:19:14'),
(20, 'Você quer as coisas...', 'Resolvidas e decididas', 'Em aberto para mudanças', '2025-03-26 13:19:14');

-- --------------------------------------------------------

--
-- Estrutura para tabela `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `test_type` enum('disc','mbti','bigfive','jss') NOT NULL,
  `question_text` text NOT NULL,
  `options` json DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura para tabela `test_assignments`
--

CREATE TABLE `test_assignments` (
  `id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `test_type` enum('disc','mbti','bigfive','jss') COLLATE utf8mb4_unicode_ci NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `test_assignments`
--

INSERT INTO `test_assignments` (`id`, `candidate_id`, `test_type`, `assigned_by`, `created_at`) VALUES
(6, 12, 'disc', 7, '2025-04-14 13:57:53'),
(7, 12, 'mbti', 7, '2025-04-14 13:57:53'),
(8, 12, 'bigfive', 7, '2025-04-14 13:57:53'),
(9, 12, 'jss', 7, '2025-04-14 13:57:53'),
(10, 13, 'disc', 7, '2025-04-24 17:43:25'),
(11, 13, 'mbti', 7, '2025-04-24 17:43:25'),
(12, 13, 'bigfive', 7, '2025-04-24 17:43:25'),
(13, 13, 'jss', 7, '2025-04-24 17:43:25'),
(18, 15, 'disc', 26, '2025-04-24 17:50:30'),
(19, 15, 'mbti', 26, '2025-04-24 17:50:30'),
(20, 15, 'bigfive', 26, '2025-04-24 17:50:30'),
(21, 15, 'jss', 26, '2025-04-24 17:50:30'),
(38, 20, 'disc', 17, '2025-04-29 14:48:14'),
(39, 20, 'mbti', 17, '2025-04-29 14:48:14'),
(40, 20, 'bigfive', 17, '2025-04-29 14:48:14'),
(41, 20, 'jss', 17, '2025-04-29 14:48:14'),
(42, 21, 'mbti', 17, '2025-04-29 17:57:20'),
(43, 21, 'bigfive', 17, '2025-04-29 17:57:20'),
(44, 21, 'jss', 17, '2025-04-29 17:57:20'),
(45, 22, 'disc', 18, '2025-05-14 15:03:56'),
(46, 22, 'mbti', 18, '2025-05-14 15:03:56'),
(47, 22, 'bigfive', 18, '2025-05-14 15:03:56'),
(48, 22, 'jss', 18, '2025-05-14 15:03:56'),
(49, 23, 'disc', 21, '2025-05-16 16:58:32'),
(50, 23, 'mbti', 21, '2025-05-16 16:58:32'),
(51, 23, 'bigfive', 21, '2025-05-16 16:58:32'),
(52, 23, 'jss', 21, '2025-05-16 16:58:32'),
(53, 24, 'disc', 27, '2025-05-16 17:10:32'),
(54, 24, 'mbti', 27, '2025-05-16 17:10:32'),
(55, 24, 'bigfive', 27, '2025-05-16 17:10:32'),
(56, 24, 'jss', 27, '2025-05-16 17:10:32'),
(57, 25, 'disc', 7, '2025-05-28 20:40:24'),
(58, 25, 'mbti', 7, '2025-05-28 20:40:24'),
(59, 25, 'bigfive', 7, '2025-05-28 20:40:24'),
(60, 25, 'jss', 7, '2025-05-28 20:40:24');

-- --------------------------------------------------------

--
-- Estrutura para tabela `test_batches`
--

CREATE TABLE `test_batches` (
  `id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `test_questions`
--

CREATE TABLE `test_questions` (
  `id` int(11) NOT NULL,
  `test_type` enum('disc','rac') NOT NULL,
  `question` text NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `options` json NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura para tabela `test_results`
--

CREATE TABLE `test_results` (
  `id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `test_type` enum('disc','mbti','bigfive','jss') COLLATE utf8mb4_unicode_ci NOT NULL,
  `results` json DEFAULT NULL,
  `completed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `test_results`
--

INSERT INTO `test_results` (`id`, `candidate_id`, `test_type`, `results`, `completed_at`) VALUES
(2, 12, 'disc', '{\"1\": \"D\", \"2\": \"C\", \"3\": \"I\", \"4\": \"S\", \"5\": \"C\", \"6\": \"C\", \"7\": \"S\", \"8\": \"D\", \"9\": \"I\", \"10\": \"S\", \"11\": \"C\", \"12\": \"D\", \"13\": \"D\", \"14\": \"I\", \"15\": \"D\", \"16\": \"I\", \"17\": \"S\", \"18\": \"I\", \"19\": \"S\", \"20\": \"D\"}', '2025-04-14 14:27:27'),
(3, 12, 'mbti', '{\"type\": \"ESTP\", \"answers\": {\"1\": \"A\", \"2\": \"A\", \"3\": \"B\", \"4\": \"B\", \"5\": \"A\", \"6\": \"A\", \"7\": \"B\", \"8\": \"A\", \"9\": \"A\", \"10\": \"B\", \"11\": \"B\", \"12\": \"B\", \"13\": \"A\", \"14\": \"A\", \"15\": \"B\", \"16\": \"A\", \"17\": \"A\", \"18\": \"B\", \"19\": \"A\", \"20\": \"A\"}, \"dimensions\": {\"E\": 3, \"F\": 2, \"I\": 2, \"J\": 1, \"N\": 0, \"P\": 4, \"S\": 5, \"T\": 3}}', '2025-04-14 14:28:12'),
(4, 12, 'bigfive', '{\"answers\": {\"1\": \"2\", \"2\": \"4\", \"3\": \"2\", \"4\": \"1\", \"5\": \"4\", \"6\": \"5\", \"7\": \"4\", \"8\": \"2\", \"9\": \"2\", \"10\": \"2\", \"11\": \"5\", \"12\": \"4\", \"13\": \"4\", \"14\": \"5\", \"15\": \"4\", \"16\": \"4\", \"17\": \"5\", \"18\": \"5\", \"19\": \"5\", \"20\": \"5\", \"21\": \"1\", \"22\": \"4\", \"23\": \"4\", \"24\": \"5\", \"25\": \"5\", \"26\": \"5\", \"27\": \"4\", \"28\": \"4\", \"29\": \"2\", \"30\": \"2\", \"31\": \"4\", \"32\": \"5\", \"33\": \"5\", \"34\": \"5\", \"35\": \"5\", \"36\": \"2\", \"37\": \"1\", \"38\": \"4\", \"39\": \"1\", \"40\": \"1\"}, \"dimensions\": {\"Abertura\": 3.25, \"Amabilidade\": 4.14, \"Extroversao\": 4.43, \"Neuroticismo\": 2.09, \"Conscienciosidade\": 3.43}}', '2025-04-14 14:31:00'),
(5, 12, 'jss', '{\"scores\": {\"Sobrecarga\": {\"count\": 6, \"total\": 20, \"average\": 3.33}, \"Pressão Temporal\": {\"count\": 7, \"total\": 16, \"average\": 2.29}, \"Pressão por Desempenho\": {\"count\": 7, \"total\": 26, \"average\": 3.71}}, \"answers\": {\"1\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"2\": {\"severity\": \"1\", \"frequency\": \"5\"}, \"3\": {\"severity\": \"5\", \"frequency\": \"5\"}, \"4\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"5\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"6\": {\"severity\": \"5\", \"frequency\": \"5\"}, \"7\": {\"severity\": \"1\", \"frequency\": \"1\"}, \"8\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"9\": {\"severity\": \"4\", \"frequency\": \"4\"}, \"10\": {\"severity\": \"1\", \"frequency\": \"1\"}, \"11\": {\"severity\": \"4\", \"frequency\": \"4\"}, \"12\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"13\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"14\": {\"severity\": \"5\", \"frequency\": \"5\"}, \"15\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"16\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"17\": {\"severity\": \"5\", \"frequency\": \"5\"}, \"18\": {\"severity\": \"1\", \"frequency\": \"1\"}, \"19\": {\"severity\": \"4\", \"frequency\": \"4\"}, \"20\": {\"severity\": \"4\", \"frequency\": \"4\"}}}', '2025-04-14 14:45:30'),
(6, 13, 'disc', '{\"1\": \"D\", \"2\": \"S\", \"3\": \"I\", \"4\": \"S\", \"5\": \"I\", \"6\": \"S\", \"7\": \"D\", \"8\": \"C\", \"9\": \"D\", \"10\": \"S\", \"11\": \"S\", \"12\": \"D\", \"13\": \"D\", \"14\": \"S\", \"15\": \"C\", \"16\": \"I\", \"17\": \"I\", \"18\": \"S\", \"19\": \"S\", \"20\": \"I\"}', '2025-04-24 17:44:45'),
(7, 20, 'disc', '{\"1\": \"C\", \"2\": \"I\", \"3\": \"C\", \"4\": \"C\", \"5\": \"I\", \"6\": \"S\", \"7\": \"C\", \"8\": \"C\", \"9\": \"S\", \"10\": \"C\", \"11\": \"D\", \"12\": \"C\", \"13\": \"I\", \"14\": \"D\", \"15\": \"D\", \"16\": \"S\", \"17\": \"C\", \"18\": \"C\", \"19\": \"S\", \"20\": \"S\"}', '2025-04-29 14:53:08'),
(8, 21, 'mbti', '{\"type\": \"ESTP\", \"answers\": {\"1\": \"B\", \"2\": \"A\", \"3\": \"B\", \"4\": \"B\", \"5\": \"B\", \"6\": \"A\", \"7\": \"A\", \"8\": \"A\", \"9\": \"A\", \"10\": \"B\", \"11\": \"B\", \"12\": \"A\", \"13\": \"A\", \"14\": \"A\", \"15\": \"B\", \"16\": \"A\", \"17\": \"A\", \"18\": \"B\", \"19\": \"A\", \"20\": \"A\"}, \"dimensions\": {\"E\": 4, \"F\": 2, \"I\": 1, \"J\": 2, \"N\": 2, \"P\": 3, \"S\": 3, \"T\": 3}}', '2025-04-29 18:01:14'),
(9, 21, 'bigfive', '{\"answers\": {\"1\": \"4\", \"2\": \"2\", \"3\": \"4\", \"4\": \"5\", \"5\": \"4\", \"6\": \"4\", \"7\": \"2\", \"8\": \"2\", \"9\": \"5\", \"10\": \"4\", \"11\": \"5\", \"12\": \"5\", \"13\": \"4\", \"14\": \"2\", \"15\": \"4\", \"16\": \"3\", \"17\": \"4\", \"18\": \"1\", \"19\": \"3\", \"20\": \"2\", \"21\": \"1\", \"22\": \"3\", \"23\": \"4\", \"24\": \"5\", \"25\": \"5\", \"26\": \"5\", \"27\": \"2\", \"28\": \"5\", \"29\": \"2\", \"30\": \"1\", \"31\": \"2\", \"32\": \"4\", \"33\": \"2\", \"34\": \"3\", \"35\": \"5\", \"36\": \"5\", \"37\": \"4\", \"38\": \"4\", \"39\": \"3\", \"40\": \"4\"}, \"dimensions\": {\"Abertura\": 3.63, \"Amabilidade\": 3.71, \"Extroversao\": 3, \"Neuroticismo\": 3.91, \"Conscienciosidade\": 3.86}}', '2025-04-29 18:22:21'),
(10, 21, 'jss', '{\"scores\": {\"Sobrecarga\": {\"count\": 6, \"total\": 15, \"average\": 2.5}, \"Pressão Temporal\": {\"count\": 7, \"total\": 20.5, \"average\": 2.93}, \"Pressão por Desempenho\": {\"count\": 7, \"total\": 20, \"average\": 2.86}}, \"answers\": {\"1\": {\"severity\": \"4\", \"frequency\": \"3\"}, \"2\": {\"severity\": \"3\", \"frequency\": \"2\"}, \"3\": {\"severity\": \"3\", \"frequency\": \"2\"}, \"4\": {\"severity\": \"3\", \"frequency\": \"4\"}, \"5\": {\"severity\": \"2\", \"frequency\": \"4\"}, \"6\": {\"severity\": \"2\", \"frequency\": \"4\"}, \"7\": {\"severity\": \"2\", \"frequency\": \"3\"}, \"8\": {\"severity\": \"4\", \"frequency\": \"2\"}, \"9\": {\"severity\": \"2\", \"frequency\": \"1\"}, \"10\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"11\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"12\": {\"severity\": \"2\", \"frequency\": \"3\"}, \"13\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"14\": {\"severity\": \"4\", \"frequency\": \"2\"}, \"15\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"16\": {\"severity\": \"2\", \"frequency\": \"4\"}, \"17\": {\"severity\": \"3\", \"frequency\": \"1\"}, \"18\": {\"severity\": \"4\", \"frequency\": \"3\"}, \"19\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"20\": {\"severity\": \"4\", \"frequency\": \"3\"}}}', '2025-04-29 18:26:06'),
(11, 22, 'disc', '{\"1\": \"I\", \"2\": \"C\", \"3\": \"I\", \"4\": \"I\", \"5\": \"S\", \"6\": \"I\", \"7\": \"D\", \"8\": \"C\", \"9\": \"S\", \"10\": \"C\", \"11\": \"S\", \"12\": \"I\", \"13\": \"I\", \"14\": \"D\", \"15\": \"D\", \"16\": \"D\", \"17\": \"S\", \"18\": \"C\", \"19\": \"S\", \"20\": \"S\"}', '2025-05-16 11:36:13'),
(12, 22, 'mbti', '{\"type\": \"ESTJ\", \"answers\": {\"1\": \"B\", \"2\": \"A\", \"3\": \"A\", \"4\": \"A\", \"5\": \"B\", \"6\": \"A\", \"7\": \"A\", \"8\": \"A\", \"9\": \"A\", \"10\": \"B\", \"11\": \"B\", \"12\": \"A\", \"13\": \"A\", \"14\": \"A\", \"15\": \"A\", \"16\": \"B\", \"17\": \"A\", \"18\": \"B\", \"19\": \"B\", \"20\": \"A\"}, \"dimensions\": {\"E\": 4, \"F\": 2, \"I\": 1, \"J\": 3, \"N\": 2, \"P\": 2, \"S\": 3, \"T\": 3}}', '2025-05-16 11:39:41'),
(13, 22, 'bigfive', '{\"answers\": {\"1\": \"4\", \"2\": \"4\", \"3\": \"5\", \"4\": \"4\", \"5\": \"5\", \"6\": \"5\", \"7\": \"5\", \"8\": \"3\", \"9\": \"4\", \"10\": \"4\", \"11\": \"4\", \"12\": \"5\", \"13\": \"5\", \"14\": \"4\", \"15\": \"4\", \"16\": \"5\", \"17\": \"5\", \"18\": \"5\", \"19\": \"5\", \"20\": \"5\", \"21\": \"3\", \"22\": \"4\", \"23\": \"5\", \"24\": \"4\", \"25\": \"5\", \"26\": \"5\", \"27\": \"5\", \"28\": \"3\", \"29\": \"4\", \"30\": \"4\", \"31\": \"2\", \"32\": \"5\", \"33\": \"4\", \"34\": \"4\", \"35\": \"4\", \"36\": \"3\", \"37\": \"2\", \"38\": \"2\", \"39\": \"1\", \"40\": \"2\"}, \"dimensions\": {\"Abertura\": 4.38, \"Amabilidade\": 4.14, \"Extroversao\": 4.29, \"Neuroticismo\": 2.27, \"Conscienciosidade\": 4}}', '2025-05-16 11:50:20'),
(14, 22, 'jss', '{\"scores\": {\"Sobrecarga\": {\"count\": 6, \"total\": 16.5, \"average\": 2.75}, \"Pressão Temporal\": {\"count\": 7, \"total\": 22.5, \"average\": 3.21}, \"Pressão por Desempenho\": {\"count\": 7, \"total\": 16.5, \"average\": 2.36}}, \"answers\": {\"1\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"2\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"3\": {\"severity\": \"3\", \"frequency\": \"4\"}, \"4\": {\"severity\": \"4\", \"frequency\": \"2\"}, \"5\": {\"severity\": \"2\", \"frequency\": \"4\"}, \"6\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"7\": {\"severity\": \"3\", \"frequency\": \"4\"}, \"8\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"9\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"10\": {\"severity\": \"4\", \"frequency\": \"3\"}, \"11\": {\"severity\": \"3\", \"frequency\": \"2\"}, \"12\": {\"severity\": \"3\", \"frequency\": \"4\"}, \"13\": {\"severity\": \"3\", \"frequency\": \"4\"}, \"14\": {\"severity\": \"3\", \"frequency\": \"2\"}, \"15\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"16\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"17\": {\"severity\": \"2\", \"frequency\": \"1\"}, \"18\": {\"severity\": \"4\", \"frequency\": \"3\"}, \"19\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"20\": {\"severity\": \"3\", \"frequency\": \"1\"}}}', '2025-05-16 11:55:38'),
(15, 23, 'jss', '{\"scores\": {\"Sobrecarga\": {\"count\": 6, \"total\": 9, \"average\": 1.5}, \"Pressão Temporal\": {\"count\": 7, \"total\": 13, \"average\": 1.86}, \"Pressão por Desempenho\": {\"count\": 7, \"total\": 13, \"average\": 1.86}}, \"answers\": {\"1\": {\"severity\": \"1\", \"frequency\": \"2\"}, \"2\": {\"severity\": \"1\", \"frequency\": \"3\"}, \"3\": {\"severity\": \"1\", \"frequency\": \"1\"}, \"4\": {\"severity\": \"1\", \"frequency\": \"2\"}, \"5\": {\"severity\": \"1\", \"frequency\": \"4\"}, \"6\": {\"severity\": \"1\", \"frequency\": \"2\"}, \"7\": {\"severity\": \"1\", \"frequency\": \"3\"}, \"8\": {\"severity\": \"1\", \"frequency\": \"3\"}, \"9\": {\"severity\": \"1\", \"frequency\": \"2\"}, \"10\": {\"severity\": \"1\", \"frequency\": \"3\"}, \"11\": {\"severity\": \"1\", \"frequency\": \"4\"}, \"12\": {\"severity\": \"1\", \"frequency\": \"4\"}, \"13\": {\"severity\": \"1\", \"frequency\": \"3\"}, \"14\": {\"severity\": \"1\", \"frequency\": \"2\"}, \"15\": {\"severity\": \"1\", \"frequency\": \"2\"}, \"16\": {\"severity\": \"1\", \"frequency\": \"3\"}, \"17\": {\"severity\": \"1\", \"frequency\": \"1\"}, \"18\": {\"severity\": \"1\", \"frequency\": \"1\"}, \"19\": {\"severity\": \"1\", \"frequency\": \"3\"}, \"20\": {\"severity\": \"1\", \"frequency\": \"2\"}}}', '2025-05-16 17:11:09');

-- --------------------------------------------------------

--
-- Estrutura para tabela `test_results_ai_analysis`
--

CREATE TABLE `test_results_ai_analysis` (
  `id` int(11) NOT NULL,
  `test_result_id` int(11) NOT NULL,
  `analysis_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `test_results_ai_analysis`
--

INSERT INTO `test_results_ai_analysis` (`id`, `test_result_id`, `analysis_text`, `created_at`) VALUES
(1, 2, 'Com base nas porcentagens apresentadas, o perfil DISC dessa pessoa indica uma predominância moderada de Dominância, seguida por Influência e Estabilidade quase empatadas, e uma menor pontuação em Conformidade. Vamos analisar cada aspecto:\n\n1. Principais características:\n- Dominância (D): Pessoas com uma alta porcentagem de Dominância tendem a ser assertivas, diretas, focadas em resultados e orientadas para a ação. Elas gostam de desafios e de assumir o controle em situações de liderança.\n- Influência (I): Indivíduos com influência significativa geralmente são comunicativos, extrovertidos, persuasivos e sociáveis. Eles se destacam em construir relacionamentos e motivar os outros.\n- Estabilidade (S): Pessoas com uma forte estabilidade são conhecidas por serem pacientes, confiáveis, empáticas e colaborativas. Elas valorizam a harmonia nos relacionamentos e tendem a buscar estabilidade e segurança.\n- Conformidade (C): A baixa pontuação em Conformidade sugere que essa pessoa pode não se preocupar tanto com detalhes, procedimentos ou regras estritas. Ela pode ser mais flexível e aberta a novas abordagens.\n\n2. Pontos fortes:\n- A combinação de Dominância e Influência pode tornar essa pessoa uma líder carismática, capaz de inspirar e motivar os outros. Sua assertividade e habilidade de comunicação podem ser poderosos ativos em ambientes de trabalho dinâmicos.\n- A presença equilibrada de Estabilidade pode contribuir para a capacidade de construir relacionamentos sólidos e manter a calma sob pressão.\n\n3. Possíveis áreas de desenvolvimento:\n- Como a Conformidade é relativamente baixa, essa pessoa pode precisar trabalhar na atenção aos detalhes e na adesão a procedimentos em determinadas situações. Isso pode ser crucial em contextos que exigem precisão ou conformidade com normas rigorosas.\n- Se a influência da Dominância for excessiva, ela pode precisar praticar a escuta ativa e considerar diferentes perspectivas antes de agir.\n\n4. Sugestões para comunicação efetiva:\n- Se comunicando com essa pessoa, é importante ser direto e conciso, focando em resultados e ações tangíveis.\n- Reconheça suas habilidades de liderança e ofereça desafios que a estimulem a alcançar metas ambiciosas.\n- Valorize sua capacidade de influenciar e motivar os outros, incentivando-a a colaborar e compartilhar ideias.\n\nEm resumo, esse perfil DISC sugere uma pessoa com potencial de liderança, habilidades de comunicação sólidas e uma abordagem equilibrada em relação aos relacionamentos interpessoais. Com um foco no desenvolvimento de áreas específicas e na adaptação da comunicação, essa pessoa pode maximizar seu desempenho e contribuir de forma significativa em diferentes contextos.', '2025-04-14 15:28:06'),
(2, 3, 'Com base nos resultados fornecidos, o perfil MBTI ESTP representa uma pessoa com as seguintes características principais:\n\n1. Características principais:\n- Extrovertido (E): Indica uma preferência por interagir com o mundo externo e obter energia através de ações e experiências.\n- Sensorial (S): Indica uma preferência por focar em detalhes concretos e informações sensoriais presentes.\n- Pensamento (T): Indica uma preferência por tomar decisões de forma lógica e objetiva, baseada em fatos e análises racionais.\n- Perceptivo (P): Indica uma preferência por flexibilidade e adaptabilidade, preferindo manter as opções em aberto e lidar com as situações conforme surgem.\n\n2. Estilo de trabalho:\nOs ESTPs são conhecidos por serem práticos, orientados para a ação e hábeis em lidar com situações desafiadoras. Eles tendem a ser excelentes solucionadores de problemas, lidando bem com decisões rápidas e reagindo de forma eficaz a mudanças inesperadas. São indivíduos que gostam de estar envolvidos em atividades dinâmicas, que ofereçam oportunidades para utilizar suas habilidades práticas e tomar iniciativas.\n\n3. Comunicação preferida:\nOs ESTPs tendem a ser comunicativos, diretos e objetivos em sua comunicação. Preferem lidar com fatos e detalhes concretos, evitando conversas muito teóricas ou abstratas. Eles valorizam a comunicação clara e concisa, preferindo resolver problemas de forma prática e eficiente.\n\n4. Possíveis carreiras compatíveis:\nDevido às suas características de extroversão, praticidade e habilidade de lidar com situações desafiadoras, os ESTPs podem se destacar em carreiras que exijam ação, resolução de problemas práticos e adaptabilidade. Algumas possíveis carreiras compatíveis incluem empreendedorismo, vendas, marketing, engenharia, esportes, entretenimento, entre outras áreas que ofereçam oportunidades para ação e tomada de decisões rápidas.\n\nÉ importante lembrar que a análise do tipo de personalidade através do MBTI é apenas uma ferramenta de autoconhecimento e não deve ser utilizada como um determinante definitivo das capacidades ou comportamentos de uma pessoa. Cada indivíduo é único e pode apresentar variações em relação ao seu tipo de personalidade.', '2025-04-14 15:28:13'),
(3, 4, '**1. Interpretação de cada dimensão:**\n\n- **Abertura à Experiência (3.25 de 5):** Indica um nível moderado de curiosidade, criatividade e disposição para experimentar coisas novas. Pessoas com essa pontuação tendem a ser flexíveis e abertas a novas ideias, mas podem não buscar constantemente novas experiências.\n\n- **Conscienciosidade (3.43 de 5):** Reflete um nível moderado de organização, responsabilidade e disciplina. Indivíduos conscienciosos são confiáveis, focados em metas e têm uma abordagem estruturada em suas atividades.\n\n- **Extroversão ():** A pontuação não foi fornecida, então não é possível fazer uma interpretação precisa dessa dimensão. Em geral, extroversão está relacionada a traços como sociabilidade, assertividade e entusiasmo.\n\n- **Amabilidade (4.14 de 5):** Indica um alto nível de empatia, gentileza e colaboração. Pessoas amáveis tendem a ser atenciosas, prestativas e se preocupam com o bem-estar dos outros.\n\n- **Neuroticismo (2.09 de 5):** Reflete um baixo nível de ansiedade, instabilidade emocional e tendência a preocupações. Indivíduos com baixo neuroticismo são geralmente calmos, resilientes e não se deixam abalar facilmente por situações estressantes.\n\n**2. Pontos fortes no ambiente profissional:**\nCom essa combinação de traços, a pessoa provavelmente se destaca em ambientes de trabalho que valorizam a empatia, a organização e a adaptabilidade. Ela pode ser eficaz em funções que exigem colaboração com colegas, resolução de problemas de forma criativa e cumprimento de prazos com consistência.\n\n**3. Sugestões para desenvolvimento pessoal:**\nPara desenvolver-se ainda mais, a pessoa poderia trabalhar em ampliar sua abertura à experiência, buscando ativamente novas oportunidades de aprendizado e crescimento. Além disso, poderia focar em fortalecer sua conscienciosidade, estabelecendo metas mais claras e prazos para suas atividades.\n\n**4. Compatibilidade com diferentes tipos de trabalho:**\nEssa personalidade pode se encaixar bem em profissões que envolvam interação com pessoas, como áreas de cuidados de saúde, educação, recursos humanos ou vendas. Além disso, a capacidade de lidar bem com o estresse e manter a calma pode ser vantajosa em trabalhos que exigem tomada de decisões rápidas e resolução de problemas sob pressão, como em áreas de emergência ou gestão de projetos.', '2025-04-14 15:28:21'),
(4, 5, 'Com base nos níveis de estresse ocupacional apresentados, podemos fazer a seguinte análise:\n\n1. Principais fontes de estresse identificadas:\n- Sobrecarga: Indica que o indivíduo está lidando com uma quantidade significativa de trabalho, possivelmente mais do que consegue gerenciar de forma eficaz.\n- Pressão Temporal: Reflete a sensação de não ter tempo suficiente para realizar as tarefas de maneira adequada, levando a um sentimento de urgência e pressa.\n- Pressão por Desempenho: Mostra que o indivíduo sente a necessidade de alcançar altos padrões de desempenho e produtividade, o que pode gerar ansiedade e preocupação com o julgamento dos outros.\n\n2. Possíveis impactos no desempenho e bem-estar:\n- O estresse ocupacional elevado pode levar a problemas de saúde física e mental, como fadiga, ansiedade, depressão, insônia e esgotamento.\n- O desempenho no trabalho pode ser afetado negativamente, com possíveis erros, falta de concentração, redução da produtividade e aumento do absenteísmo.\n\n3. Recomendações para gestão do estresse:\n- Estabelecer limites claros de trabalho e priorizar tarefas importantes.\n- Praticar técnicas de relaxamento, como meditação e exercícios físicos.\n- Comunicar preocupações e buscar apoio de colegas ou superiores.\n- Estabelecer uma rotina saudável de sono e alimentação.\n- Procurar ajuda profissional, se necessário, como terapia ou aconselhamento.\n\n4. Sugestões para melhorias no ambiente de trabalho:\n- Promover uma cultura organizacional que valorize o equilíbrio entre vida pessoal e profissional.\n- Oferecer treinamentos sobre gestão de tempo, resolução de conflitos e habilidades de comunicação.\n- Implementar políticas de flexibilidade no trabalho, como horários flexíveis e trabalho remoto.\n- Realizar avaliações regulares de estresse e bem-estar dos funcionários para identificar possíveis áreas de melhoria.\n\nEm resumo, é importante reconhecer e abordar os níveis de estresse ocupacional, tanto a nível individual quanto organizacional, a fim de promover um ambiente de trabalho saudável e produtivo. A gestão eficaz do estresse pode melhorar o desempenho e bem-estar dos colaboradores, resultando em benefícios para a empresa como um todo.', '2025-04-14 15:28:28'),
(5, 6, 'Com base no perfil DISC fornecido, podemos fazer as seguintes análises:\n\n1. Principais características:\n- Este perfil apresenta uma alta pontuação em Estabilidade (S), o que indica uma tendência para ser mais paciente, estável, e focado em manter harmonia e segurança em ambientes.\n- Baixa pontuação em Conformidade (C) sugere que a pessoa pode não ser tão detalhista, meticulosa ou preocupada com regras e procedimentos.\n\n2. Pontos fortes:\n- A alta pontuação em Estabilidade (S) pode indicar habilidades para ser um bom ouvinte, promover um ambiente de trabalho tranquilo e estável, e ser confiável e leal.\n- Uma pontuação equilibrada em Dominância (D) e Influência (I) pode indicar uma capacidade de se adaptar a diferentes situações e interagir bem com diferentes tipos de pessoas.\n\n3. Possíveis áreas de desenvolvimento:\n- A baixa pontuação em Conformidade (C) pode indicar dificuldades em lidar com regras e procedimentos, o que pode levar a desorganização ou falta de atenção aos detalhes.\n- A falta de destaque em Dominância (D) e Influência (I) pode indicar uma tendência a evitar conflitos ou a ter dificuldades em se posicionar assertivamente em situações desafiadoras.\n\n4. Sugestões para comunicação efetiva:\n- Ao se comunicar com este perfil, é importante ser claro, conciso e paciente, dando espaço para que a pessoa processe as informações de forma tranquila.\n- Valorizar a estabilidade e a lealdade da pessoa ao se comunicar, demonstrando apoio e reconhecimento por suas contribuições para o ambiente.\n- Ao apresentar mudanças ou novas ideias, é importante abordar de forma calma e tranquilizadora, destacando como essas mudanças podem contribuir para a harmonia e segurança do ambiente.\n\nLembrando que a análise de perfis comportamentais é uma ferramenta útil para compreender as preferências e tendências de uma pessoa, mas cada indivíduo é único e pode se comportar de maneira diferente em diferentes situações. É importante adaptar a comunicação e as interações de acordo com as necessidades e características específicas de cada pessoa.', '2025-04-24 17:45:44'),
(6, 7, 'Com base no perfil DISC fornecido, podemos fazer a seguinte análise:\n\n1. Principais características:\n- Baixa Dominância (D) e Influência (I): Indica que a pessoa pode ser mais reservada, calma e cautelosa em sua abordagem.\n- Alta Estabilidade (S) e Conformidade (C): Mostra que a pessoa valoriza a estabilidade, consistência, ordem e adere fortemente às regras e procedimentos.\n\n2. Pontos fortes:\n- Organização e precisão: A alta pontuação em Conformidade sugere que a pessoa é meticulosa, detalhista e capaz de seguir instruções com precisão.\n- Capacidade de manter a calma: A alta Estabilidade indica que a pessoa pode ser uma fonte de estabilidade e tranquilidade em situações estressantes.\n\n3. Possíveis áreas de desenvolvimento:\n- Assertividade: A baixa Dominância pode indicar dificuldade em assumir o controle e liderar em situações desafiadoras.\n- Iniciativa e sociabilidade: A baixa Influência sugere que a pessoa pode ter dificuldade em se relacionar e influenciar os outros.\n\n4. Sugestões para comunicação efetiva com este perfil:\n- Seja claro e específico em suas instruções, pois a pessoa valoriza a precisão e seguirá as orientações detalhadas.\n- Reconheça e aprecie sua atenção aos detalhes e sua capacidade de manter a calma em situações de pressão.\n- Dê feedback de forma construtiva e focada em melhorias, pois a pessoa pode valorizar a conformidade e a busca por excelência.\n\nÉ importante lembrar que os perfis comportamentais são apenas uma parte da complexidade do ser humano, e cada pessoa é única. Portanto, a comunicação eficaz também envolve adaptação e flexibilidade para melhor se conectar com os outros.', '2025-04-29 17:53:34'),
(7, 8, 'Com base nas pontuações fornecidas para as preferências do MBTI (E/I, S/N, T/F, J/P), o perfil indicado é de um ESTP, que significa Extrovertido, Sensorial, Pensamento e Percepção.\n\n1. Características principais:\n- Extrovertido (E): Energizado pela interação com outras pessoas, gosta de estar no centro das atenções e é sociável.\n- Sensorial (S): Focado em detalhes concretos e presentes, prático e orientado para a ação.\n- Pensamento (T): Toma decisões de forma lógica e objetiva, prefere a verdade e a lógica sobre as emoções.\n- Percepção (P): Flexível, adaptável e aberto a novas experiências, prefere manter as opções em aberto.\n\n2. Estilo de trabalho:\n- O ESTP é conhecido por ser prático e orientado para a ação, preferindo lidar com situações concretas e imediatas. Eles são bons em lidar com problemas de forma rápida e eficaz, muitas vezes agindo sob pressão.\n- Tendem a ser excelentes solucionadores de problemas, pois são capazes de pensar rapidamente em soluções práticas e eficazes.\n- Gostam de desafios e atividades que envolvam riscos calculados, pois têm uma mentalidade empreendedora e estão sempre em busca de novas oportunidades.\n\n3. Comunicação preferida:\n- O ESTP tende a ser direto e objetivo em sua comunicação, preferindo lidar com fatos e informações concretas do que com abstrações.\n- Eles valorizam a comunicação clara e concisa, preferindo resolver problemas de forma prática e eficiente.\n- São bons em negociar e persuadir, pois sabem como adaptar sua abordagem de acordo com a situação e as necessidades da outra parte.\n\n4. Possíveis carreiras compatíveis:\n- Devido à sua natureza empreendedora, o ESTP pode se destacar em carreiras que envolvam empreendedorismo, vendas, marketing, negociação e gestão de projetos.\n- Profissões como corretor de imóveis, empreendedor, agente de vendas, policial, bombeiro, piloto, atleta ou consultor de negócios podem ser adequadas para o ESTP.\n- Eles se destacam em ambientes dinâmicos e desafiadores, onde possam usar suas habilidades práticas e sua capacidade de lidar com situações de forma rápida e eficaz.\n\nÉ importante lembrar que o MBTI é uma ferramenta de autoconhecimento e desenvolvimento pessoal, e que os resultados podem variar de acordo com o contexto e a personalidade única de cada indivíduo.', '2025-04-29 18:27:04'),
(8, 9, 'Claro, vou analisar cada dimensão do perfil Big Five fornecido:\n\n1. Abertura à Experiência: Com um score de 3.63 de 5, essa pessoa demonstra um nível moderado de abertura à experiência. Indivíduos com alta abertura à experiência tendem a ser criativos, curiosos e abertos a novas ideias, enquanto aqueles com baixa abertura à experiência preferem o familiar e o convencional. Essa pessoa provavelmente gosta de explorar novas ideias e experiências, mas também valoriza a segurança e a estabilidade.\n\n2. Conscienciosidade: Com um score de 3.86 de 5, essa pessoa demonstra um bom nível de conscienciosidade. Indivíduos conscientes são organizados, responsáveis e confiáveis. Eles tendem a ser diligentes no cumprimento de tarefas e metas, e geralmente são percebidos como confiáveis e comprometidos.\n\n3. Extroversão: A falta de informação sobre o score de extroversão impede uma análise detalhada dessa dimensão. No entanto, a extroversão se refere à sociabilidade, assertividade e níveis de energia de uma pessoa. Indivíduos extrovertidos tendem a ser comunicativos, sociáveis e energéticos, enquanto os introvertidos preferem ambientes mais calmos e introspectivos.\n\n4. Amabilidade: Com um score de 3.71 de 5, essa pessoa demonstra um bom nível de amabilidade. Indivíduos amáveis são empáticos, cooperativos e gentis. Eles valorizam as relações interpessoais e tendem a ser bons ouvintes e conselheiros.\n\n5. Neuroticismo: Com um score de 3.91 de 5, essa pessoa demonstra um nível moderado a alto de neuroticismo. Indivíduos com alto neuroticismo são propensos a experimentar emoções negativas, como ansiedade, preocupação e insegurança. Eles podem ser mais sensíveis ao estresse e ter dificuldade em lidar com situações desafiadoras.\n\nPontos fortes no ambiente profissional:\nCom base nas dimensões analisadas, essa pessoa provavelmente é confiável, responsável, aberta a novas ideias e empática. Essas características podem ser vantajosas em uma variedade de ambientes profissionais, especialmente em funções que exigem organização, criatividade, colaboração e empatia.\n\nSugestões para desenvolvimento pessoal:\nPara desenvolver ainda mais sua personalidade, essa pessoa pode se beneficiar de práticas que promovam a gestão do estresse, o autoconhecimento emocional e o desenvolvimento de habilidades de comunicação assertiva. Trabalhar em aumentar a resiliência emocional e a capacidade de lidar com a pressão também pode ser útil.\n\nCompatibilidade com diferentes tipos de trabalho:\nDada a combinação de abertura à experiência, conscienciosidade, amabilidade e neuroticismo moderado, essa pessoa pode se destacar em funções que envolvam criatividade, colaboração, responsabilidade e empatia. Carreiras em áreas como psicologia, educação, design, comunicação, recursos humanos e saúde mental podem ser compatíveis com essas características. No entanto, é importante considerar que a falta de informação sobre a extroversão pode influenciar a adequação a determinados ambientes de trabalho.', '2025-04-29 18:27:14'),
(9, 10, 'Com base nos níveis de estresse ocupacional apresentados, podemos realizar a seguinte análise:\n\n1. Principais fontes de estresse identificadas:\n- Sobrecarga: Indica que o indivíduo sente que tem mais trabalho do que consegue lidar, o que pode levar a sentimentos de exaustão e falta de controle sobre as tarefas.\n- Pressão Temporal: Refere-se à sensação de que o tempo é insuficiente para realizar as atividades de forma eficaz, o que pode gerar ansiedade e dificuldade em cumprir prazos.\n- Pressão por Desempenho: Indica a pressão para atingir metas e resultados, o que pode levar a sentimentos de inadequação e insegurança em relação às próprias habilidades.\n\n2. Possíveis impactos no desempenho e bem-estar:\n- Altos níveis de estresse ocupacional podem impactar negativamente o desempenho no trabalho, levando a erros, diminuição da produtividade e dificuldade de concentração.\n- Além disso, o estresse crônico pode afetar o bem-estar emocional e físico do indivíduo, aumentando o risco de ansiedade, depressão, insônia e problemas de saúde relacionados ao estresse.\n\n3. Recomendações para gestão do estresse:\n- Estabelecer prioridades e gerenciar o tempo de forma eficaz, delegando tarefas quando necessário.\n- Praticar técnicas de relaxamento, como meditação, respiração profunda e exercícios físicos.\n- Buscar apoio emocional, seja por meio de conversas com colegas, amigos ou profissionais de saúde mental.\n- Estabelecer limites saudáveis entre trabalho e vida pessoal, garantindo momentos de descanso e lazer.\n\n4. Sugestões para melhorias no ambiente de trabalho:\n- Promover uma cultura organizacional que valorize o equilíbrio entre trabalho e vida pessoal, incentivando pausas e descanso.\n- Oferecer programas de apoio ao bem-estar dos funcionários, como palestras sobre gerenciamento de estresse, sessões de mindfulness e atividades físicas.\n- Incentivar a comunicação aberta e o feedback construtivo entre gestores e colaboradores, para identificar e resolver possíveis fontes de estresse no ambiente de trabalho.', '2025-04-29 18:27:21'),
(10, 11, 'Com base no perfil DISC fornecido, podemos fazer a seguinte análise detalhada:\n\n1. Principais características:\n- Baixa Dominância (D): Indivíduos com baixa Dominância tendem a ser mais calmos, receptivos e colaborativos em suas interações. Eles podem preferir evitar confrontos e priorizam a harmonia nas relações interpessoais.\n- Média Influência (I): Pessoas com influência moderada são sociáveis, comunicativas e gostam de interagir com os outros. Elas são geralmente otimistas e gostam de motivar e inspirar as pessoas ao seu redor.\n- Média Estabilidade (S): Indivíduos com estabilidade moderada são pacientes, confiáveis e preferem ambientes estáveis e previsíveis. Eles valorizam a segurança e a consistência em suas atividades.\n- Baixa Conformidade (C): Pessoas com baixa conformidade tendem a ser mais independentes, criativas e menos preocupadas com regras e procedimentos. Elas podem valorizar mais a flexibilidade e a liberdade de pensamento.\n\n2. Pontos fortes:\n- Habilidade de trabalhar em equipe e colaborar com os outros de forma eficaz.\n- Capacidade de se adaptar a diferentes situações e ambientes.\n- Tendência a ser empático e compreensivo com os outros.\n- Potencial para ser inovador e pensar fora da caixa.\n\n3. Possíveis áreas de desenvolvimento:\n- Pode ter dificuldade em tomar decisões rápidas e assertivas devido à baixa Dominância.\n- Pode precisar trabalhar na assertividade e na definição de limites para evitar ser influenciado facilmente.\n- Pode enfrentar desafios em lidar com ambientes muito competitivos ou confrontadores devido à baixa Dominância.\n\n4. Sugestões para comunicação efetiva:\n- Ao se comunicar com esse perfil, é importante adotar uma abordagem mais colaborativa e empática, valorizando suas opiniões e contribuições.\n- Utilize uma linguagem positiva e motivadora para envolvê-los e inspirá-los em direção aos objetivos comuns.\n- Dê espaço para que expressem suas ideias e sentimentos, permitindo que se sintam ouvidos e valorizados.\n- Se necessário, forneça feedback de maneira construtiva e focada no desenvolvimento pessoal.\n\nEm resumo, esse perfil comportamental apresenta uma combinação de características que favorecem a colaboração, a empatia e a adaptabilidade. Com a conscientização de seus pontos fortes e áreas de desenvolvimento, é possível potencializar suas habilidades e contribuições dentro de um contexto organizacional ou interpessoal.', '2025-05-16 17:07:30'),
(11, 12, 'Com base nas pontuações fornecidas para cada dimensão do teste MBTI (E/I: 4/1, S/N: 3/2, T/F: 3/2, J/P: 3/2), podemos identificar o perfil ESTJ (Extrovertido, Sensorial, Pensamento, Julgamento). Vamos analisar cada aspecto:\n\n1. Características principais do ESTJ:\n- Extrovertido (E): Gosta de interagir com os outros, é energizado por atividades sociais e prefere trabalhar em ambientes de grupo.\n- Sensorial (S): Foca em detalhes concretos e práticos, prefere lidar com informações factuais e concretas em vez de ideias abstratas.\n- Pensamento (T): Toma decisões de forma lógica e objetiva, valoriza a racionalidade e a consistência.\n- Julgamento (J): Prefere ter planos e estrutura, gosta de seguir cronogramas e prazos, e tende a ser organizado e decisivo.\n\n2. Estilo de trabalho do ESTJ:\n- O ESTJ é prático, eficiente e orientado para resultados. Gosta de lidar com tarefas concretas e tangíveis, preferindo seguir procedimentos estabelecidos.\n- Tende a ser organizado, responsável e confiável no ambiente de trabalho, assumindo papéis de liderança e supervisionando equipes.\n- Valoriza a eficiência, a produtividade e a disciplina, buscando alcançar metas de forma sistemática e planejada.\n\n3. Comunicação preferida do ESTJ:\n- O ESTJ prefere uma comunicação direta e objetiva, valorizando informações claras e concretas.\n- Gosta de dar e receber feedback de forma assertiva, focando em soluções práticas e resultados tangíveis.\n- Pode parecer assertivo e decidido em sua comunicação, buscando eficiência e resolução de problemas de maneira direta.\n\n4. Possíveis carreiras compatíveis para o ESTJ:\n- Gerência e supervisão: Com sua capacidade de liderança, organização e foco em resultados, o ESTJ se destaca em cargos de gerência e supervisão em diversos setores.\n- Administração: O ESTJ é eficiente em lidar com tarefas administrativas, planejamento estratégico e organização de processos.\n- Direito: Com sua habilidade de tomar decisões lógicas e objetivas, o ESTJ pode se destacar em carreiras jurídicas que exigem análise crítica e aplicação de normas.\n- Engenharia: A habilidade do ESTJ em lidar com informações concretas e procedimentos estruturados pode ser útil em áreas da engenharia que demandam precisão e organização.\n\nEm resumo, o ESTJ é um perfil de personalidade prático, organizado e eficiente, que se destaca em ambientes de trabalho estruturados, onde sua capacidade de liderança, planejamento e execução de tarefas é valorizada.', '2025-05-16 17:07:38'),
(12, 13, '1. Interpretação de cada dimensão:\n\n- Abertura à Experiência: Com uma pontuação alta nessa dimensão, a pessoa tende a ser criativa, curiosa, imaginativa e aberta a novas ideias e experiências. Ela provavelmente busca constantemente aprender e explorar novas áreas, sendo flexível e adaptável a mudanças.\n\n- Conscienciosidade: Uma pontuação alta em conscienciosidade indica que a pessoa é organizada, responsável, confiável e orientada para metas. Ela provavelmente é diligente, planejada e comprometida com a qualidade do trabalho que realiza.\n\n- Extroversão: Como a pontuação em extroversão não foi fornecida, não podemos fazer uma análise específica dessa dimensão. No entanto, a extroversão geralmente está relacionada com traços como sociabilidade, energia, assertividade e busca por interações sociais.\n\n- Amabilidade: Uma pontuação alta em amabilidade sugere que a pessoa é gentil, cooperativa, compassiva e empática. Ela provavelmente valoriza as relações interpessoais, é atenciosa com os outros e busca harmonia em seus relacionamentos.\n\n- Neuroticismo: Com uma pontuação baixa em neuroticismo, a pessoa tende a ser emocionalmente estável, tranquila, segura e resiliente diante de situações estressantes. Ela provavelmente lida bem com a pressão e mantém a calma em situações desafiadoras.\n\n2. Pontos fortes no ambiente profissional:\nCom base nesse perfil, a pessoa provavelmente apresenta pontos fortes como criatividade, responsabilidade, empatia, estabilidade emocional e capacidade de manter relacionamentos positivos. Ela pode se destacar em profissões que valorizam a inovação, a organização, o trabalho em equipe e a gestão eficaz de emoções.\n\n3. Sugestões para desenvolvimento pessoal:\nApesar das pontuações positivas, sempre há espaço para desenvolvimento pessoal. Alguns aspectos que a pessoa poderia trabalhar incluem a busca por equilíbrio entre a abertura à experiência e a conscienciosidade, a prática de assertividade e a participação em treinamentos para fortalecer habilidades interpessoais.\n\n4. Compatibilidade com diferentes tipos de trabalho:\nCom esse perfil, a pessoa pode se destacar em áreas como design, artes, pesquisa, psicologia, educação, gestão de projetos, marketing, recursos humanos, entre outras. Sua combinação de criatividade, responsabilidade e empatia pode ser vantajosa em ambientes que exigem inovação, colaboração e liderança eficaz.', '2025-05-16 17:07:45'),
(13, 14, 'Com base nos níveis de estresse ocupacional apresentados, podemos fazer a seguinte análise:\n\n1. Principais fontes de estresse identificadas:\n- Sobrecarga: Este nível indica que o indivíduo está lidando com uma quantidade significativa de trabalho, podendo se sentir sobrecarregado e sem tempo suficiente para completar todas as tarefas.\n- Pressão Temporal: Indica que o indivíduo está enfrentando pressão relacionada a prazos e tempo para realização das atividades, o que pode aumentar a ansiedade e o estresse.\n- Pressão por Desempenho: Reflete a expectativa de alcançar metas e resultados específicos, o que pode gerar pressão adicional sobre o colaborador.\n\n2. Possíveis impactos no desempenho e bem-estar:\n- Os altos níveis de estresse ocupacional podem impactar negativamente o desempenho no trabalho, levando a erros, falta de concentração e produtividade reduzida.\n- Além disso, o estresse crônico pode contribuir para problemas de saúde física e mental, como ansiedade, depressão, insônia e exaustão.\n\n3. Recomendações para gestão do estresse:\n- É importante que o indivíduo aprenda a gerenciar seu tempo de forma eficaz, priorizando tarefas e estabelecendo limites saudáveis.\n- Praticar técnicas de relaxamento, como meditação, respiração profunda ou exercícios físicos, pode ajudar a reduzir os níveis de estresse.\n- Buscar apoio de colegas, líderes ou profissionais de saúde mental também pode ser benéfico para lidar com o estresse ocupacional.\n\n4. Sugestões para melhorias no ambiente de trabalho:\n- Os empregadores podem implementar programas de bem-estar no trabalho, que incluam atividades de promoção da saúde mental, como sessões de mindfulness ou workshops sobre gerenciamento do estresse.\n- Promover uma cultura organizacional que incentive a comunicação aberta, o equilíbrio entre vida pessoal e profissional e o reconhecimento do esforço dos colaboradores também pode contribuir para reduzir o estresse ocupacional.\n- Avaliar regularmente as demandas de trabalho e a distribuição de tarefas, garantindo que os colaboradores não estejam constantemente sobrecarregados e que tenham recursos adequados para realizar suas atividades.\n\nEm resumo, é fundamental reconhecer e abordar os níveis de estresse ocupacional para promover o bem-estar dos colaboradores e a produtividade no ambiente de trabalho.', '2025-05-16 17:07:51');

-- --------------------------------------------------------

--
-- Estrutura para tabela `test_results_backup`
--

CREATE TABLE `test_results_backup` (
  `id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `test_type` enum('disc','mbti','bigfive','jss') NOT NULL,
  `answers` json NOT NULL,
  `results` json NOT NULL,
  `completed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Despejando dados para a tabela `test_results_backup`
--

INSERT INTO `test_results_backup` (`id`, `candidate_id`, `test_type`, `answers`, `results`, `completed_at`) VALUES
(1, 3, 'disc', 'null', '{\"1\": \"D\", \"2\": \"I\", \"3\": \"S\", \"4\": \"C\", \"5\": \"D\", \"6\": \"I\", \"7\": \"S\", \"8\": \"C\", \"9\": \"D\", \"10\": \"I\", \"11\": \"S\", \"12\": \"C\", \"13\": \"D\", \"14\": \"D\", \"15\": \"S\", \"16\": \"I\", \"17\": \"I\", \"18\": \"S\", \"19\": \"D\", \"20\": \"D\"}', '2025-03-26 21:39:54'),
(2, 3, 'mbti', 'null', '{\"type\": \"ESTP\", \"answers\": {\"1\": \"A\", \"2\": \"A\", \"3\": \"B\", \"4\": \"A\", \"5\": \"B\", \"6\": \"A\", \"7\": \"B\", \"8\": \"B\", \"9\": \"A\", \"10\": \"A\", \"11\": \"B\", \"12\": \"A\", \"13\": \"A\", \"14\": \"B\", \"15\": \"A\", \"16\": \"A\", \"17\": \"A\", \"18\": \"B\", \"19\": \"B\", \"20\": \"B\"}, \"dimensions\": {\"E\": 3, \"F\": 2, \"I\": 2, \"J\": 1, \"N\": 1, \"P\": 4, \"S\": 4, \"T\": 3}}', '2025-03-26 21:40:59'),
(3, 3, 'bigfive', 'null', '{\"answers\": {\"1\": \"5\", \"2\": \"4\", \"3\": \"2\", \"4\": \"3\", \"5\": \"2\", \"6\": \"2\", \"7\": \"4\", \"8\": \"2\", \"9\": \"1\", \"10\": \"1\", \"11\": \"4\", \"12\": \"2\", \"13\": \"2\", \"14\": \"2\", \"15\": \"1\", \"16\": \"5\", \"17\": \"4\", \"18\": \"4\", \"19\": \"4\", \"20\": \"3\", \"21\": \"2\", \"22\": \"4\", \"23\": \"4\", \"24\": \"5\", \"25\": \"4\", \"26\": \"4\", \"27\": \"3\", \"28\": \"4\", \"29\": \"2\", \"30\": \"1\", \"31\": \"5\", \"32\": \"2\", \"33\": \"2\", \"34\": \"2\", \"35\": \"2\", \"36\": \"4\", \"37\": \"4\", \"38\": \"5\", \"39\": \"4\", \"40\": \"4\"}, \"dimensions\": {\"Abertura\": 3.25, \"Amabilidade\": 3.71, \"Extroversao\": 3.71, \"Neuroticismo\": 3.73, \"Conscienciosidade\": 2.43}}', '2025-03-26 21:43:05'),
(4, 3, 'jss', 'null', '{\"scores\": {\"Sobrecarga\": {\"count\": 6, \"total\": 36, \"average\": 6}, \"Pressão Temporal\": {\"count\": 7, \"total\": 41, \"average\": 5.86}, \"Pressão por Desempenho\": {\"count\": 7, \"total\": 37, \"average\": 5.29}}, \"answers\": {\"1\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"2\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"3\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"4\": {\"severity\": \"4\", \"frequency\": \"3\"}, \"5\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"6\": {\"severity\": \"4\", \"frequency\": \"3\"}, \"7\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"8\": {\"severity\": \"4\", \"frequency\": \"2\"}, \"9\": {\"severity\": \"4\", \"frequency\": \"4\"}, \"10\": {\"severity\": \"5\", \"frequency\": \"3\"}, \"11\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"12\": {\"severity\": \"3\", \"frequency\": \"2\"}, \"13\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"14\": {\"severity\": \"5\", \"frequency\": \"5\"}, \"15\": {\"severity\": \"5\", \"frequency\": \"2\"}, \"16\": {\"severity\": \"4\", \"frequency\": \"2\"}, \"17\": {\"severity\": \"2\", \"frequency\": \"2\"}, \"18\": {\"severity\": \"2\", \"frequency\": \"3\"}, \"19\": {\"severity\": \"3\", \"frequency\": \"3\"}, \"20\": {\"severity\": \"1\", \"frequency\": \"2\"}}}', '2025-03-26 21:44:49');

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('superadmin','selector') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Recursos Humanos', 'recursoshumanos@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'superadmin', '2025-03-26 16:45:28'),
(7, 'Ezequiel Santos', 'ezequiel.santos@sysmanager.com.br', '6e7e011c955bba98ab8652251376af4f', 'selector', '2025-03-27 14:30:35'),
(10, 'Ezequiel Santos', 'ezequielsantos@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'superadmin', '2025-03-27 14:35:37'),
(17, 'Karen Vitória Barbosa Ribeiro', 'karen.ribeiro@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-14 12:13:16'),
(18, 'Ana Laura Silva dos Reis', 'ana.reis@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-14 12:14:16'),
(19, 'Caroline', 'caroline@sysmanager.com.br', 'f8958d44c0fbb59e06ffb41b23899325', 'selector', '2025-04-14 12:14:34'),
(20, 'Caroline da Silva Daudt', 'caroline.daudt@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-14 12:16:01'),
(21, 'Tamires Lourenço', 'tamires.lourenco@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-14 12:17:48'),
(22, 'pdl2025', 'pdl2025@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-14 12:19:01'),
(26, 'Allana Christina Caetano Pimentel', 'allana.caetano@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-23 17:39:51'),
(27, 'Jaqueline da Silva Amorim', 'jaqueline.amorim@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-23 17:40:58'),
(28, 'Bárbara Meira Anijar Sampaio', 'barbara.meira@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-23 17:46:36'),
(29, 'Layanne Cristina Catrolio', 'layanne.catrolio@sysmanager.com.br', 'c104ba3d0c77418a46ac7c682d7f66dd', 'selector', '2025-04-23 17:59:39');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `bigfive_questions`
--
ALTER TABLE `bigfive_questions`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_selector` (`selector_id`);

--
-- Índices de tabela `disc_questions`
--
ALTER TABLE `disc_questions`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `jss_questions`
--
ALTER TABLE `jss_questions`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `mbti_questions`
--
ALTER TABLE `mbti_questions`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Índices de tabela `test_assignments`
--
ALTER TABLE `test_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_test` (`candidate_id`,`test_type`),
  ADD KEY `assigned_by` (`assigned_by`);

--
-- Índices de tabela `test_batches`
--
ALTER TABLE `test_batches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_candidate` (`candidate_id`);

--
-- Índices de tabela `test_questions`
--
ALTER TABLE `test_questions`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `test_results`
--
ALTER TABLE `test_results`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_result` (`candidate_id`,`test_type`);

--
-- Índices de tabela `test_results_ai_analysis`
--
ALTER TABLE `test_results_ai_analysis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `test_result_id` (`test_result_id`);

--
-- Índices de tabela `test_results_backup`
--
ALTER TABLE `test_results_backup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `candidate_id` (`candidate_id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `bigfive_questions`
--
ALTER TABLE `bigfive_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de tabela `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de tabela `disc_questions`
--
ALTER TABLE `disc_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `jss_questions`
--
ALTER TABLE `jss_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `mbti_questions`
--
ALTER TABLE `mbti_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `test_assignments`
--
ALTER TABLE `test_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de tabela `test_batches`
--
ALTER TABLE `test_batches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `test_questions`
--
ALTER TABLE `test_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `test_results`
--
ALTER TABLE `test_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `test_results_ai_analysis`
--
ALTER TABLE `test_results_ai_analysis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `test_results_backup`
--
ALTER TABLE `test_results_backup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `candidates`
--
ALTER TABLE `candidates`
  ADD CONSTRAINT `candidates_ibfk_1` FOREIGN KEY (`selector_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `test_assignments`
--
ALTER TABLE `test_assignments`
  ADD CONSTRAINT `test_assignments_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `test_assignments_ibfk_2` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `test_batches`
--
ALTER TABLE `test_batches`
  ADD CONSTRAINT `test_batches_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`);

--
-- Restrições para tabelas `test_results`
--
ALTER TABLE `test_results`
  ADD CONSTRAINT `test_results_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `test_results_ai_analysis`
--
ALTER TABLE `test_results_ai_analysis`
  ADD CONSTRAINT `test_results_ai_analysis_ibfk_1` FOREIGN KEY (`test_result_id`) REFERENCES `test_results` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
