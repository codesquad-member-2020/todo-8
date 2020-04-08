DROP TABLE IF EXISTS user CASCADE;

CREATE TABLE user (
  seq           bigint NOT NULL AUTO_INCREMENT,
  id            varchar(50) NOT NULL,
  PRIMARY KEY (seq),
  CONSTRAINT unq_user_id UNIQUE (id)
);
