/* 2022-0506-01)

<학습목표>
1. Cursor
2. Procedure
3. Function

프로세스란, 진행중인 과정.

<PL/SQL> - (절차적인 언어로써의 구조화된 질의 언어)
--서울, 분기, 걷기, 버스 - 버스타(뻐스타)

PL/SQL의 종류.

    Package(패키지)
    User(사용자 정의 함수)
    Stored Procedure(저장 프로시저)
    Trigger(트리거)
    Anonymous Block(익명의 블록)

1. Cursor
  행단위로,
  개발자가 PL/SQL에서 수동으로 제어가능.
*/ 
/
SET SERVEROUTPUT ON;
/
DECLARE
    -- SCALAR(일반) 변수
    V_BUY_PROD VARCHAR2(10);
    V_QTY NUMBER(10,0);
    -- 2020년도 상품별 매입수량의 합
    CURSOR CUR IS
    SELECT  BUY_PROD, SUM(BUY_QTY)
    FROM    BUYPROD
    WHERE   BUY_DATE LIKE '2020%'
    GROUP BY BUY_PROD
    ORDER BY 1 ASC;
BEGIN 
    -- 메모리를 할당(올라감) : 바인드
    OPEN CUR; -- OPEN = CUR라는 커서를 주 기억장치(메모리)에 올린다.
    --페따출(페치, 따지고, 출력)
    --다음 행으로 이동, 행이 존재하는지 체크해줌.
    --페
    FETCH CUR INTO V_BUY_PROD, V_QTY;
    --따(FOUND : 데이터존재? / NOTFOUND : 데이터가 없는가? / ROWCOUNT : 행의 수)
    WHILE(CUR%FOUND) LOOP
    DBMS_OUTPUT.PUT_LINE(V_BUY_PROD||', '||V_QTY); -- 출력.
    FETCH CUR INTO V_BUY_PROD, V_QTY;
    END LOOP;    
    -- 사용중인 메모리를 반환.(필수) (Garbige가 생김)
    CLOSE CUR;
END;
/

-- 회원테이블에서 회원명과 마일리지를 출력해보자 
-- 단, 직업이 '주부'인 회원만 출력하고 회원명으로 오름차순 정렬해보자.
-- ALIAS : MEM_NAME, MEM_MILEAGE
-- CUR 이름의 CURSOR를 정의하고 익명블록으로 표현
DECLARE
    -- REFERANCE 변수
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
CURSOR CUR(V_JOB VARCHAR2) IS
    SELECT  MEM_NAME, MEM_MILEAGE
    FROM    MEMBER
    WHERE   MEM_JOB = V_JOB -- 매개변수 기입.
    ORDER BY 1;
BEGIN
    OPEN CUR ('학생'); -- 인수값을 커서의 매개변수로.
    LOOP
        FETCH CUR INTO V_NAME, V_MILEAGE;
        EXIT WHEN CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||', '|| V_NAME||', '||V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
/

-- 직업을 입력받아 FOR LOOP를 이용하는 CURSOR
DECLARE
    CURSOR CUR(V_JOB VARCHAR2) IS
         SELECT  MEM_NAME, MEM_MILEAGE
         FROM    MEMBER
         WHERE   MEM_JOB = V_JOB -- 매개변수 기입.
         ORDER BY 1;
BEGIN
    -- FOR문으로 반복하는 동안 커서를 자동으로 OPEN하고
    -- 모든행이 처리되면 자동으로 커서를 CLOSE함
    -- REC : 자동 선언 묵시적 변수
    FOR REC IN CUR('학생') LOOP
        DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||
        ', '|| REC.MEM_NAME||', '||REC.MEM_MILEAGE);
    END LOOP;
END;
/

DECLARE

BEGIN
    -- FOR문으로 반복하는 동안 커서를 자동으로 OPEN하고
    -- 모든행이 처리되면 자동으로 커서를 CLOSE함
    -- REC : 자동 선언 묵시적 변수
    FOR REC IN (SELECT  MEM_NAME, MEM_MILEAGE -- 서브쿼리를 사용한,
                FROM    MEMBER
                WHERE   MEM_JOB = '학생'
                ORDER BY 1) LOOP
        DBMS_OUTPUT.PUT_LINE(REC.MEM_NAME||', '||REC.MEM_MILEAGE);
    END LOOP;
END;
/

-- CURSOR문제
-- 2020년도 회원별 판매금액(판매가(PROD_SALE) 
--                          * 구매수량(CART_QTY))의 합계를
-- CURSOR와 FOR문을 통해 출력해보자
-- ALIAS: MEM_ID,MEM_NAME,SUM_AMT
-- 출력예시 : a001, 김은대, 2000
--            b001, 이쁜이, 1750
--            ...
\
DECLARE
    CURSOR CUR IS
        SELECT  A.MEM_ID, A.MEM_NAME, SUM(C.PROD_SALE*B.CART_QTY) AS SUM_AMT
        FROM    MEMBER A
        INNER JOIN CART B ON(A.MEM_ID=B.CART_MEMBER)
        INNER JOIN PROD C ON(B.CART_PROD=C.PROD_ID)
        WHERE SUBSTR(B.CART_NO,1,4)='2020'
        GROUP BY A.MEM_ID, A.MEM_NAME
        ORDER BY 1;
BEGIN
   FOR REC IN CUR LOOP
       IF MOD(CUR%ROWCOUNT,2) = 1 THEN
           DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||', '||
                                REC.MEM_ID  ||', '||
                                REC.MEM_NAME||', '||
                                REC.SUM_AMT);
       END IF;
   END LOOP;
END;
/

