/*
2022-0513-01)생성된 테이블(tbl_good, customer)에 자료 삽입


상품정보
---------------------------------
상품번호    이름          가격
---------------------------------
p101        진라면        1200
p102        신라면        1500
p103        두부          2500
p104        김치(200g)    1750
---------------------------------
*/

INSERT INTO TBL_GOOD VALUES('p101','진라면',1200);
INSERT INTO TBL_GOOD VALUES('p102','신라면',1500);
INSERT INTO TBL_GOOD VALUES('p103','두부',2500);
INSERT INTO TBL_GOOD VALUES('p104','김치(200g)',1750);

/*
고객정보

---------------------------------
고객번호    이름          주소
---------------------------------
2201        이진우        서울시 성북구 장우위동 100
2210        장유진        대전시 대덕구 대덕대로 1555
2205        손두진        청주시 청원구 강내 102
---------------------------------
*/

INSERT INTO CUSTOMER VALUES('2201','이진우','서울시 성북구 장위동 100');
INSERT INTO CUSTOMER VALUES('2210','장유진','대전시 대덕구 대덕대로 1555');
INSERT INTO CUSTOMER VALUES('2205','손두진','청주시 청원구 강내 102');

SELECT *
FROM CUSTOMER;

-- 사용예)회원이 상품을 구매할 경우 구매상품(ORDER_GOOD)테이블에 구매정보가 기록되어야한다.
--        이때 구매테이블의 내용(AMOUNT)이 자동으로 갱신될 수 있는 트리거를 작성하시오.
/     
CREATE OR REPLACE FUNCTION FN_CREATE_ORDER_NUMBER -- 함수명 정의
    RETURN NUMBER -- 넘버타입 반환(주문번호의 타입)
IS -- 변수 선언
    V_ONUM tbl_ORDER.ORDERNUM%TYPE;
    V_FLAG NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO V_FLAG -- 로그인 한 회원의 수
    FROM TBL_ORDER -- 주문테이블의
    WHERE TRUNC(ODATE)=TRUNC(SYSDATE); -- 오늘날짜에 해당하는
    
        IF  V_FLAG=0 THEN -- 로그인한 회원의 수가 0일경우
            V_ONUM:=TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')||TRIM('001'));-- 현재 날짜의 첫번째 주문번호 생성.
        ELSE -- 그 외의 경우
            SELECT MAX(ORDERNUM)+1 INTO V_ONUM -- ORDERNUM 다음 행 생성 밑 삽입
            FROM TBL_ORDER -- 주문테이블의
            WHERE TRUNC(ODATE)=TRUNC(SYSDATE); -- 오늘날짜에 해당하는
        END IF;
    RETURN V_ONUM; -- 주문번호 삽입
END;
/
INSERT INTO TBL_ORDER VALUES(20220513004,SYSDATE,0,NULL);

SELECT FN_CREATE_ORDER_NUMBER FROM DUAL;

COMMIT;
       
-- 2) 트리거 생성.
/
   CREATE OR REPLACE TRIGGER TG_UPDATE_ORDER
     AFTER INSERT ON ORDER_GOOD
     FOR EACH ROW
   DECLARE
     V_GID tbl_good.good_id%TYPE;
     V_AMT NUMBER:=0;
     V_PRICE NUMBER:=0;
   BEGIN
     V_GID:=(:NEW.GOOD_ID);
     SELECT GOOD_PRICE INTO V_PRICE
       FROM TBL_GOOD
      WHERE GOOD_ID=V_GID; 
     V_AMT:=V_PRICE*(:NEW.ORDER_QTY);
     
     UPDATE TBL_ORDER
        SET AMOUNT=AMOUNT+V_AMT
      WHERE ORDERNUM=(:NEW.ORDERNUM);
   END;
/
SELECT ORDERNUM
FROM TBL_ORDER;
/
CREATE OR REPLACE PROCEDURE PROC_INSERT_ORDER_GOOD(
    P_CID IN CUSTOMER.CID%TYPE,
    P_GID IN TBL_GOOD.good_id%TYPE,
    P_SU IN NUMBER)
IS
    V_ORDER_NUM TBL_ORDER.ordernum%TYPE;
BEGIN
    SELECT  ORDERNUM INTO V_ORDER_NUM
    FROM    TBL_ORDER
    WHERE   TRUNC(ODATE)=TRUNC(SYSDATE)
    AND     CID=P_CID;
    
    INSERT INTO ORDER_GOOD
        VALUES(P_GID,V_ORDER_NUM,P_SU);
    COMMIT;
END;
/
   EXEC PROC_INSERT_ORDER_GOOD('2205','p102',5);
   EXEC PROC_INSERT_ORDER_GOOD('2205','p104',2);  
/