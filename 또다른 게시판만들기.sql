-- drop
drop table supernenechi;
drop table membership;
drop SEQUENCE supernenechi_seq;
drop table reply;
drop sequence reply_seq;
drop table neneFile;
commit;

--ȸ������
create table membership(
id varchar2(50) PRIMARY KEY, --ȸ�����̵�
pw varchar2(12) not null,-- �н�����
name varchar(100),--�̸�
address varchar(200),--�ּ�
tel varchar(15), --��ȭ��ȣ
email varchar(100)-- �̸���
);

--�Խ��� 
create table supernenechi(
bno number not null PRIMARY KEY, --��ȣ
userid varchar2(50), --���̵�
title varchar(200), --�Խñ� ����
content VARCHAR2(1000), --����
regdate date default sysdate, --��¥
cnt number default 0, --��õ��
file1 varchar2 (100), --����
commend varchar2(1000), --�ڸ�Ʈ(���)
foreign key (userid) references membership(id) ON DELETE CASCADE--fk
);

--select list 
		select 
			bno, title, userid, regdate, cnt
		from 
			supernenechi
		order by bno DESC;
        
        
-- update
update supernenechi
set content = 'abcd'
where bno = 1;
-- delete 
delete supernenechi



commit;
select * from membership;

--index setting
create index supernenechi_index
on supernenechi(bno desc);

select * from supernenechi;
----------------

CREATE SEQUENCE supernenechi_seq --����������
      START WITH 1
      INCREMENT BY 1
      NOCACHE
      NOCYCLE;
      
    -------
create table reply(
    bno number not null, --�Խ��� ��ȣ
    rno number not null, -- ���� ��ȣ
    userId varchar2(50), -- ���̵�
    content varchar2(1000) not null, --����
    regdate date default sysdate, --��¥
    primary key(bno, rno), --pk
    foreign key (userId) references membership (id) --fk
);

create SEQUENCE reply_seq 
start with 1 
minvalue 0;


--file table
create table neneFile(
    fileno number, -- ���Ϲ�ȣ
    bno number not null, -- �Խ��� ��ȣ
    orgFileN varchar2(300) not null, --���� ���� �̸�
    hFileN varchar2(36) not null, -- ����� ���� �̸�
    fileS number, -- ����ũ��
    regdate date default sysdate not null, --���ϵ����
    delgb varchar2(1) default 'N' not null, --��������
    primary key(fileno) --�⺻Ű fileno
);

create sequence nenefile_seq
start with 1
increment by 1
nomaxvalue nocache;

commit;



------ �ߺ��縶�� ������

insert into reply 
    (bno, rno, content, userid)
		values(
			265, reply_seq.nextval,'����', 'admin');


select * from reply where bno= 265;
        

     
-- ���߰� �Է��Ҷ� ����ϱ�.      
INSERT INTO supernenechi (bno, userid, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'kuro'
   , '�ɽ��ϴ�'
   , '�ɽ��� '
   , null
   );
   
INSERT INTO supernenechi (bno, userid, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'ruru'
   , '������'
   , 'ħ�뿡�� �ڰ�ͳ� ������ '
   , null
   );

INSERT INTO supernenechi (bno, userid, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'admin'
   , '� ����ϰ� �ͽ��ϴ�. '
   , '����ϸ� ���ڴ�. '
   , null
   );
   
INSERT INTO supernenechi (bno, userid, title, content, file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'tei'
   , '� ����ϰ� �ͽ��ϴ�. ������'
   , '���� ������ �׻� ���̱׸���'
   , null
   );
-----
insert into membership (
		id, 
		pw, 
		name, 
		address, 
		tel, 
		email )
	values(
		'pet', 
		1234, 
		'ohM', 
		'��⵵ ����� ���ൿ 123-12', 
		'010-1234-5678', 
		'kkp@naver.com'
	);
select * from membership;

insert into membership (
			id, pw, name, address, tel, email)
		values(
		'sara', 1111, 'hosikawa', '���� ��Ű�Ϲٶ��� ���' ,'010-4567-1234', 'hosikawa@naver.com');

-- membership insert
insert into membership (id, pw, name, address, tel, email)
values('kuro', 1234, 'people', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('ruru', 1234, 'people1', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('admin', 1234, 'people2', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('tei', 1234, 'kuro', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('kuroi', 1234, 'kuroi', '��⵵ ���ֽ� �Ⱦ���� 123-1' , '010-1345-6789', 'ai@naver.com');

update membership
set pw = 'abcd';
commit;
select * from membership;

------insert join


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
    
        update 
			supernenechi
		set 
			title = '�� �ȵɱ�',
			content = '��...��°��...?���?���?���?���?���?���?���?'
		where 
			bno = 10;
select * from supernenechi;
-- delete
DELETE
    FROM supernenechi
WHERE bno = 283;
select*from supernenechi;
---paging
		select 
			bno, title, userid, regdate, cnt
		from (
			SELECT 
				 bno, title, userid, regdate, cnt, 
				 row_number() over(ORDER BY BNO DESC) AS RNUM
			FROM 
				supernenechi 
			)np
		WHERE rnum BETWEEN 1 and 10
		order by bno DESC;

        SELECT
			id, pw
		FROM
			membership
		WHERE 
			id = 'hosikawaaaaa'
		AND pw = 1234;


select * from supernenechi;
select * from membership;
commit;
-- delete membership

DELETE 
			FROM membership
			WHERE id= 'tei'
			  AND pw= '1234';

--membership update

    UPDATE membership
		SET
			pw ='0101',
			name ='Ű��¯',
			address = '�˾Ƽ� ���Ұž�',
			tel='010-7744-1002',
			email='YangNari@Nizisanji@nijisanji.jp'
		WHERE id='ruru';


INSERT INTO supernenechi (
		bno, userid, title, content, file1
		) VALUES( 
		supernenechi_seq.nextval
		,'kuro'
		,'��ſ� �츮��'
		,'�츮���� ��ſ�'
		, null);
select * from supernenechi;
-- 


-- passChk
SELECT 1 
		FROM membership
;

SELECT COUNT(*) 
		FROM membership
		WHERE id = 'mini'
		  AND pw = '1234';
          
SELECT COUNT(*)
		FROM membership
		WHERE id = 'kuroneko';


