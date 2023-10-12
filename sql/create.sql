create database acm;

create table team_type
(
    id serial primary key,
    name varchar(20) not null unique
);

create table olympiad
(
    id serial primary key,
    name varchar(150) not null unique,
    is_opened_registration bool default(false),
    type varchar(10) not null check(type in ('ICPC', 'IOI'))
);

create table tshirt_size
(
    id serial primary key,
    name varchar(5) not null unique
);

create table role
(
    id serial primary key,
    name varchar(50) not null unique
);

create table users
(
    id serial primary key,
    username varchar(30) not null unique,
    email varchar(60) not null unique check(email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
    firstname varchar(50) not null,
    midname varchar(50) not null,
    lastname varchar(50) not null,
    education varchar(200) not null,
    password varchar(200) not null,
    salt varchar(50) not null
);

create unique index fullname on users
(
    lower(firstname),
    lower(midname),
    lower(lastname)
);

create table olymp_stage
(
    id serial primary key,
    name varchar(20) not null,
    olympiad_id integer not null,
    start timestamp not null,
    foreign key (olympiad_id) references olympiad (id) on delete cascade
);

create unique index olymp_stage_name on olymp_stage
(
    name,
    olympiad_id
);

create table email_template
(
    id serial primary key,
    olymp_stage_id integer not null,
    content text not null,
    foreign key (olymp_stage_id) references olymp_stage (id) on delete cascade
);

create table team
(
    id serial primary key,
    name varchar(50) not null unique,
    status varchar(20) default('not done') check(status in ('not done', 'pending', 'approved', 'disqualified')),
    type_id integer not null,
    code varchar(8) not null,
    stage_id integer not null,
    tag varchar(20),
    olympiad_id integer not null,
    foreign key (type_id) references team_type (id) on delete cascade,
    foreign key (stage_id) references olymp_stage (id) on delete cascade,
    foreign key (olympiad_id) references olympiad (id) on delete cascade
);

create unique index team_code on team(code);

create table coach
(
    id serial primary key,
    email varchar(60) not null unique check(email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
    firstname varchar(50) not null,
    midname varchar(50) not null,
    lastname varchar(50) not null,
    tshirt_id integer,
    team_id integer not null,
    foreign key (team_id) references team (id) on delete restrict,
    foreign key (tshirt_id) references tshirt_size (id) on delete set null
);

create table participant
(
    id serial primary key,
    user_id integer not null,
    firstname varchar(50),
    midname varchar(50),
    lastname varchar(50),
    tshirt_id integer,
    team_id integer,
    education varchar(200) not null,
    foreign key (team_id) references team (id) on delete set null,
    foreign key (tshirt_id) references tshirt_size (id) on delete set null
);

create index participant_to_team on participant
(
    team_id
);

create table role_to_user
(
    user_id integer not null,
    role_id integer not null,
    primary key (user_id, role_id),
    foreign key (user_id) references users(id),
    foreign key (role_id) references role(id)
);

drop table role_to_user;
drop table participant;
drop table coach;
drop table team;
drop table email_template;
drop table olymp_stage;
drop table users;
drop table role;
drop table tshirt_size;
drop table olympiad;
drop table team_type;
