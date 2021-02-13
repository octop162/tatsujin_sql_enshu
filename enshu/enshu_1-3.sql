-- 3-1
-- create table
Drop table Products;
CREATE TABLE Products
(name VARCHAR(16) PRIMARY KEY,
 price INTEGER NOT NULL);

DELETE FROM Products;
INSERT INTO Products VALUES('りんご',	100);
INSERT INTO Products VALUES('みかん',	50);
INSERT INTO Products VALUES('バナナ',	80);

select * from products;

-- ans
select p1.name as name_1, p2.name as name_2
from products p1 inner join products p2 on p1.name >= p2.name;



-- 3-2
DROP TABLE Products;
CREATE TABLE Products
(name VARCHAR(16) NOT NULL,
 price INTEGER NOT NULL);


--重複するレコード
INSERT INTO Products VALUES('りんご',	50);
INSERT INTO Products VALUES('みかん',	100);
INSERT INTO Products VALUES('みかん',	100);
INSERT INTO Products VALUES('みかん',	100);
INSERT INTO Products VALUES('バナナ',	80);
INSERT INTO Products VALUES('バナナ',	80);
INSERT INTO Products VALUES('バナナ',	80);
INSERT INTO Products VALUES('バナナ',	80);

select * from products;

-- やってみたが諦めた
-- 取り出せるがdeleteできない -> 中間テーブルからは消せないので無理
select * 
from (
	select 
		name,
		price,
		count(*) over (order by name rows between unbounded preceding and current row) as cnt
	from products 
) p1 
where exists (
	select
		*
	from (
		select 
			name,
			price,
			count(*) over (order by name rows between unbounded preceding and current row) as cnt
		from products 
	) p2
	where p1.price = p2.price and p1.name = p2.name and p1.cnt < p2.cnt
) 
;

-- 回答（3-A）から持ってきた
-- 既存テーブルでは重複する値は区別できないので、番号つきのテーブルを新規作成してそこで実行


-- (name, price)のパーティションに一意な連番を振ったテーブルを作成
CREATE TABLE Products_NoRedundant
AS
SELECT ROW_NUMBER()
         OVER(PARTITION BY name, price
                  ORDER BY name) AS row_num,
       name, price
  FROM Products;


-- 連番が1以外のレコードを削除
DELETE FROM Products_NoRedundant
  WHERE row_num > 1;

