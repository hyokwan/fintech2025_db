-- show processlist
-- 
-- SELECT CONCAT('KILL ', id, ';') 
-- FROM information_schema.processlist 
-- WHERE user = 'hkcode';


-- DISTINCT
SELECT DISTINCT PRODUCTGROUP
FROM KOPO_PRODUCT_VOLUME

-- 산술연산자
SELECT A.REGIONID,
	A.PRODUCTGROUP,
	A.YEARWEEK,
	A.VOLUME,
	A.VOLUME * 1.5 AS VOLUME_OVER
FROM KOPO_PRODUCT_VOLUME2 A

-- 산술연산자 연습
SELECT ROUND(1.424329342,3) AS PROMOTION
FROM KOPO_PROMOTION
WHERE TARGETWEEK > PLANWEEK


SELECT MAP_PRICE / PMAP
FROM KOPO_PROMOTION

-- 빈값 테스트!

INSERT INTO KOPO_PROMOTION (REGIONID,ITEM,PLANWEEK) VALUES
('서울','ITEM001', '202501')

-- 빈값을 삽입
INSERT INTO KOPO_PROMOTION (REGIONID,ITEM,PLANWEEK,PMAP) VALUES
('','ITEM001', '202501',100)

-- 결측값 삽입
INSERT INTO KOPO_PROMOTION (ITEM,PLANWEEK,PMAP) VALUES
('ITEM001', '202501',100)


-- 결측값 삽입
INSERT INTO KOPO_PROMOTION (ITEM,PLANWEEK,PMAP) VALUES
('ITEM001', '202501',0)


-- 결측값 조회
SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE 1=1
AND NOT PRODUCTGROUP = 'ST0002'

-- 데이터 사이값 조회하기
-- 조회 202401 202412월까지 데이터 조회

SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE YEARWEEK BETWEEN '202405' AND '202411' 


SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP IN ('ST0002','ITEM04013')

CREATE TABLE KOPO_RECALL_ITEM AS
SELECT * 
FROM kopo_recall_item

SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP IN (SELECT DISTINCT ITEM
					   FROM KOPO_RECALL_ITEM)



SELECT *
FROM KOPO_RECALL_ITEM



insert into KOPO_PRODUCT_VOLUME 
values('A01','ITEM04013','202501',1000)








SELECT 50/PMAP, PMAP
FROM KOPO_PROMOTION
WHERE PMAP IS NULL
OR PMAP = 0

