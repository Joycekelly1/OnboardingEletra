create table cadastro(
  id serial primary key,
  nome varchar (100),
  cpf char (11),
  idade int,
  cidade varchar (50)
);
insert into public.cadastro(nome, cpf, idade, cidade)
values ('Joyce Kelly', 52998224725, 22, 'Fortaleza'),
       ('Willame Ferreira', 16899535009, 29, 'Fortaleza'),
       ('Ana Frota', 45317828791, 22, 'Maracanaú'),
       ('Layla Pinheiro', 29537914806, 21, 'Maracanaú'),
       ('Lucas Maia', 71460238014, 25, 'Fortaleza'),
       ('Yascara Mara', 39053344705, 18, 'Maracanaú'),
       ('Michelle Moreira', 82746192000, 44, 'Maracanaú'),
       ('Suelen Maciel', 14687329068, 23, 'Maracanaú'),
       ('Hermeson Vicente', 90124578036, 28, 'Fortaleza'),
       ('Nayara Linhares', 67258091042, 29, 'Fortaleza');

select * from cadastro;
------------------------------------------------------------------------------------------------------------------------
create table cinema(
 id serial primary key,
 nome varchar (50),
 cidade varchar (50)
);

insert into cinema(nome, cidade)
values ('Cine Maracaúna', 'Maracanaú'),
       ('Cine Iracema', 'Fortaleza');

select * from cinema;
------------------------------------------------------------------------------------------------------------------------

create table produtos(
id serial primary key,
produtos varchar (100),
valor numeric (5,2),
ativo boolean
);

insert into produtos(produtos, valor, ativo)
values ('Pipoca Pequena 120g', 12.00, 'True'),
       ('Pipoca Média 200g', 16.00, 'True'),
       ('Balde Pipoca 350g', 25.00, 'True'),
       ('Adicional de Manteiga', 3.50, 'True'),
       ('Refrigerante Lata Coca-Cola 350ml', 8.00, 'True'),
       ('Refrigerante Lata Pepsi 350ml', 7.00, 'True'),
       ('Refrigerante Lata Guaraná 350ml', 6.50, 'True'),
       ('Porção Média de Batata Frita 350g', 9.90, 'True'),
       ('Porção Grande de Batata Frita 500g', 15.00, 'True'),
       ('Pacote Bala Fini Cítrico Morango 80g', 7.00, 'False'),
       ('Água Mineral 500ml', 6.00, 'True'),
       ('Ingresso Inteira', 20.00, 'True'),
       ('Ingresso Meia', 10.00, 'True');

select * from produtos;
------------------------------------------------------------------------------------------------------------------------
create table filmes(
id serial primary key,
nome varchar (50),
classficiação_indicativa int
);

insert into filmes(nome, classficiação_indicativa)
values ('Ai que vida', 10),
       ('A Vida é Bela', 12),
       ('Se Beber, Não Case!', 16),
       ('Cidade de Deus', 18),
       ('O Auto da Compadecida', 12),
       ('Tropa de Elite', 16),
       ('Kung Fu Hustle', 14),
       ('True Legend', 16),
       ('Truque de Mestre', 12),
       ('Homem-Aranha: Um Novo Dia', 10);

select * from filmes;
------------------------------------------------------------------------------------------------------------------------
create table cartaz(
id serial primary key,
filmes_id integer not null,
cinema_id integer not null,
ativo boolean,
    foreign key (filmes_id) references filmes(id),
    foreign key (cinema_id) references cinema(id)
);

insert into public.cartaz(filmes_id, cinema_id, ativo)
values (1, 1, 'True'),
       (2, 2, 'True'),
       (3, 2, 'True'),
       (4, 1, 'False'), --BOTAR DATA ANTIGA
       (5, 1, 'False'), --BOTAR DATA ANTIGA
       (6, 1, 'True'),
       (7, 2, 'True'),
       (8, 2, 'True'),
       (9, 1, 'False'), --BOTAR DATA ANTIGA
       (10, 2, 'False') --30/07/26
;

select * from cartaz;
------------------------------------------------------------------------------------------------------------------------
create table sessões (
id serial primary key,
cartaz_id integer not null,
data_hora timestamp(0),
sala int,
    foreign key (cartaz_id) references cartaz(id)
);

insert into sessões(cartaz_id, data_hora, sala)
values (1, '2026-04-01 18:00:00', 01), --(MARA)
       (2, '2026-03-21 18:45:00', 03), --(FORT)
       (3, '2026-03-22 19:00:00', 02), --(FORT)
       (4, '2026-02-20 18:30:00', 05), --antigo --(MARA)
       (5, '2026-03-15 17:00:00', 04), --antigo --(MARA)
       (6, '2026-03-21 19:00:00', 02), --(MARA)
       (7, '2026-03-21 20:00:00', 03), --(FORT)
       (8, '2026-03-28 19:30:00', 01), --(FORT)
       (9, '2026-02-19 20:45:00', 01), --antigo --(MARA)
       (10,'2026-07-30 21:30:00', 01); --ainda vai lançar --(FORT)

select * from sessões;
------------------------------------------------------------------------------------------------------------------------
create table carrinho(
id serial primary key,
cadastro_id integer not null,
produtos_id integer not null,
sessões_id integer null,
    foreign key (cadastro_id) references cadastro(id),
    foreign key (produtos_id) references produtos(id),
    foreign key (sessões_id) references sessões(id)
);

insert into carrinho(cadastro_id, produtos_id, sessões_id)
values (1, 13, 8),
       (1, 7, 8),
       (1, 2, 8),
       (2, 3, 1),
       (2, 5, 1),
       (2, 13, 1),
       (3, 9,  7),
       (3, 11,  7),
       (3, 12,  7),
       (4, 5,  5),
       (4, 3,  5),
       (4, 4,  5),
       (4, 12,  5),
       (5, 11, null),
       (6, 2,  6),
       (6, 4,  6),
       (6, 13,  6),
       (7, 2, 2),
       (7, 6, 2),
       (7, 8, 2),
       (7, 13, 2),
       (8, 9,  9),
       (8, 7,  9),
       (8, 12,  9),
       (9, 11,  4),
       (9, 12,  4),
       (10, 3,  10),
       (10, 13,  10)
;

select * from carrinho;
------------------------------------------------------------------------------------------------------------------------

    select cd.nome, cpf, idade, c.nome, c.cidade, STRING_AGG(pd.produtos, ', ') AS produtos, SUM(pd.valor) AS valor, f.nome, data_hora, sala
    from cadastro cd
    left join carrinho cr on cr.cadastro_id = cd.id
    left join produtos pd on pd.id = cr.produtos_id
    left join cinema c on c.cidade = cd.cidade
    left join sessões s on cr.sessões_id = s.id
    left join cartaz c2 on s.cartaz_id = c2.id
    left join filmes f on c2.filmes_id = f.id

     group by cd.nome, cpf, idade, c.nome, c.cidade, f.nome, data_hora, sala;

