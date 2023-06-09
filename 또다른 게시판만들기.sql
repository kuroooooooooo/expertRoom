-- drop
drop table supernenechi;
drop table membership;
drop SEQUENCE supernenechi_seq;
drop table reply;
drop sequence reply_seq;
drop table neneFile;
commit;

--회원가입
create table membership(
id varchar2(50) PRIMARY KEY, --회원아이디
pw varchar2(12) not null,-- 패스워드
name varchar(100),--이름
address varchar(200),--주소
tel varchar(15), --전화번호
email varchar(100)-- 이메일
);

--게시판 
create table supernenechi(
bno number not null PRIMARY KEY, --번호
userid varchar2(50), --아이디
title varchar(200), --게시글 제목
content VARCHAR2(1000), --내용
regdate date default sysdate, --날짜
cnt number default 0, --추천수
file1 varchar2 (100), --파일
commend varchar2(1000), --코멘트(댓글)
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

CREATE SEQUENCE supernenechi_seq --직원시퀀스
      START WITH 1
      INCREMENT BY 1
      NOCACHE
      NOCYCLE;
      
    -------
create table reply(
    bno number not null, --게시판 번호
    rno number not null, -- 덧글 번호
    userId varchar2(50), -- 아이디
    content varchar2(1000) not null, --내용
    regdate date default sysdate, --날짜
    primary key(bno, rno), --pk
    foreign key (userId) references membership (id) --fk
);

create SEQUENCE reply_seq 
start with 1 
minvalue 0;


--file table
create table neneFile(
    fileno number, -- 파일번호
    bno number not null, -- 게시판 번호
    orgFileN varchar2(300) not null, --원본 파일 이름
    hFileN varchar2(36) not null, -- 변경된 파일 이름
    fileS number, -- 파일크기
    regdate date default sysdate not null, --파일등록일
    delgb varchar2(1) default 'N' not null, --삭제구분
    primary key(fileno) --기본키 fileno
);

create sequence nenefile_seq
start with 1
increment by 1
nomaxvalue nocache;

commit;



------ 야베사마의 쿼리문

insert into reply 
    (bno, rno, content, userid)
		values(
			265, reply_seq.nextval,'조아', 'admin');


select * from reply where bno= 265;
        

     
-- 글추가 입력할때 사용하기.      
INSERT INTO supernenechi (bno, userid, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'kuro'
   , '심심하다'
   , '심심해 '
   , null
   );
   
INSERT INTO supernenechi (bno, userid, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'ruru'
   , '졸리다'
   , '침대에서 자고싶네 ㅋㅋㅋ '
   , null
   );

INSERT INTO supernenechi (bno, userid, title, content,  file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'admin'
   , '어서 퇴근하고 싶습니다. '
   , '퇴근하면 좋겠다. '
   , null
   );
   
INSERT INTO supernenechi (bno, userid, title, content, file1) 
VALUES
   ( supernenechi_seq.nextval
   ,'tei'
   , '어서 퇴근하고 싶습니다. 꺄르르'
   , '언제 집가지 항상 집이그리워'
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
		'경기도 시흥시 은행동 123-12', 
		'010-1234-5678', 
		'kkp@naver.com'
	);
select * from membership;

insert into membership (
			id, pw, name, address, tel, email)
		values(
		'sara', 1111, 'hosikawa', '도쿄 아키하바라현 어딘가' ,'010-4567-1234', 'hosikawa@naver.com');

-- membership insert
insert into membership (id, pw, name, address, tel, email)
values('kuro', 1234, 'people', '경기도 파주시 안양빌라 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('ruru', 1234, 'people1', '경기도 파주시 안양빌라 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('admin', 1234, 'people2', '경기도 파주시 안양빌라 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('tei', 1234, 'kuro', '경기도 파주시 안양빌라 123-1' , '010-1345-6789', 'ai@naver.com');

insert into membership (id, pw, name, address, tel, email)
values('kuroi', 1234, 'kuroi', '경기도 파주시 안양빌라 123-1' , '010-1345-6789', 'ai@naver.com');

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
    SET title = '아이돌 네네치',
        content = '슈퍼챗을 쏘자',
        file1 = null
    WHERE bno = 3;
    
        update 
			supernenechi
		set 
			title = '왜 안될까',
			content = '왜...어째서...?어쨰서?어쨰서?어쨰서?어쨰서?어쨰서?어쨰서?어쨰서?'
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
			name ='키왕짱',
			address = '알아서 뭐할거야',
			tel='010-7744-1002',
			email='YangNari@Nizisanji@nijisanji.jp'
		WHERE id='ruru';


INSERT INTO supernenechi (
		bno, userid, title, content, file1
		) VALUES( 
		supernenechi_seq.nextval
		,'kuro'
		,'즐거운 우리집'
		,'우리집은 즐거워'
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


