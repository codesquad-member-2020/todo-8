DROP TABLE IF EXISTS `user` CASCADE;
DROP TABLE IF EXISTS list CASCADE;
DROP TABLE IF EXISTS card CASCADE;
DROP TABLE IF EXISTS activity CASCADE;

CREATE TABLE user
(
    id        bigint      NOT NULL AUTO_INCREMENT,
    user_name varchar(25) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT unq_user_id UNIQUE (user_name),
);


CREATE TABLE category
(
    id        bigint      NOT NULL AUTO_INCREMENT,
    user_id   bigint      NOT NULL REFERENCES `user` (id),
    title     varchar(50) NOT NULL,
    author    varchar(25) NOT NULL REFERENCES `user` (user_name),
    create_at datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP(),
--     users_key   int NOT NULL DEFAULT '0',
    PRIMARY KEY (id)
);

CREATE TABLE card (
    id              bigint NOT NULL AUTO_INCREMENT,
    category_id     bigint REFERENCES category (id),
    category_key    int,
    title           varchar(50) NOT NULL,
    author          varchar(25) NOT NULL REFERENCES `user` (user_name),
    contents        varchar(500),
    create_at       datetime NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    modify_at       datetime NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (id)
);

CREATE TABLE activity
(
    id           bigint   NOT NULL AUTO_INCREMENT,
    author       varchar(25)  NOT NULL REFERENCES `user` (user_name),
    action       varchar(25)  NOT NULL,
    target_name  varchar(50)  NOT NULL,
    departure    bigint,
    arrival      bigint,
    create_at    datetime NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (id)
);
