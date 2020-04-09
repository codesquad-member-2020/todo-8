INSERT INTO user(id, user_id) VALUES (1, 'guest1234');

INSERT INTO column(title, user_key, user)
VALUES ('todo', 0, 1);
INSERT INTO column(title, user_key, user)
VALUES ('doing', 1, 1);
INSERT INTO column(title, user_key, user)
VALUES ('done', 2, 1);

INSERT INTO card(title, content, column, column_key)
VALUES ('할 일 1', '할일 1 내용', 1, 0);
INSERT INTO card(title, content, column, column_key)
VALUES ('할 일 2', '할일 2 내용', 2, 0);

INSERT INTO card(title, content, column, column_key)
VALUES ('할 일 3', '할일 3 내용', 3, 0);
INSERT INTO card(title, content, column, column_key)
VALUES ('할 일 4', '할일 3 내용', 3, 1);
INSERT INTO card(title, content, column, column_key)
VALUES ('할 일 4', '할일 3 내용', 3, 2);

