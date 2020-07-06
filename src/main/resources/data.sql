DROP TABLE IF EXISTS users;

create sequence  IF NOT EXISTS users_seq;

CREATE TABLE IF NOT EXISTS users (
  id bigint default users_seq.nextval primary key,
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
