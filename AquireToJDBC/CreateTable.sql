CREATE TABLE notice (
    id        NUMBER,
    title     NVARCHAR2(100),
    writer_id NVARCHAR2(50),
    content   CLOB,
    regdate   TIMESTAMP,
    hit       NUMBER,
    files     NVARCHAR2(1000)
);

CREATE TABLE role (
    id          VARCHAR2(50),
    discription NVARCHAR2(500)
);

CREATE TABLE member_role (
    member_id NVARCHAR2(50),
    role_id   VARCHAR2(50)
);

CREATE TABLE comments (
    id        NUMBER,
    content   VARCHAR(2000),
    regdate   TIMESTAMP,
    writer_id VARCHAR(50),
    notice_id NUMBER
);

CREATE TABLE member (
    id       VARCHAR(50),
    pwd      VARCHAR(50),
    name     VARCHAR(50),
    gender   NCHAR(2),
    birthday CHAR(10),
    phone    CHAR(13),
    regdate  DATE,
    email    VARCHAR(200)
);