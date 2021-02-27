-- 6-1

DROP TABLE SeqTbl;
CREATE TABLE SeqTbl
(seq  INTEGER PRIMARY KEY,
 name VARCHAR(16) NOT NULL);

-- あり
DELETE FROM SeqTbl;
INSERT INTO SeqTbl VALUES(1,	'ディック');
INSERT INTO SeqTbl VALUES(2,	'アン');
INSERT INTO SeqTbl VALUES(3,	'ライル');
INSERT INTO SeqTbl VALUES(5,	'カー');
INSERT INTO SeqTbl VALUES(6,	'マリー');
INSERT INTO SeqTbl VALUES(8,	'ベン');

-- なし
DELETE FROM SeqTbl;
INSERT INTO SeqTbl VALUES(1,	'ディック');
INSERT INTO SeqTbl VALUES(2,	'アン');
INSERT INTO SeqTbl VALUES(3,	'ライル');
INSERT INTO SeqTbl VALUES(4,	'カー');
INSERT INTO SeqTbl VALUES(5,	'マリー');
INSERT INTO SeqTbl VALUES(6,	'ベン');

-- select 
SELECT 
	CASE WHEN COUNT(*) <> MAX(SEQ) THEN '歯抜けあり'
	ELSE '歯抜けなし' END AS GAP
FROM SEQTBL

-- 6-2
CREATE TABLE Students
(student_id   INTEGER PRIMARY KEY,
 dpt          VARCHAR(16) NOT NULL,
 sbmt_date    DATE);

INSERT INTO Students VALUES(100,  '理学部',   '2018-10-10');
INSERT INTO Students VALUES(101,  '理学部',   '2018-09-22');
INSERT INTO Students VALUES(102,  '文学部',   NULL);
INSERT INTO Students VALUES(103,  '文学部',   '2018-09-10');
INSERT INTO Students VALUES(200,  '文学部',   '2018-09-22');
INSERT INTO Students VALUES(201,  '工学部',   NULL);
INSERT INTO Students VALUES(202,  '経済学部', '2018-09-25');

-- select 
SELECT DPT
FROM STUDENTS
GROUP BY DPT
HAVING 
	COUNT(*) = SUM(
		CASE 
			WHEN
				SBMT_DATE IS NOT NULL
		 		AND SBMT_DATE < TO_DATE('2018-10-01', 'YYYY-MM-DD')
			THEN 1
		ELSE 0 END
	);

-- 6-3

CREATE TABLE Items
(item VARCHAR(16) PRIMARY KEY);
 
CREATE TABLE ShopItems
(shop VARCHAR(16),
 item VARCHAR(16),
    PRIMARY KEY(shop, item));

INSERT INTO Items VALUES('ビール');
INSERT INTO Items VALUES('紙オムツ');
INSERT INTO Items VALUES('自転車');

INSERT INTO ShopItems VALUES('仙台',  'ビール');
INSERT INTO ShopItems VALUES('仙台',  '紙オムツ');
INSERT INTO ShopItems VALUES('仙台',  '自転車');
INSERT INTO ShopItems VALUES('仙台',  'カーテン');
INSERT INTO ShopItems VALUES('東京',  'ビール');
INSERT INTO ShopItems VALUES('東京',  '紙オムツ');
INSERT INTO ShopItems VALUES('東京',  '自転車');
INSERT INTO ShopItems VALUES('大阪',  'テレビ');
INSERT INTO ShopItems VALUES('大阪',  '紙オムツ');
INSERT INTO ShopItems VALUES('大阪',  '自転車');


-- select
SELECT SHOP
	,COUNT(SHOPITEMS.ITEM) AS MY_ITEM_CNT
	, (SELECT COUNT(*) FROM ITEMS) - COUNT(SHOPITEMS.ITEM) AS DIFF_CNT
FROM SHOPITEMS INNER JOIN ITEMS ON ITEMS.ITEM = SHOPITEMS.ITEM
GROUP BY SHOP