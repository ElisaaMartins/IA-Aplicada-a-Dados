-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- tabela cliente
create table client(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Adress varchar(30),
    constraint unique_cpf_client unique (CPF)
);

-- tabela produto
create table product(
	idProduct  int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum ('Eletrônico','Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliação float default 0,
    size varchar(10)
    -- constraint unique_cpf_client unique (CPF)
);

-- tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum ('Cancelado','Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    -- idpayment,
    paymentCash boolean default false,
    constraint fk_ordes_client foreign key (idOrderClient) references client(idClient)
);

-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias 
-- além disso, reflita essa modificação no diagrama de esquema relacional 
-- criar constraints relacionadas ao pagamento
create table payments( 
	idclient int, 
	idPayments int, 
	typePayment enum ('Boleto', 'Cartão', 'Dois cartões'), 
	limitAvailable float, 
	primary key(idClient, id_payment) 
);

-- tabela estoque
create table productStorage( 
	idProdStorage int auto_increment primary key, 
	storageLocation varchar(255),
    quantity int default 0
);

-- tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- tabela vendedor
create table seller( 
	idSeller int auto_increment primary key, 
	SocialName varchar(255) not null, 
	AbstName varchar(255), 
	CNPJ char(15), 
	CPF char(9), 
	location varchar(255), 
	contact char(11) not null, 
	constraint unique_cnpj_seller unique (CNPJ), 
	constraint unique_cpf_seller unique (CPF)
);

create table productSeller( 
	idPseller int, 
	idProduct int, 
	prodQuantity int default 1, 
	primary key (idPseller, idProduct), 
	constraint fk_product_seller foreign key (idPseller) references seller(idSeller), 
	constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

create table productOrder( 
	idPoproduct int, 
	idPOorder int, 
	poQuantity int default 1, 
	poStatus enum ('Disponível', 'Sem estoque') default 'Disponível', 
	primary key (idPOproduct, idPoorder),
	constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct), 
	constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
); 

create table storageLocation( 
	idLproduct int, 
	idLstorage int, 
	location varchar(255) not null, 
	primary key (idLproduct, idLstorage), 
	constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct), 
	constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage) 
); 

show databases;
use information_schema;
show tables;
desc  referencial_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';
