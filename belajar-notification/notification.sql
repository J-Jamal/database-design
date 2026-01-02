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

CREATE table notification (
    id INT not null auto_increment,
    title varchar(255) not null,
    detail TEXT not null,
    created_at timestamp not null,
    user_id varchar(100),
    primary key (id) 
)engine=InnoDB;

desc notification;

alter table notification
    add constraint fk_notification_user
        foreign key (user_id) references user (id);

insert into notification(title, detail, created_at, user_id) values('Contoh Pesanan', 'Detail Pesanan', current_timestamp(), 'jeje');
insert into notification(title, detail, created_at, user_id) values('Contoh Promo', 'Detail Promo', current_timestamp(), null);
insert into notification(title, detail, created_at, user_id) values('Contoh Pembayaran', 'Detail Pembayaran', current_timestamp(), 'udin');

select * from notification;

USE belajar_mysql_notification;
SHOW TABLES;

select * from notification where (user_id = 'jeje' or user_id is null) order by created_at desc;
select * from notification where (user_id = 'udin' or user_id is null) order by created_at desc;

CREATE table category (
    id      varchar(100) not null,
    name    varchar(100) not null,
    primary key (id)
)engine=InnoDB;

show tables;

alter table notification add column category_id varchar(100);

desc notification;

alter table notification
add constraint fk_notification_category
foreign key (category_id) references category(id);

desc notification;

select * from notification;

insert into category (id, name) values ('INFO', 'Info');
insert into category (id, name) values ('PROMO', 'Promo');

select * from category;

update notification set category_id  = 'INFO' where id = 1;
update notification set category_id  = 'PROMO' where id = 2;
update notification set category_id  = 'INFO' where id = 3;

select * from notification;

select * from notification
where (user_id = 'jeje' or user_id is null)
order by created_at desc;

select * from notification n
join category c on (n.category_id = c.id)
where (n.user_id = 'jeje' or n.user_id is null)
order by created_at desc;

select * from notification n
join category c on (n.category_id = c.id)
where (n.user_id = 'udin' or n.user_id is null)
order by created_at desc;

select * from notification n
join category c on (n.category_id = c.id)
where (n.user_id = 'jeje' or n.user_id is null) and c.id = 'PROMO'
order by created_at desc;


create table notification_read (
    id      INT not null auto_increment,
    is_read boolean not null,
    notification_id int not null,
    user_id varchar(100) not null,
    primary key (id)
)engine=InnoDB;

show tables;

alter table notification_read
add constraint fk_notification_read_notification
foreign key (notification_id) references notification (id);

alter table notification_read
add constraint fk_notification_read_user
foreign key (user_id) references user (id);

desc notification_read;

select * from notification;

insert into notification_read (is_read, notification_id, user_id) values (true, 2, 'jeje');

insert into notification_read (is_read, notification_id, user_id) values (true, 2, 'udin');

select * from notification_read;

select * from notification n
join category c on (n.category_id = c.id)
left join notification_read nr on (nr.notification_id = n.id)
where (n.user_id = 'jeje' or n.user_id is null)
and (nr.user_id = 'jeje' or nr.user_id is null)
order by created_at desc;

insert into notification(title, detail, category_id, user_id, created_at)
values ('Contoh Pesanan Lagi', 'Detail Pesanan Lagi', 'INFO', 'jeje', current_timestamp())

insert into notification(title, detail, category_id, user_id, created_at)
values ('Contoh Promo Lagi', 'Detail Promo Lagi', 'PROMO', null, current_timestamp())


select count (*) from notification n
join category c on (n.category_id = c.id)
left join notification_read nr on (nr.notification_id = n.id)
where (n.user_id = 'jeje' or n.user_id is null)
and (nr.user_id is null)
order by created_at desc;

insert into notification_read (is_read, notification_id, user_id) values (true, 5, 'jeje');