DROP TABLE IF EXISTS user CASCADE;

CREATE TABLE user
(
    id      bigint  NOT NULL AUTO_INCREMENT primary key,
    user_id varchar NOT NULL
);


CREATE TABLE column
(
    id       bigint not null AUTO_INCREMENT primary key,
    title    varchar,
    user_key int,
    user     bigint references user (id)
);

CREATE TABLE card
(
    id         bigint NOT NULL AUTO_INCREMENT primary key,
    title      varchar,
    content    varchar,
    column     bigint references column (id),
    column_key int,
);

