-- 7-1
CREATE TABLE Accounts
(prc_date DATE NOT NULL , 
 prc_amt  INTEGER NOT NULL , 
 PRIMARY KEY (prc_date)) ;

DELETE FROM Accounts;
INSERT INTO Accounts VALUES ('2018-10-26',  12000 );
INSERT INTO Accounts VALUES ('2018-10-28',   2500 );
INSERT INTO Accounts VALUES ('2018-10-31', -15000 );
INSERT INTO Accounts VALUES ('2018-11-03',  34000 );
INSERT INTO Accounts VALUES ('2018-11-04',  -5000 );
INSERT INTO Accounts VALUES ('2018-11-06',   7200 );
INSERT INTO Accounts VALUES ('2018-11-11',  11000 );

select * from accounts;

-- window関数による
select prc_date, prc_amt,
	avg(prc_amt) over(order by prc_date rows between 2 preceding and current row)
from accounts;

-- 相関サブクエリによる（わからんかった）
-- ポイント	
-- 相関サブクエリをselect句で行う
-- countをつかってbetweenが3になる値がsize=3になる
select prc_date, a1.prc_amt,
	(select avg(prc_amt)
		from accounts a2
		where a1.prc_date >= a2.prc_date
		and (select count(*) from accounts a3 where a3.prc_date between a2.prc_date and a1.prc_date) <= 3
	) as mvg_sum
from accounts a1
order by prc_date;


-- window関数による（満たない場合はnull）
-- 少し強引かと思ったが解答例も同じ感じだった
select prc_date, prc_amt,
		case
			when count(prc_amt) over(order by prc_date rows between 2 preceding and current row) <> 3 then null
		else
			avg(prc_amt) over(order by prc_date rows between 2 preceding and current row) 
		end
from accounts;



-- 相関サブクエリによる（満たない場合はnull）
-- やりかたは同じでcountが3になってるかをcase式で確認
-- 解答例ではhavingで数えていた
select prc_date, a1.prc_amt,
	(select 
			case when count(prc_amt) <> 3 then null
			else avg(prc_amt) end
		from accounts a2
		where a1.prc_date >= a2.prc_date
		and (select count(*) from accounts a3 where a3.prc_date between a2.prc_date and a1.prc_date) <= 3
	) as mvg_sum
from accounts a1
order by prc_date;