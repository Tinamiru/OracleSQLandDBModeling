2022-0407-01)
1.DML 명령
 1) 테이블 생성명령(CREATE TABLE)
  - 오라클에서 사용될 테이블을 생성
  (사용형식)
  CREATE TABLE 테이블명(
    컬럼명 데이터 타입[(크기)] [NOT NULL] [DEFAULT 값] [,]
                    :
    컬럼명 데이터 타입[(크기)] [NOT NULL] [DEFAULT 값] [,]
    [CONSTRAINT 기본키인덱스명 PRIMARY KEY(컬럼명[,컬럼명,...])[,]]
    [CONSTRAINT 외래키인덱스명 FOREIGN KEY(컬럼명[,컬럼명,...])
     REFERENCES 테이블명(컬럼명[,컬럼명,...])[,]]
    [CONSTRAINT 외래키인덱스명 FOREIGN KEY(컬럼명[,컬럼명,...])
     REFERENCES 테이블명(컬럼명[,컬럼명,...])]
     );
    . '테이블명', 컬럼명, 인덱스명 : 사용자정의단어를 사용
    . 'NOT NULL'이 기술된 컬럼은 데이터 삽입시 생략 불가능
    . 'DEFAULT 값':사용자가 데이터를 입력하지 않은 경우 자동으로 삽입되는 값
    . '기본키인덱스명','외래키인덱스명','테이블명'은 중복되어서는 안됨
    . '테이블명(컬럼명[,컬럼명,...])])': 부모테이블명 및 부모테이블에서 사용된 컬럼명
        컬럼명
  사용예)테이블명세1의 테이블들을 생성하시오.

  CREATE TABLE GOODS(
    GOOD_ID CHAR(4) NOT NULL, --기본키
    GOOD_NAME VARCHAR2(50),
    PRICE NUMBER(8),
    CONSTRAINT pk_goods PRIMARY KEY(GOOD_ID)
  );

  CREATE TABLE CUSTS(
    CUST_ID CHAR(4), --기본키
    CUST_NAME VARCHAR2(50),
    ADDRESS VARCHAR2(100),
    CONSTRAINT pk_custs PRIMARY KEY(CUST_ID)
  );
    
  CREATE TABLE ORDERS(
    ORDER_ID CHAR(11),
    ORDER_DATE DATE DEFAULT SYSDATE,
    CUST_ID CHAR(4),
    ORDER_AMT NUMBER(10) DEFAULT 0, --10억까지.(10의자리)
    CONSTRAINT pk_orders PRIMARY KEY(ORDER_ID),
    CONSTRAINT fk_order_cust FOREIGN KEY(CUST_ID)
        REFERENCES CUSTS(CUST_ID)
  );
  
  CREATE TABLE GOOD_ORDERS(
    ORDER_ID CHAR(11),
    GOOD_ID CHAR(4),
    ORDER_QTY NUMBER(3),
    CONSTRAINT pk_gord PRIMARY KEY(GOOD_ID, ORDER_ID), --인덱스명 PK_GORD를 생성 후 GOOD_ID, ORDER_ID를 기본키로 설정
    CONSTRAINT fk_gord_orders FOREIGN KEY(ORDER_ID)
        REFERENCES ORDERS(ORDER_ID),
    CONSTRAINT fk_gord_custs FOREIGN KEY(GOOD_ID)
        REFERENCES GOODS(GOOD_ID)
  );
  
2. INSERT 명령
 - 생성된 테이블에 새로운 자료를 입력
 (사용형식)
  INSERT INTO 테이블명[(컬럼명[,컬럼명,...])]     -- INSERT INTO(인서트 인투) '컬럼명'의 순서와 갯수에 맞게 VALUES 즉,
                                                -- 값을 맞추어 입력해야 오류가 안남. 테이블명만 기입할경우, "나는 테이블 내에 모든 컬럼에 데이터를 넣겠다."
    VALUES(값1[,값2,...]);
  . '테이블명[(컬럼명[,컬럼명,...])]': '컬럼명'이 생략되고 테이블명만 기술되면
    테이블의 모든 컬럼에 입력될 데이터를 순서에 맞추어 기술해야함(갯수 및 순서 일치)
  . '(컬럼명[,컬럼명,...])': 입력할 데이터에 해당하는 컬럼만 기술, 단 NOT NULL
    컬럼은 생략 할 수 없음.

사용예)다음 자료를 GOODS 테이블에 저장하시오.
    상품코드     상품명     가격
