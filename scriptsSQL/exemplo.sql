show databases;
create database teste_exemplo;
use teste_exemplo;
show tables;

create table pessoa(
	pessoa_id smallint unsigned,
    nome varchar(20),
    ultimo_nome varchar(20),
    genero enum ('M', 'F', 'outro'),
    aniversario date,
    rua varchar(30),
    cidade varchar(20),
    estdado varchar(20),
    pais varchar(20),
    cep varchar(20),
    constraint pk_pessoa primary key (pessoa_id)
);

desc pessoa;

create table comida_fav(
	pessoa_id smallint unsigned,
    comida varchar(20),
    constraint pk_comida_fav primary key (pessoa_id, comida),
    constraint pk_comida_fav_pessoa_id foreign key (pessoa_id)
    references pessoa(pessoa_id) /* referenciando a chave estrangeria */
);

desc comida_fav; /* mostrando a tabela criada*/
show databases;
select * from information_schema.table_constraints
where constraint_schema = 'teste_exemplo';

/* inserindo dados*/
insert into pessoa values 	('1', 'sofia', 'lalaa', 'outro', '1987-10-12',
							'rua X', 'Cidade Y', 'SP', 'Brasil', '20654-90'),
							('2', 'Maria', '-', 'F', '1987-10-12',
							'rua X', 'Cidade Y', 'SP', 'Brasil', '20654-90'),
                            ('3', 'jose', 'santos', 'M', '1987-10-12',
							'rua X', 'Cidade Y', 'SP', 'Brasil', '20654-90'),
							('4', 'Maria', 'Oliveira', 'M', '1987-10-12',
							'rua X', 'Cidade Y', 'SP', 'Brasil', '20654-90'),
                            ('5', 'Matheus', 'Oliveira', 'M', '1987-10-12',
							'rua X', 'Cidade Y', 'SP', 'Brasil', '20654-90');
                            
select * from pessoa;

/* apagando tabelas */
drop table pessoa;
drop table comida_fav;

/* apagando dados da tabela pessoa */
delete from pessoa where pessoa_id = 1 or pessoa_id = 2;

insert into comida_fav values (3,'lasanha'),
(4,'churras'), (5,'macarrão');

select * from comida_fav;
 
select * from pessoa, comida_fav;
