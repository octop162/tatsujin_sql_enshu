-- 4-1
CREATE TABLE Animals
(
	name varchar(10),
	size INTEGER
);

INSERT INTO Animals VALUES ('カバ', 300);
INSERT INTO Animals VALUES ('犬', 70);
INSERT INTO Animals VALUES ('猫', 50);
INSERT INTO Animals VALUES ('さる', 100);
INSERT INTO Animals VALUES ('ライオン', 250);
INSERT INTO Animals VALUES ('残像', null);
INSERT INTO Animals VALUES ('虚像', null);

select * from Animals order by size;
select * from Animals order by size desc;


-- 4-2
select null || 'hoge'; --null
select '' || 'hoge'; --hoge

-- 4-3
select 
	name,
	coalesce(size, 0), -- size is nullなら0
	nullif(size, 100) -- size=100ならnull
from 
	Animals
;
