drop table mikoboard;
drop SEQUENCE mikoboard_seq;
commit;

create table mikoboard(
    bno number not null,
    title varchar2(100) not null,
    content varchar2(2000) not null,
    userid varchar2(100) not null,
    regdate date default sysdate,
    cnt number default 0,
    
    primary key(bno)
);

CREATE SEQUENCE mikoboard_seq --Á÷¿ø½ÃÄö½º
      START WITH 1
      INCREMENT BY 1
      NOCACHE
      NOCYCLE;
--select 
    select * from mikoboard;
--insert
    insert into mikoboard(
        bno, title, content, userid
    )values(
        mikoboard_seq.nextval, 'titleªÇª¹'£¬'?é»ªÇª¹','kuro'
    );