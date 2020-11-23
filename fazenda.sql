-- Criando o banco de dados

create database if not exists fazenda_bd;

-- Acessando o banco de dados

use fazenda_bd;

-- Criando as tabelas

create table if not exists funcionarios(
id bigint,
nome varchar(50) not null,
cpf int not null unique,
salario float(10,2) not null,
funcao int not null
);

create table if not exists funcoes(
id int,
nome varchar(15) not null
);

create table if not exists producaoLeite(
id bigint,
especie varchar(30) not null,
ultimaOrdenha date,
temperaturaLeite float(4,2),
produtividadeQuarto int,
inseminacoes enum("Sim","Não"),
estimativaParto date,
secagemEsperada date,
ruminacaoDia time
);

create table if not exists produtos(
id bigint,
nome varchar(30) not null,
tipo varchar(30) not null,
estoque int not null,
preco float(10,2) not null
);

create table if not exists equipamentos(
id bigint,
nome varchar(30) not null,
tipo varchar(30) not null,
quantidade int not null
);

create table if not exists varejistas(
id bigint,
cadastro date not null,
responsavel varchar(50) not null,
telefone varchar(15) not null,
email varchar(50) not null,
empresa varchar(50) not null,
tipo varchar(30) not null
);

create table orcamentos(
id bigint,
dataPedido date not null,
empresa bigint not null,
responsavel bigint not null,
telefone bigint not null,
email bigint not null,
produto bigint not null,
quantidade int not null,
preco bigint not null,
valorFinal float(10,2),
total float(10,2)
);

-- Criando PK

alter table funcionarios
add constraint pk_funcionarios
primary key(id),
modify id bigint auto_increment;

alter table funcoes
add constraint pk_funcoes
primary key(id),
modify id int auto_increment;

alter table produtos
add constraint pk_produtos
primary key(id),
modify id bigint auto_increment;

alter table equipamentos
add constraint pk_equipamentos
primary key(id),
modify id bigint auto_increment;

alter table varejistas
add constraint varejistas
primary key(id),
modify id bigint auto_increment;

alter table orcamentos
add constraint pk_orcamentos
primary key(id, empresa, responsavel, telefone, email, produto, preco),
modify id bigint auto_increment;

-- Criando FK

alter table funcionarios
add constraint fk_funcionarios_funcoes
foreign key(funcao)
references funcoes(id);

alter table orcamentos
add constraint fk_orcamentos_varejistas
foreign key(empresa)
references varejistas(id);

alter table orcamentos
add constraint fk_orcamentos_varejistas_r
foreign key(responsavel)
references varejistas(id);

alter table orcamentos
add constraint fk_orcamentos_varejistas_t
foreign key(telefone)
references varejistas(id);

alter table orcamentos
add constraint fk_orcamentos_varejistas_e
foreign key(email)
references varejistas(id);

alter table orcamentos
add constraint fk_orcamentos_produtos
foreign key(produto)
references produtos(id);

alter table orcamentos
add constraint fk_orcamentos_produtos_p
foreign key(preco)
references produtos(id);

-- Inserindo dados

insert into equipamentos(nome, tipo, quantidade) values 
("enxada", "manual", 10),
("pa","manual",10),
("trator","mecanico",3);

insert into funcoes(nome) values 
("operador de trator"),
("jardineiro"),
("ordenhador");

insert into funcionarios(nome, cpf, salario, funcao) values 
("jose","12345678911",2500.00,1),
("antonio","12345678912",2000.00,2),
("maria","12345678913",2500.00,3);

insert into producaoLeite
(especie,ultimaOrdenha,temperaturaLeite,
produtividadeQuarto,inseminacoes,estimativaParto,
secagemEsperada,ruminacaodia) values 
("branca","2020/05/12",35.7,45,"Sim","2020/12/12","2021/01/01","16:15"),
("marrom","2020/06/12",37.4,38,"Não","2021/01/12","2021/02/01","12:15"),
("preta e branca","2020/07/12",33.1,50,"Sim","2021/02/12","2021/03/01","14:15");

