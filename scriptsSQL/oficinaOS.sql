-- Criação do esquema lógico para uma oficina
create database oficinaOS;
use oficinaOS; 

-- Tabela de Clientes
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    endereco TEXT
);

-- Tabela de Veículos
CREATE TABLE Veiculos (
    veiculo_id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES Clientes(cliente_id),
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INT NOT NULL
);

-- Tabela de Serviços
CREATE TABLE Servicos (
    servico_id SERIAL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de Ordens de Serviço
CREATE TABLE OrdensServico (
    ordem_id SERIAL PRIMARY KEY,
    veiculo_id INT REFERENCES Veiculos(veiculo_id),
    data_abertura DATE NOT NULL,
    data_fechamento DATE,
    status VARCHAR(20) CHECK (status IN ('Aberta', 'Em Andamento', 'Concluída')) NOT NULL
);

-- Tabela de Itens da Ordem de Serviço
CREATE TABLE ItensOrdemServico (
    item_id SERIAL PRIMARY KEY,
    ordem_id INT REFERENCES OrdensServico(ordem_id),
    servico_id INT REFERENCES Servicos(servico_id),
    quantidade INT NOT NULL,
    preco_total DECIMAL(10,2) NOT NULL
);

-- Tabela de Funcionários
CREATE TABLE Funcionarios (
    funcionario_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

-- Tabela de Funcionários que realizam serviços
CREATE TABLE FuncionariosServicos (
    funcionario_id INT REFERENCES Funcionarios(funcionario_id),
    servico_id INT REFERENCES Servicos(servico_id),
    PRIMARY KEY (funcionario_id, servico_id)
);

-- Inserção de dados
INSERT INTO Clientes (nome, telefone, email, endereco) VALUES
('Carlos Silva', '11987654321', 'carlos@email.com', 'Rua A, 123'),
('Ana Souza', '11876543210', 'ana@email.com', 'Rua B, 456');

INSERT INTO Veiculos (cliente_id, placa, modelo, marca, ano) VALUES
(1, 'ABC-1234', 'Gol', 'Volkswagen', 2015),
(2, 'XYZ-9876', 'Civic', 'Honda', 2020);

INSERT INTO Servicos (descricao, preco) VALUES
('Troca de óleo', 100.00),
('Alinhamento e balanceamento', 150.00);

INSERT INTO Funcionarios (nome, cargo, salario) VALUES
('João Mendes', 'Mecânico', 3000.00),
('Marcos Lima', 'Atendente', 2000.00);

INSERT INTO OrdensServico (veiculo_id, data_abertura, status) VALUES
(1, '2025-03-01', 'Aberta');

INSERT INTO ItensOrdemServico (ordem_id, servico_id, quantidade, preco_total) VALUES
(1, 1, 1, 100.00);

-- Queries complexas

-- Recuperação de todos os clientes e seus veículos
SELECT c.nome AS Cliente, v.placa AS Placa, v.modelo AS Modelo, v.marca AS Marca
FROM Clientes c
JOIN Veiculos v ON c.cliente_id = v.cliente_id;

-- Filtrar ordens de serviço em andamento
SELECT * FROM OrdensServico WHERE status = 'Em Andamento';

-- Calcular faturamento total por serviço
SELECT s.descricao, SUM(i.preco_total) AS Total_Faturado
FROM ItensOrdemServico i
JOIN Servicos s ON i.servico_id = s.servico_id
GROUP BY s.descricao;

-- Listar funcionários que realizam serviços
SELECT f.nome, s.descricao 
FROM Funcionarios f
JOIN FuncionariosServicos fs ON f.funcionario_id = fs.funcionario_id
JOIN Servicos s ON fs.servico_id = s.servico_id;

-- Ordenar clientes pelo nome
SELECT * FROM Clientes ORDER BY nome ASC;

-- Filtrar serviços com faturamento acima de 200 reais
SELECT s.descricao, SUM(i.preco_total) AS Total_Faturado
FROM ItensOrdemServico i
JOIN Servicos s ON i.servico_id = s.servico_id
GROUP BY s.descricao
HAVING SUM(i.preco_total) > 200;
