2022-0420-01)

6. NULL 처리 함수
  - 오라클의 모든 컬럼은 값이 저장되지 않으면 기본적으로 NULL로 초기화됨
  - 연산에서 NULL 자료가 데이터로 사용되면 모든 결과는 NULL이 됨
  - 특정 컬럼이나 수식의 결과가 NULL인지 여부를 판단하기위한 연산자는
    IS [NOT] NULL
  - NVL, NVL2, NULLIF 등이 제공
  
 1) IS [NOT] NULL
    . 특정 컬럼이나 수식의 결과가 NULL인지 여부를 판단('='로는 NULL을 체크하지 못함)
사용예)사원테이블에서 영업실적이 NULL이 아니며 영업부(80번 부서)에 속하지 않는
      사원을 조회하시오.
      Alias는 사원번호,사원명,부서코드,영업실적(commission_pct
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서코드,
         COMMISSION_PCT AS 영업실적
    FROM HR.employees
   WHERE COMMISSION_PCT IS NOT NULL
      -- COMMISSION_PCT != NULL -- IS [NOT]를 사용하여야함
     AND DEPARTMENT_ID IS NULL;
    
  
  SELECT DEPARTMENT_ID AS 소속,
         ROUND(AVG(SALARY)) AS 급여평균
    FROM HR.employees
    WHERE SALARY > 1000
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(*)>=3
    
  2) NVL(expr,  val)
   . 'expr'의 값이 NULL이면 'val'값을 반환하고, NULL이 아니면 expr 자신의
     값을 반환한다.
   . 'expr'과 'val'은 같은 데이터 타입이어야 함

사용예) 상품테이블에서 상품의 크기(PROD_SIZE)가 NULL이면 '크기정보 없음'을,
       크기정보가 있으면 그 값을 출력하시오.
       Alias는 상품코드,상품명,매출가격,상품크기
       
  SELECT PROD_ID AS 상품코드,
         PROD_NAME AS 상품명,
         PROD_PRICE AS 매출가격,
         NVL(PROD_SIZE,'크기정보 없음') AS 상품크기
    FROM PROD;
    
사용예)사원테이블에서 영업실적(COMMISSION_PCT)이 없으면 '보너스 지급대상이 아님'을
      비고난에 출력하고, 영업실적(COMMISSION_PCT)이 있으면 보너스를 계산하여 출력하시오.
      Alias는 사원번호,사원명,영업실적,비고
      보너스는 영업실적*급여의 30%
      
      SELECT EMPLOYEE_ID AS 사원번호,
             EMP_NAME AS 사원명,
             NVL(TO_CHAR(COMMISSION_PCT,'0.99'), '보너스 지급대상이 아님') AS 영업실적,
             ROUND(NVL(COMMISSION_PCT*SALARY*0.3,0)) AS 보너스
        FROM HR.employees;
    
 
사용예) 2020년 6월 모든 상품별 판매집계를 조회하시오
       Alias는 상품코드,상품명,판매수량합계,판매금액합계
   SELECT B.PROD_ID AS 상품코드,
          B.PROD_NAME AS 상품명,
          NVL(SUM(A.CART_QTY),0) AS 판매수량합계,
          NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS 판매금액합계
     FROM CART A
    RIGHT OUTER JOIN PROD B ON (A.CART_PROD=B.PROD_ID AND -- 조인 조건.
          A.CART_NO LIKE ('202006%'))
    GROUP BY B.PROD_ID, B.PROD_NAME -- PROD_ID만 적어도 되나, 셀렉트절에 기술했기때문에 NAME까지 써주어야한다.
    ORDER BY 1;

  3) NVL2(expr, val1, val2)
   . 'expr'이 NULL이 아니면 'val1'을 반환하고, NULL이면 'val2'를 반환
   . 'val1'과 'val2'는 반드시 같은 타입이어야함.

사용예) 상품테이블에서 상품의 크기(PROD_SIZE)가 NULL이면 '크기정보 없음'을
       크기정보가 있으면 그 값을 출력하시오. NVL2를 사용
       Alias는 상품코드,상품명,매출가격,상품크기
       SELECT PROD_ID AS 상품코드,
              PROD_NAME AS 상품명,
              PROD_PRICE AS 매출가격,
              NVL2(PROD_SIZE, PROD_SIZE, '크기정보 없음') AS 상품크기
         FROM PROD;
  ** 사원테이블에서 사원번호 119,120,131번 사원 MANAGER_ID값을 NULL로 변경하시오.

    UPDATE HR.employees
       SET MANAGER_ID=NULL -- 여기서 SET절의 '='는 어사인먼트(우측값을 대입하는것) 즉 할당 연산자.
     WHERE EMPLOYEE_ID IN(119,120,131);

SELECT * FROM HR.employees ORDER BY MANAGER_ID;

사용예) 사원테이블과 각 사원들의 관리사원번호를 조회하시오
        관리사원이 없으면 '프리랜서 사원'을 관리사원번호 란에 출력하시오
        Alias는 사원번호,사원명,부서번호,관리사원
        
        SELECT EMPLOYEE_ID AS 사원번호, 
               EMP_NAME AS 사원명,
               DEPARTMENT_ID AS 부서번호,
               NVL2(MANAGER_ID,TO_CHAR(MANAGER_ID),'프리랜서 사원') AS 관리사원
          FROM HR.employees;


** 상품테이블에서 분류코드가 P301 상품의 매출가격을 상품의 매입가격으로 변경하시오.
  
  UPDATE PROD
     SET PROD_PRICE=PROD_COST
   WHERE PROD_LGU='P301';
   

  4) NULLIF(col1 , col2)
   . 'col1'과 'col2'가 동일한 값이면 NULL을 반환하고 같은값이 아니면 col1 값을 반환
   
   
사용예) 상품테이블에서 매입가와 매출가가 동일하면 비고난에 '단종 예정 상품'을
        서로 다른값이면 '정상 판매 상품'을 출력하시오.
        Alias는 상품코드,상품명,매입가,매출가,비고
        
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_COST AS 매입가,
           PROD_PRICE AS 매출가,
           NVL2(NULLIF(PROD_COST,PROD_PRICE),'정상 판매 상품','단종 예정 상품') AS 비고 -- 함수 내의 함수 즉, 중첩되는것을 NESTED라고한다.
      FROM PROD;

