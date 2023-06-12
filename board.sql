create table mpBoard(
    BNO NUMBER NOT NULL,
    TITLE VARCHAR2(100)     NOT NULL,
    CONTENT VARCHAR2(2000)  NOT NULL,
    WRITER VARCHAR2(100)    NOT NULL,
    REGDATE DATE            DEFAULT SYSDATE,
    PRIMARY KEY(BNO)
);

CREATE SEQUENCE MPBOARD_SEQ
START WITH 1
INCREMENT BY 1;

INSERT INTO MPBOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (MPBOARD_SEQ.NEXTVAL, '제목입니다', '내용입니다', 'MELONPEACH');
     
SELECT * FROM MPBOARD;
COMMIT;


create table MPMEMBER(
    userid varchar2(40) not null,
    userpass varchar2(100) not null,
    username varchar2(40) not null,
    REGDATE DATE    DEFAULT SYSDATE,
    primary key(userid)
);

insert into mpmember(
    userid, userpass, username
) values(
    'kuro', '1234', '김말이'
);
select * from mpmember;
commit;
