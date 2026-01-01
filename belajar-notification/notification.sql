CREATE DATABASE belajar_mysql_notification;

use belajar_mysql_notification;
show tables;

CREATE table user (
    id varchar(100) not null,
    name varchar(100) not null,
    primary key (id)
)engine=InnoDB;

insert into user (id, name)  values ('jeje', 'Jedag Jedug');
insert into user (id, name)  values ('udin', 'Usia Dini');

select * from user;