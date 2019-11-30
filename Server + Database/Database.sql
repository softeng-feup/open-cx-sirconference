-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 30-Nov-2019 às 11:36
-- Versão do servidor: 10.3.16-MariaDB
-- versão do PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `id11306612_sirconference_accounts`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `accounts`
--

CREATE TABLE `accounts` (
  `username` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`username`, `password`) VALUES
('', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('123456', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
('257', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
('4523463', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('admin', '276f2969d0ceabf04eb8437c264398d3e4a3108c6d145898174902d26e51aacd'),
('defaultUser', 'defaultPW'),
('teste', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'),
('user1', 'c592df4a86933b92addc9842402ddf198c638ea9be58916ee6e3734e1e3152f8'),
('user100', 'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb'),
('user2', '93915a0a4bf8f634cb1856494dd4304472ad46b9827f541f76b6761c49cc55b0');

-- --------------------------------------------------------

--
-- Estrutura da tabela `questions`
--

CREATE TABLE `questions` (
  `id` int(16) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `question` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session` int(16) NOT NULL,
  `likesCount` int(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `questions`
--

INSERT INTO `questions` (`id`, `username`, `question`, `session`, `likesCount`) VALUES
(56, 'username', 'Test Question', 1, 10),
(57, 'username', 'Test Question 2', 1, 10),
(58, 'username', 'Test Question 2', 0, 10),
(61, 'username', 'Test Question 3', 1, 10),
(101, 'admin', 'oo', 0, 11),
(102, 'admin', 'ooo', 0, 15);

-- --------------------------------------------------------

--
-- Estrutura da tabela `sessions`
--

CREATE TABLE `sessions` (
  `code` int(16) NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `creator` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `sessions`
--

INSERT INTO `sessions` (`code`, `name`, `creator`) VALUES
(0, 'Primeira Sessao', NULL),
(1, 'Outra sessao', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `userLikesQuestion`
--

CREATE TABLE `userLikesQuestion` (
  `id` int(16) NOT NULL,
  `user` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `question` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `session` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `userLikesQuestion`
--

INSERT INTO `userLikesQuestion` (`id`, `user`, `question`, `session`) VALUES
(54, 'admin', 'oo', 0),
(56, 'admin', 'ooo', 0),
(1, 'defaultUser', 'defaultQuestion', 0);

--
-- Acionadores `userLikesQuestion`
--
DELIMITER $$
CREATE TRIGGER `decLikes` BEFORE DELETE ON `userLikesQuestion` FOR EACH ROW UPDATE `questions` SET likesCount = likesCount - 1 WHERE (questions.question = old.question && questions.username = old.user && questions.session = old.session && EXISTS (SELECT * FROM userLikesQuestion WHERE userLikesQuestion.user = old.user && userLikesQuestion.question = old.question && userLikesQuestion.session = old.session))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `incLikes` BEFORE INSERT ON `userLikesQuestion` FOR EACH ROW UPDATE `questions` SET likesCount = likesCount + 1 WHERE (questions.question = new.question && questions.username = new.user && questions.session = new.session && NOT EXISTS (SELECT * FROM userLikesQuestion WHERE userLikesQuestion.user = new.user && userLikesQuestion.question = new.question && userLikesQuestion.session = new.session))
$$
DELIMITER ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`username`);

--
-- Índices para tabela `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Foreign Key` (`session`);

--
-- Índices para tabela `sessions`
--
ALTER TABLE `sessions`
  ADD UNIQUE KEY `id` (`code`);

--
-- Índices para tabela `userLikesQuestion`
--
ALTER TABLE `userLikesQuestion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user` (`user`,`question`,`session`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT de tabela `userLikesQuestion`
--
ALTER TABLE `userLikesQuestion`
  MODIFY `id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `Foreign Key` FOREIGN KEY (`session`) REFERENCES `sessions` (`code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