insert into produtos(nome,tipo,estoque,preco) values 
("leite","laticinio",500,2000.00),
("queijo","laticinio",200,3000.00),
("doce de leite","doce",50,1000.00);

insert into varejistas(cadastro,responsavel,telefone,email,empresa,tipo) values 
("2019/01/29","julia","(11)2222-2222","julia@juliainc.com.br","julia ME.","mercado"),
("2019/07/03","taty","(11)1111-1111","taty@tatyalimentos.com.br","taty alimentos","distribuidora"),
("2020/02/25","bernardo","(11)3333-3333","bernardo@bernardoalimentos.com.br","bernardo alimentos","mercado");

insert into orcamentos(dataPedido,empresa,responsavel,telefone,email,produto,quantidade,preco,valorFinal,total) 
values 
("2019/01/29",1,1,1,1,1,50,1,200.00,200.00),
("2019/07/03",2,2,2,2,2,50,2,40.00,40.00),
("2020/02/25",3,3,3,3,3,50,3,1000.00,1000.00),
("2019/05/03",1,1,1,1,1,100,1,400.00,400.00),
("2019/09/21",2,2,2,2,2,100,2,80.00,80.00),
("2020/03/25",3,3,3,3,3,100,3,400.00,400.00);

-- Consultas

-- Consultar orcamento por empresa.
select 
o.id as "Número",
o.dataPedido as "Data",
v.empresa as "Empresa",
v.responsavel as "Responsável",
v.telefone as "Telefone",
v.email as "E-mail",
p.nome as "Produto",
o.quantidade as "Qtd",
p.preco as "Valor",
o.valorFinal as "Valor do intem",
o.total as "Total" 
from orcamentos o 
inner join varejistas v
on o.empresa = v.id
and o.responsavel = v.id
and o.telefone = v.id
and o.email = v.id
inner join produtos p
on o.produto = p.id
and o.preco = p.id
where o.empresa = 3;

-- Consultar orcamento por responsavel.
select 
o.id as "Número",
o.dataPedidao as "Data",
v.empresa as "Empresa",
v.responsavel as "Responsável",
v.telefone as "Telefone",
v.email as "E-mail",
p.nome as "Produto",
o.quantidade as "Qtd",
p.preco as "Valor",
o.valorFinal as "Valor do intem",
o.total as "Total" 
from orcamentos o 
inner join varejistas v
on o.empresa = v.id
and o.responsavel = v.id
and o.telefone = v.id
and o.email = v.id
inner join produtos p
on o.produto = p.id
and o.preco = p.id
where o.responsavel = 3;

-- Consultar orcamento por id
select 
o.id as "Número",
o.dataPedido as "Data",
v.empresa as "Empresa",
v.responsavel as "Responsável",
v.telefone as "Telefone",
v.email as "E-mail",
p.nome as "Produto",
o.quantidade as "Qtd",
p.preco as "Valor",
o.valorFinal as "Valor do intem",
o.total as "Total" 
from orcamentos o 
inner join varejistas v
on o.empresa = v.id
and o.responsavel = v.id
and o.telefone = v.id
and o.email = v.id
inner join produtos p
on o.produto = p.id
and o.preco = p.id
where o.id = 10;

-- Contar quanto orçamentos tem por data
select count(id) as "Número de orçamentos" from orcamentos
where dataPedido < "2020/04/01" and dataPedido > "2020/01/01";

-- contar quantas empresas tem por ramo
select count(id) as "Número de empresa", tipo as "Ramo" from varejistas
where tipo = "mercado";

-- teste
select f.nome, u.nome from
funcionarios f
inner join funcoes u
on f.funcao = u.id;

select * from orcamentos;

-- alter
alter table funcionarios
modify cpf varchar(15) not null unique;

-- drop
drop database fazenda_bd;