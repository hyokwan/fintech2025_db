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

# IN 이해
SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP IN (SELECT DISTINCT ITEM
					   FROM KOPO_RECALL_ITEM)

SELECT *
FROM KOPO_RECALL_ITEM

# LIKE 이해
SELECT * 
FROM KOPO_PROMOTION
WHERE TARGETWEEK LIKE '%34%'

# 결측값 조회
select * 
from KOPO_PROMOTION
where REGIONID is null

# NULL 값 상황 입력
INSERT into KOPO_PROMOTION (REGIONID,ITEM,TARGETWEEK,PLANWEEK)
values ('서울','ITEM_HAITEAM','202503','202501')

INSERT into KOPO_PROMOTION (REGIONID,ITEM,TARGETWEEK,PLANWEEK)
values (NULL,'ITEM_HAITEAM','202503','202501')

INSERT into KOPO_PROMOTION (REGIONID,ITEM,TARGETWEEK,PLANWEEK)
values ('','ITEM_HAITEAM','202503','202501')

# 결측값 조회
select * 
from KOPO_PROMOTION
where REGIONID is null
or REGIONID = ''

CREATE TABLE gpt_customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO gpt_customers (name, city) VALUES
('Alice', 'Seoul'),
('Bob', 'Busan'),
('Charlie', 'Incheon'),
('David', 'Daegu'),
('Emma', 'Seoul'),
('Frank', 'Busan'),
('Grace', 'Incheon'),
('Henry', 'Daejeon'),
('Ivy', 'Seoul'),
('Jack', 'Gwangju');

CREATE TABLE gpt_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES gpt_customers(id)
);

INSERT INTO gpt_orders (customer_id, product, price) VALUES
(1, 'Laptop', 1200.00),
(2, 'Mouse', 25.00),
(3, 'Keyboard', 45.00),
(4, 'Monitor', 300.00),
(5, 'Desk Chair', 150.00),
(6, 'Table', 200.00),
(7, 'Pen', 2.00),
(8, 'Notebook', 5.00),
(9, 'Sofa', 500.00),
(10, 'Lamp', 80.00);


select *
from gpt_orders

select *
from gpt_customers

# 1번. 서울과 부산에 사는 고객 주문목록을 출력 하시오