-----------------------------------------------------
    P101        볼펜       500
    P102        마우스     15000
    P103        연필       300
    P104        지우개     1000
    P201        A4용지     7000
    
    INSERT INTO GOODS VALUES('P101','볼펜',500);
    INSERT INTO GOODS(good_id,GOOD_NAME) 
        VALUES('P102','마우스');       -- 마우스의 가격은 입력되지 않았다. (NULL). 이때 인서트 인투는 삽입. 수정의 경우에는 UPDATE를 사용해야한다.
    INSERT INTO GOODS(good_id,GOOD_NAME,PRICE)
        VALUES('P103','연필',300);
        
    SELECT * FROM GOODS;
    
사용예)고객테이블(CUSTS)에 다음 자료를 입력하시오
        고객번호    고객명     주소
    ---------------------------------------
        a001       홍길동      대전시 중구 계룡로 846
        a002       이인수      서울시 성북구 장위1동 66
    
    INSERT INTO CUSTS VALUES('a001','홍길동','대전시 중구 계룡로 846');
    -- INSERT INTO CUSTS(cust_id,ADDRESS) VALUES('a002','이인수','서울시 성북구 장위1동 66'); 는 too many values 컬럼값과 값의 수가 맞지않다. 너무많다.
    -- INSERT INTO CUSTS(cust_id,ADDRESS) VALUES('a001','서울시 성북구 장위1동 66'); 는 기본키의 중복, 즉 유일성의 중복(a001이 중복됨.)
    
    INSERT INTO CUSTS(cust_id,ADDRESS) VALUES('a002','서울시 성북구 장위1동 66');
     SELECT * FROM CUSTS;
     
사용예)오늘 홍길동 고객이 로그인 했을 경우 주문테이블에 해당 사항을 입력하시오.
    INSERT INTO ORDERS(ORDER_ID,CUST_ID)
        VALUES('20220407001','a001');
        


사용예)오늘 홍길동 고객이 다음과 같이 구매했을 때 구매상품테이블(GOOD_ORDERS)
      에 자료를 저장하시오.
        구매번호        상품번호    수량
      -------------------------------------------------------------
        20220407001     P101      5
        20220407001     P102      10
        20220407001     P103      2

    INSERT INTO GOOD_ORDERS
      VALUES('20220407001','P101',5);

    INSERT INTO GOOD_ORDERS
      VALUES('20220407001','P102',10);
    
    INSERT INTO GOOD_ORDERS
      VALUES('20220407001','P103',2);
      
    UPDATE GOODS
      SET PRICE=15000
    WHERE GOOD_ID='P102';
    
    
    UPDATE ORDERS
      SET ORDER_AMT=ORDER_AMT+(SELECT A.ORDER_QTY*B.PRICE
                              FROM GOOD_ORDERS A, GOODS B
                              WHERE A.GOOD_ID=B.GOOD_ID
                              AND ORDER_ID='20220407001')
                              AND A.GOOD_ID='P103')
    WHERE ORDER_ID='20220407001';
     -- 인서트 할 경우 자동으로 업데이트 할 수 있는 기능이 있다 이것을 트리거라고 한다.
    SELECT * FROM orders;
    SELECT * FROM GOOD_ORDERS;
    
3. UPDATE 명령
 - 이미 테이블에 존재하는 자료를 수정할 때 사용
 (사용형식)
   UPDATE 테이블명
      SET 컬럼명=값[,]
            :
          컬럼명=값
    [WHERE 조건]; -- WHERE를 사용하지않으면 모든 행을 수정한다. 즉, WHERE은 행을 지정하는것이라고 생각하면 될것같다.
    
    SELECT PROD_NAME AS 상품명,
           PROD_COST AS 매입단가
      FROM PROD;
      
    UPDATE PROD              -- WHERE를 기입하지 않은 사용 예(삼성모니터 19인치 가격변경)
       SET PROD_COST=500000;
    
    ROLLBACK; -- 되돌리는 기능.
    
       UPDATE PROD              -- +10%
       SET PROD_COST=PROD_COST+ROUND(PROD_COST*0.1);
       
    --존재하는 자료를 '업데이트'하는 기능.
    
사용예) 상품테이블에서 분류코드가 'P101'에 속한 상품의 매입가격을 10%
       인상하시오.
       
    UPDATE PROD              -- +10%
       SET PROD_COST=PROD_COST+ROUND(PROD_COST*0.1)
       WHERE PROD_LGU='P101';
    