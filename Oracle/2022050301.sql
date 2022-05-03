2022-0503-01)PL/SQL(Procedual language SQL)
  - 표준 sql언어를 확장한
  - 절차적 언어의 특징을 포함(비교, 반복, 변수, 상수 등)
  - 미리 구성된 모듈을 컴파일하여 서버에 저장하고 필요시 호출실행
  - 모듈화/캡슐화
  - Anonymous Block, Stored Procedure, User Defined
             Function, Trigger, Package 등이 제공됨
             

1. Anonymous Blook
 - 가장기본적인 pl/sql 구조 제공
 - 선언ㅇ영역과 실행영역으로 구분
 - 저장되지 않음
 (사용형식)
    DECLARE
      선언부)(변수,상수,커서 선언)
    BEGIN
      실행부(비지니스로직 처리를 위한 SQL문
   [EXCEPTION
    예외처리부
   ]
   END;
   
사용예)충남에 거주하는 회원들이 2020년 5월 구매실적을 조회하시오.
  DECLARE
    V_MID MEMBER.MEM_ID%TYPE; --회원번호
    V_MNAME MEMBER.MEM_NAME%TYPE;  --회원이름
    V_AMT NUMBER:=0; --구매금액합계
    CURSOR CUR_MEM  IS
      SELECT MEM_ID,MEM_NAME
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '충남%'; 
  BEGIN
    OPEN CUR_MEM;
    LOOP
      FETCH CUR_MEM INTO V_MID, V_MNAME;
      EXIT WHEN CUR_MEM%NOTFOUND;
      SELECT SUM(B.PROD_PRICE*A.CART_QTY) INTO V_AMT
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '202005%'
         AND A.CART_MEMBER=V_MID;
      DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
      DBMS_OUTPUT.PUT_LINE('회원명 : '||V_MNAME);
      DBMS_OUTPUT.PUT_LINE('구매합계 : '||V_AMT);
      DBMS_OUTPUT.PUT_LINE('-------------------');
    END LOOP;  
    CLOSE CUR_MEM;      
  END;

    1)변수와 상수
       - BEGIN ~  END 블록에서 사용할 변수 및 상수 선언
      (선언방식)
      변수명 [CONSTANT] 데이터타입|참조타입[:=초기값];
      . 변수의 종류
        - SCLAR변수 : 하나의 값을 저장하는 일반적 변수
        - 참조형 변수 : 해당 테이블의 행(ROW)이나 컬럼(COLIMN)의 타입과 크기를 참조하는 변수
        - BIND변수 : 파라미터로 넘겨지는 값을 전달하기위한 변수
      . 상수선언은 CONSTANT 예약어를 사용하여 이대 반드시 초기값을 설정해야함
      . 데이터타입
        - SQL에서 사용하는 자료타입
        - PLS_INTEGER, BINARY_INTEGER -> 4 byte 정수
        - BOOLEAN 사용 가능
       . 숫자형 변수는 사용전 반드시 초기화 해야됨 
       . 참조형
        - 열참조 : 테이블명.컬럼명%TYPE
        - 행참조 : 테이블명%ROWTYPE      
      
사용예)키보드로 년도와 월을 입력 받아 해당 기간동안 가장 많은 매입 금액을 기록한 
      상품을 조회하시오
      
      
  ACCEPT P_PERIOD PROMPT '기간(년도/월) 입력 : '
  DECLARE
   S_DATE DATE := TO_DATE(&P_PERIOD||'01');
   E_DATE DATE := LAST_DAY(S_DATE);
   V_PID PROD.PROD_ID%TYPE;
   V_PNAMDE PROD.PROD_NAME%TYPE;
   V_AMT NUMBER:=0;
   BEGIN 
     SELECT TA.BID,TA.BNAME,TA.BSUM
       INTO V_PID,V_PNAME,V_AMT
       FROM (SELECT B.BUY_PROD AS BID,
                    A.PROD_NAME AS BNAME,
                    SUM(A.PROD_COST*B.BUY_QTY) AS BSUM
               FROM PROD A, BUYPROD B
              WHERE B.BUY_DATE BETWEEN S_DATE AND E_DATE
                AND A.PROD_ID=B.BUY_PROD
              GROUP BY B.BUY_PROD, A.PROD_NAME
              ORDER BY 3 DESC) TA
      WHERE ROWNUM=1;
    
      DBMS_OUTPUT.PUT_LINE('제품코드 : '||V_PID);
      DBMS_OUTPUT.PUT_LINE('제품명 : '||V_PNAME);
      DBMS_OUTPUT.PUT_LINE('매입금액합계 : '||V_AMT);
      
   END;   
      
사용예) 임의의 부서코드를 선택하여 해당부서에 가장 먼저입사한 사원정보를 조회하시오
        Alias는 사원번호,사원명,부서명,직무코드,입사일
        
    TRUNC (DBMS_RANDOM.VALUE(10,110),-1)        
        
    DECLARE
      V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
      V_ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
      V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME%TYPE;
      V_JOBID HR.EMPLOYEES.JOB_ID%TYPE;
      V_HDATE DATE;
      V_DID HR.EMPLOYEES.DEPARTMENT_ID%TYPE:=TRUNC (DBMS_RANDOM.VALUE(10,110),-1);
    BEGIN  
     SELECT TA.EID,TA.ENAME,TA.DNAME,TA.JID,TA.HDATE
       INTO V_EID,V_ENAME,V_DNAME,V_JOBID,V_HDATE
       FROM (SELECT A.EMPLOYEE_ID AS EID,
                    A.EMP_NAME AS ENAME,
                    B.DEPARTMENT_NAME AS DNAME,
                    A.JOB_ID AS JID,
                    a.hire_date AS HDATE
               FROM HR.employees A, HR.departments B
              WHERE a.department_id=b.department_id
                AND a.department_id=V_DID
              ORDER BY a.hire_date) TA
     WHERE ROWNUM=1;
     
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_EID);
        DBMS_OUTPUT.PUT_LINE('사원명 : '||V_ENAME);
        DBMS_OUTPUT.PUT_LINE('부서명 : '||V_DNAME);
        DBMS_OUTPUT.PUT_LINE('직무코드 : '||V_JOBID);
        DBMS_OUTPUT.PUT_LINE('입사일 : '||V_HDATE);
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||V_DID);
        
      END;
      
      
