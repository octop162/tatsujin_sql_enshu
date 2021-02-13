-- create table

CREATE TABLE Greatests
  (
    key varchar(1) not null,
    x int,
    y int,
    z int,
    PRIMARY KEY (key)
  );

INSERT INTO Greatests VALUES ('A', 1, 2, 3);
INSERT INTO Greatests VALUES ('B', 5, 5, 2);
INSERT INTO Greatests VALUES ('C', 4, 7, 1);
INSERT INTO Greatests VALUES ('D', 3, 3, 8);

-- 1-1
SELECT 
	CASE 
		WHEN x < y THEN y
	ELSE x END
FROM Greatests;

SELECT 
	CASE 
		WHEN x <= z and y <= z THEN z
		WHEN x <= y and z <= y THEN y
	ELSE x END
FROM Greatests;


-- 1-2
CREATE TABLE PopTbl2
(pref_name VARCHAR(32),
 sex CHAR(1) NOT NULL,
 population INTEGER NOT NULL,
    PRIMARY KEY(pref_name, sex));

INSERT INTO PopTbl2 VALUES('徳島', '1',	60 );
INSERT INTO PopTbl2 VALUES('徳島', '2',	40 );
INSERT INTO PopTbl2 VALUES('香川', '1',	100);
INSERT INTO PopTbl2 VALUES('香川', '2',	100);
INSERT INTO PopTbl2 VALUES('愛媛', '1',	100);
INSERT INTO PopTbl2 VALUES('愛媛', '2',	50 );
INSERT INTO PopTbl2 VALUES('高知', '1',	100);
INSERT INTO PopTbl2 VALUES('高知', '2',	100);
INSERT INTO PopTbl2 VALUES('福岡', '1',	100);
INSERT INTO PopTbl2 VALUES('福岡', '2',	200);
INSERT INTO PopTbl2 VALUES('佐賀', '1',	20 );
INSERT INTO PopTbl2 VALUES('佐賀', '2',	80 );
INSERT INTO PopTbl2 VALUES('長崎', '1',	125);
INSERT INTO PopTbl2 VALUES('長崎', '2',	125);
INSERT INTO PopTbl2 VALUES('東京', '1',	250);
INSERT INTO PopTbl2 VALUES('東京', '2',	150);

SELECT 
	CASE
		WHEN SEX = '1' THEN '男'
	ELSE '女' END AS "性別"
	, SUM(POPULATION) AS "全国"
	, SUM(CASE
		WHEN PREF_NAME = '徳島' THEN POPULATION
	ELSE 0 END) AS "徳島"
	, SUM(CASE
		WHEN PREF_NAME = '香川' THEN POPULATION
	ELSE 0 END) AS "香川"
	, SUM(CASE
		WHEN PREF_NAME = '愛媛' THEN POPULATION
	ELSE 0 END) AS "愛媛"
	, SUM(CASE
		WHEN PREF_NAME = '高知' THEN POPULATION
	ELSE 0 END) AS "高知"
	, SUM(CASE
		WHEN PREF_NAME = '徳島' THEN POPULATION
		WHEN PREF_NAME = '香川' THEN POPULATION
		WHEN PREF_NAME = '愛媛' THEN POPULATION
		WHEN PREF_NAME = '高知' THEN POPULATION
	ELSE 0 END) AS "四国"
FROM
	POPTBL2
GROUP BY SEX
ORDER BY SEX
;

-- 1-3
SELECT 
	KEY
FROM GREATESTS
ORDER BY 
	CASE KEY 
		WHEN 'B' THEN 1
		WHEN 'A' THEN 2
		WHEN 'D' THEN 3
		WHEN 'C' THEN 4
	ELSE 0 END
;