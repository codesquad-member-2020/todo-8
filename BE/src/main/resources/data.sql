INSERT INTO `user` (id, user_name) VALUES (null,'ttozzi');

INSERT INTO category (id, user_id, title, author) VALUES (null, 1, '할일', 'ttozzi');
INSERT INTO category (id, user_id, title, author) VALUES (null, 1, '하는중','ttozzi');
INSERT INTO category (id, user_id, title, author) VALUES (null, 1, '다했음', 'ttozzi');

INSERT INTO card (id, category_id, title, author, contents, category_key) VALUES (null, 1,'페이지네이션 UI 리서치', 'ttozzi', '리서치를 열심히하자', 0);
INSERT INTO card (id, category_id, title, author, contents, category_key) VALUES (null, 1,'상세페이지 API', 'ttozzi','API API', 1);

INSERT INTO card (id, category_id, title, author, contents, category_key) VALUES (null, 2,'이번주 기획리뷰', 'ttozzi','기획이 참 좋다', 0);

INSERT INTO card (id, category_id, title, author, contents, category_key) VALUES (null, 3,'설정파일 분리 리팩토링', 'ttozzi','리팩토링',0);
INSERT INTO card (id, category_id, title, author, contents, category_key) VALUES (null, 3,'데모 환경 분석','ttozzi', '잘돌아간다', 1);
INSERT INTO card (id, category_id, title, author, contents, category_key) VALUES (null, 3,'프로젝트 생성', 'ttozzi','생성했다', 2);

INSERT INTO activity (id, author, `action`, target_name, departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','github 공부하기', 1, 2, '2020-03-01');
INSERT INTO activity (id, author, `action`, target_name, arrival, create_at) VALUES(null, 'ttozzi', 'added','설정 파일 분리 리팩토링', 1, '2020-03-02');
INSERT INTO activity (id, author, `action`, target_name, arrival, create_at) VALUES(null, 'ttozzi', 'added','추가합니다', 2, '2020-03-03');
INSERT INTO activity (id, author, `action`, target_name, arrival, create_at) VALUES(null, 'ttozzi', 'updated','로그1', 3, '2020-03-04');
INSERT INTO activity (id, author, `action`, target_name, arrival, create_at) VALUES(null, 'ttozzi', 'added','로그2', 3, '2020-03-05');
INSERT INTO activity (id, author, `action`, target_name, arrival, create_at) VALUES(null, 'ttozzi', 'deleted','로그3', 1, '2020-03-06');
INSERT INTO activity (id, author, `action`, target_name, arrival, create_at) VALUES(null, 'ttozzi', 'deleted','로그4', 2,'2020-03-07');
INSERT INTO activity (id, author, `action`, target_name, arrival, create_at) VALUES(null, 'ttozzi', 'deleted','로그5', 3,'2020-03-08');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그6', 1, 2, '2020-03-09');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그7', 1, 3, '2020-03-10');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그8', 3, 1, '2020-03-11');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그9', 2, 1, '2020-03-12');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그10', 3, 3, '2020-03-13');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그11', 1, 2, '2020-03-14');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그12', 2, 2, '2020-03-15');
INSERT INTO activity (id, author, `action`, target_name,departure, arrival, create_at) VALUES(null, 'ttozzi', 'moved','로그13', 2, 2, '2020-03-16');




