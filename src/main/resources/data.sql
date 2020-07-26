DROP TABLE IF EXISTS users;

create sequence  IF NOT EXISTS vavishka_seq;

CREATE TABLE IF NOT EXISTS users (
  id bigint default vavishka_seq.nextval primary key,
  user_id char(30),
  email varchar(256) NOT NULL,
  mobile char(11),
  password char(128),
  email_verified number(1),
  name varchar(64),
  picture_url varchar(256),
  locale char(2),
  family_name varchar(64),
  given_name varchar(64)
);

delete from users where id in(1, 2);

INSERT INTO users (id, user_id, email, email_verified, password) values
(1, 'admin', 'admin', 1, '$2a$10$kcXK1Vjmy79dMr.T7j5AJuWAlrGTqKWu/dk7kPFYESJGHqdCdO4.K'),
(2, 'seo', 'seo', 1, '$2a$10$kcXK1Vjmy79dMr.T7j5AJuWAlrGTqKWu/dk7kPFYESJGHqdCdO4.K');

CREATE TABLE IF NOT EXISTS header (
    id bigint default vavishka_seq.nextval primary key,
    path varchar(128),
    orders number(1)
);

CREATE TABLE IF NOT EXISTS samples (
  id bigint default vavishka_seq.nextval primary key,
  title char(128),
  description varchar(256) NOT NULL,
  image_src varchar(256)
);

CREATE TABLE IF NOT EXISTS samples_session (
    id bigint default vavishka_seq.nextval primary key,
    samples_id bigint,
    title char(128),
    description varchar(256),
    detail varchar(4096) ,
    icon_src varchar(256),
    orders int,
    image_src1 varchar(256),
    image_src2 varchar(256),
    image_src3 varchar(256),
    image_src4 varchar(256),
    image_src5 varchar(256),
    image_src6 varchar(256),
    image_src7 varchar(256),
    image_src8 varchar(256),
    CONSTRAINT FK_SESSION_TO_SAMPLES FOREIGN KEY ( samples_id ) REFERENCES samples( id )
);