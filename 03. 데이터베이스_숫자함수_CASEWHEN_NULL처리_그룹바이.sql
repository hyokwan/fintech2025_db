-- -------------------------------------
-- 숫자함수
-- -------------------------------------
SELECT  A.*,
		ROUND(15.232,1) AS ROUND_VALUE,
		CEIL(15.5232*100) / 100 AS CEIL_VALUE,
		FLOOR(15.5232*100) /100 AS FLOOR_VALUE,
FROM KOPO_PRODUCT_VOLUME A

-- MOD 연산
SELECT B.*,
	   MOD(B.WEEK, 3) AS MOD_WEEK_PATTERN,
	   POWER(B.WEEK,2) AS POWER_CALC
FROM (
	SELECT A.*,
		   SUBSTR(A.YEARWEEK, 1,4) AS YEAR,
		   SUBSTR(A.YEARWEEK, 5,2) AS WEEK
	FROM KOPO_CHANNEL_SEASONALITY_NEW A
)B
ORDER BY B.REGIONID, B.PRODUCT, B.YEARWEEK

-- -------------------------------------
-- CASE WHEN
-- -------------------------------------

-- 판매량 0보다 작은애들 = 0
-- 판매량 1000 보다 작은애들 = 1000
-- 판매량 100000  작은 애들은 100000
-- 이외에는 기존값 NEW_QTY

SELECT B.*
FROM(
	SELECT  A.*,
			CASE WHEN QTY < 0 THEN 0
				 WHEN QTY < 1000 THEN 1000
				 WHEN QTY < 100000 THEN 10000
				 ELSE QTY END AS NEW_QTY
	FROM KOPO_CHANNEL_SEASONALITY_NEW A
)B


-- A01 지역의 관심사가 201648주차 블랙프라이데이 시즌
-- PRODUCT = PRODUCT 1, PRODUCT2, PRODUCT20
SELECT  *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE REGIONID = 'A01'
AND YEARWEEK = '201648'
ORDER BY CASE WHEN PRODUCT = 'PRODUCT1' THEN 0
			  WHEN PRODUCT = 'PRODUCT2' THEN 1
			  WHEN PRODUCT = 'PRODUCT20' THEN 2
			  ELSE PRODUCT END 
			  
	
-- -------------------------------------
-- NULL 처리 
-- -------------------------------------			  
-- 중간에 NULL 데이터 삽입 후 실행
INSERT INTO KOPO_PROMOTION (ITEM, TARGETWEEK, PLANWEEK)
VALUES ('ITEM_HAITEAM','202503','202501')

INSERT INTO KOPO_PROMOTION (REGIONID, ITEM, TARGETWEEK, PLANWEEK)
VALUES ('', 'ITEM_HAITEAM','202503','202501')

SELECT REGIONID,
	   COALESCE( REGIONID, 'DEFAULT'),
	   CASE WHEN REGIONID IS NULL THEN 'DEFAULT'
	   	 	WHEN REGIONID = '' THEN 'DEFALUT'
   	   	 	ELSE REGIONID END AS REGIONID_NEW,
   	   -- IFNULL 이면 뒤에값을 반환
   	   IFNULL(REGIONID, 1),
   	   -- NULLIF  뒤에값과 같으면 NULL 반환 아니면 앞에값 반환
   	   NULLIF(REGIONID, '')
FROM KOPO_PROMOTION
WHERE 1=1
AND ( REGIONID IS NULL
OR REGIONID = '')

SELECT * 
FROM KOPO_PROMOTION
WHERE 1=1
AND REGIONID IS NULL
OR REGIONID IN('','NA','NONE','NULL')
	
SELECT  A.*,
		MAP_PRICE / IR AS MAP_IR_SUM
FROM KOPO_PROMOTION A
WHERE MAP_PRICE IS NULL


-- -------------------------------------
-- 날짜함수
-- -------------------------------------
SELECT  CURDATE(),
		CURTIME(),
		NOW(),
		A.*
FROM KOPO_PROMOTION A

SELECT DATE_ADD(CURDATE(), INTERVAL 1 DAY)
FROM DUAL

SELECT SYSDATE + 1/24/(60/30)
FROM DUAL

-- -------------------------------------
-- 집계 함수
-- -------------------------------------

SELECT  REGIONID,
	PRODUCT,
	COUNT(QTY) AS CNT_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND REGIONID IN ('A00','A01')
GROUP BY REGIONID, PRODUCT
HAVING SUM(QTY) > 100000
ORDER BY REGIONID, PRODUCT

SELECT  REGIONID,
	PRODUCT,
	COUNT(QTY) AS CNT_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND REGIONID IN ('A00','A01')
GROUP BY ROLLUP(REGIONID, PRODUCT)
HAVING SUM(QTY) > 100000
ORDER BY REGIONID, PRODUCT

















