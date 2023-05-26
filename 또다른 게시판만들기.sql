delete from board;
drop table supernenechi;
drop table membership;
drop SEQUENCE supernenechi_seq;
drop table reply;
drop sequence reply_seq;
commit;

create table membership(
id varchar2(50) PRIMARY KEY,
pw varchar2(12) not null,
name varchar(100) not null,
address varchar(200) not null,
tel varchar(15),
email varchar(100) not null
);


create table supernenechi(
bno number not null PRIMARY KEY,
id varchar2(50),
title varchar(200),
content VARCHAR2(1000),
regdate date default sysdate,
cnt number default 0, 
file1 varchar2 (100), 
commend varchar2(1000)
);

CREATE SEQUENCE supernenechi_seq --����������
      START WITH 1
      INCREMENT BY 1
      NOCACHE
      NOCYCLE;
      
    -------
create table reply(
    bno number not null,
    rno number not null,
    id varchar2(50),
    content varchar2(1000) not null,
    regdate date default sysdate,
    primary key(bno, rno)
);

alter table reply add constraint reply_bno foreign key(bno)
references supernenechi(bno);



create SEQUENCE reply_seq 
start with 1 
minvalue 0;

-- reply test
insert into reply(bno, rno, id, content)
values(20,reply_seq.nextval,'admin', 'test reply');

select a.rno, a.content, b.name, a.regdate
    from reply a
   left outer join 
    membership b
    on 
     a.id  = b.id
     where bno =20;
   
    

      
-- ���߰� �Է��Ҷ� ����ϱ�.      
INSERT INTO supernenechi (bno, id, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'kuro'
   , '�ɽ��ϴ�'
   , '�ɽ��� '
   , null
   );
   
INSERT INTO supernenechi (bno, id, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'ruru'
   , '������'
   , 'ħ�뿡�� �ڰ�ͳ� ������ '
   , null
   );

INSERT INTO supernenechi (bno, id, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'admin'
   , '� ����ϰ� �ͽ��ϴ�. '
   , '����ϸ� ���ڴ�. '
   , null
   );
   
INSERT INTO supernenechi (bno, id, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'tei'
   , '� ����ϰ� �ͽ��ϴ�. ������'
   , '���� ������ �׻� ���̱׸���'
   , null
   );

insert into membership (id, pw, name, address, tel, email)
values('kuro', 1234, 'people', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('ruru', 1234, 'people1', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('admin', 1234, 'people2', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('tei', 1234, 'kuro', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

------insert join
INSERT INTO supernenechi (bno, title, content, file1)
SELECT MAX(bno) + 1, '��ſ� �б���Ȱ', '�б��� ��ſ� ���̿��� ', null
FROM membership
WHERE name = 'kuro';

--- select join
SELECT s.bno, s.title, m.name, s.reg_date, s.cnt
FROM supernenechi s
JOIN membership m ON s.author_id = m.id;

	
		INSERT INTO supernenechi(
			bno, title, content, file1)
		values(
			supernenechi_seq.nextval,
			'as good as',
			'very good',  
			null
		);
	
--- List Query
select 
    a.bno, a.title, b.name, a.reg_date, a.cnt
from supernenechi a
left outer join membership b
on a.id  = b.id
order by bno desc;

-- read Query
select 
     a.bno, a.title, b.name, a.reg_date, a.cnt
		from 
			supernenechi a
		left outer join 
			membership b
		on 
			a.id  = b.id
		where
			bno = '3'
		order by bno DESC;
        
--update
UPDATE supernenechi
    SET title = '���̵� �׳�ġ',
        content = '����ê�� ����',
        file1 = null
    WHERE bno = 3;

-- delete
DELETE
    FROM supernenechi
WHERE bno = 66;

---paging
		select 
		    bno, title, name, reg_date, cnt
		from (
		    SELECT a.bno, a.title, b.name, a.reg_date, a.cnt, row_number() over(ORDER BY BNO DESC) AS RNUM
		    FROM supernenechi a
		    left outer join membership b
		    on a.id  = b.id
		    ) np
		where rnum between 1 and 10
		order by bno DESC;

select * from supernenechi;
select * from membership;
commit;