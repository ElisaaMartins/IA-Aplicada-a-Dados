-- create database company; 
create schema if not exists company; 
use company; 

-- not suported by mysql I 
-- create domain D_num as int check(D_num> 0 and D_num <21); 

CREATE TABLE employee( 
	Fname varchar(15) not null, 
	Minit char, 
	Lname varchar(15) not null, 
	Ssn char(9) not null, 
	Bdate date, 
	Address varchar(30), 
	Sex char, 
	Salary decimal(10,2), 
	SuperSsn char(9), 
	Dno int not null, 
	primary key (Ssn)
);

-- outra maneira de criar tabela 'nomeBD.nomeTabela
create table company.employee( 
	Fname varchar(15) NOT NULL, 
	Minit char, 
	Lname varchar(15) NOT NULL, 
	Ssn char(9) NOT NULL,  
	Bdate DATE, 
	Address varchar(30), 
	sex char,  
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int NOT NULL,
	primary key (Ssn) 
); 
 
create table departament( 
	Dname varchar(15) not null, 
	Dnumber int not null, 
	Mgr_ssn char(9), 
	Mgr_start_date date, 
	primary key (Dnumber), 
	unique (Dname),
	foreign key (Mgr_ssn) references employee(Ssn)
);

create table dept_locations( 
	Dnumber int not null, 
	Dlocation varchar(15) not null, 
	primary key (Dnumber, Dlocation), 
	foreign key (Dnumber) references departament (Dnumber) 
);

create table project(
	Pname varchar(15) not null, 
	Pnumber int not null, 
	Plocation varchar(15), 
	Dnumber int not null, 
	primary key (Pnumber),  
	unique (Pname), 
	foreign key (Dnumber) references departament (Dnumber) 
);

create table works_on(
	Essn char(9) not null, 
	Pno int not null, 
	Hours decimal(3,1) not null, 
	primary key (Essn, Pno), 
	foreign key (Essn) references employee(Ssn), 
	foreign key (Pno) references project (Pnumber) 
);

create table dependent( 
	Essn char(9) not null, 
	Dependent_name varchar(15) not null, 
	Sex char, --  F ou M 
	Bdate date, 
	Relationship varchar(8), 
	primary key (Essn, Dependent_name), 
	foreign key (Essn) references employee (Ssn)  
); 

show tables;
desc employee;
desc dependent;
desc works_on;
