-- 5-1

CREATE TABLE ArrayTbl2
 (key   CHAR(1) NOT NULL,
    i   INTEGER NOT NULL,
  val   INTEGER,
  PRIMARY KEY (key, i));

/* AはオールNULL、Bは一つだけ非NULL、Cはオール非NULL */
INSERT INTO ArrayTbl2 VALUES('A', 1, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 2, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 3, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 4, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 5, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 6, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 7, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 8, NULL);
INSERT INTO ArrayTbl2 VALUES('A', 9, NULL);
INSERT INTO ArrayTbl2 VALUES('A',10, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 1, 3);
INSERT INTO ArrayTbl2 VALUES('B', 2, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 3, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 4, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 5, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 6, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 7, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 8, NULL);
INSERT INTO ArrayTbl2 VALUES('B', 9, NULL);
INSERT INTO ArrayTbl2 VALUES('B',10, NULL);
INSERT INTO ArrayTbl2 VALUES('C', 1, 1);
INSERT INTO ArrayTbl2 VALUES('C', 2, 1);
INSERT INTO ArrayTbl2 VALUES('C', 3, 1);
INSERT INTO ArrayTbl2 VALUES('C', 4, 1);
INSERT INTO ArrayTbl2 VALUES('C', 5, 1);
INSERT INTO ArrayTbl2 VALUES('C', 6, 1);
INSERT INTO ArrayTbl2 VALUES('C', 7, 1);
INSERT INTO ArrayTbl2 VALUES('C', 8, 1);
INSERT INTO ArrayTbl2 VALUES('C', 9, 1);
INSERT INTO ArrayTbl2 VALUES('C',10, 1);

-- nullでもunknownになり非表示になるのでnullの場合はtrueになるようにする？
select distinct key
from arraytbl2 t1
where
	not exists (
		select * 
		from arraytbl2 t2
		where
			t1.key = t2.key
			and (
					t2.val is null
					or 1 <> t2.val 
				)
	)
	
-- havingの場合
select key
from arraytbl2 t
group by key
having count(*) = sum(
	case when t.val = 1 then 1
		else 0 end
)

-- 5-2
select * 
from projects p1
where 1 = all
	(
		select case
			when step_nbr <= 1 and status = '完了' then 1
			when step_nbr >  1 and status = '待機' then 1
			else 0 end
		from projects p2
		where p1.project_id = p2.project_id
	)
	
-- 5-3
-- 数列を用意
create table Digits
(digit integer);

insert into Digits values(0);
insert into Digits values(1);
insert into Digits values(2);
insert into Digits values(3);
insert into Digits values(4);
insert into Digits values(5);
insert into Digits values(6);
insert into Digits values(7);
insert into Digits values(8);
insert into Digits values(9);

create table Numbers
(num integer);

insert into Numbers
select d1.digit + (D2.digit * 10) + 1 as num
from digits d1 cross join digits d2
order by num;

select * from Numbers


-- 素数表示

select num
from Numbers n1
where not exists (
	select *
	from Numbers n2
	where
		n1.num > n2.num
		and n2.num <> 1
		and (n1.num % n2.num) = 0
)
and num <> 1