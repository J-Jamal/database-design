CREATE DATABASE studikasus_multi_bahasa;

use studikasus_multi_bahasa;

CREATE table categories (
    id varchar(100),
    position INT,
    primary key (id)
) engine InnoDB;

describe categories;

insert into categories(id, position) values ('FOOD', 1);
insert into categories(id, position) values ('GADGET', 2);
insert into categories(id, position) values ('FASHION', 3);

select * from categories order by position;

CREATE table categories_translations
(
    category_id varchar(100) not null,
    language    varchar(100) not null,
    name        varchar(100) not null,
    description text,
    primary key (category_id, language)
) engine=InnoDB;

describe categories_translations;

alter table categories_translations
    add constraint fk_categories_translation
    foreign key (category_id) references categories (id);

select * from categories join categories_translations ct on categories.id = ct.category_id;

insert into categories_translations (category_id, language, name, description) 
values ('FOOD', 'in_ID', 'Makanan ', 'Deskripsi Makanan');
insert into categories_translations (category_id, language, name, description) 
values ('GADGET', 'in_ID', 'Gawai ', 'Deskripsi Gawai');
insert into categories_translations (category_id, language, name, description) 
values ('FOOD', 'en_US', 'Food', 'FOOD Description');
insert into categories_translations (category_id, language, name, description) 
values ('GADGET', 'en_US', 'Gadget', 'Gadget Description');

select * from categories
    join categories_translations ct on categories.id = ct.category_id
    where ct.language = 'in_ID' order by position;