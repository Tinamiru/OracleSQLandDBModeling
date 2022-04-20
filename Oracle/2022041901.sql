2022-0419-01) 집계함수
 - 자료를 그룹화하고 그룹내에서 합계, 자료수, 평균, 최대, 최소 값을 구하는 함수
 - SUM, AVG, COUNT, MAX, MIN 이 제공됨
 - SELECT 절에 그룹함수가 일반 컬럼과 같이 사용된 경우 반드시 GROUP BY 절이
   기술되어야 함.
 (사용형식)
    SELECT [컬럼명1,
           [컬럼명2,...]]
           집계함수         -- 일반컬럼이 없을경우 하나의 그룹으로 보기때문에 GROUP BY 미사용.
      FROM 테이블명
    [WHERE 조건]
    [GROUP BY 컬럼명1[,컬럼명2,...]] -- 셀렉트절에 사용된 일반 컬럼을 반드시 기술해야한다.
   [HAVING 조건]
    [ORDER BY 인덱스|컬럼명 [ASC|DESC][,...]]
      . GROUP BY절에 사용된 컬럼명은 왼쪽에 기술된 순서대로 대분류, 소분류의 기준 컬럼명
      . HAVING 조건: 집계함수에 조건이 부여된 경우
      
1. SUM(col)
  - 각 그룹 내의 'col' 컬럼에 저장된 값을 모두 합하여 반환

2. AVG(col)
  - 각 그룹 내의 'col' 컬럼에 저장된 값의 평균을 구하여 반환
  
3. COUNT(*|col)
  - 각 그룹 내의 행의 수를 반환
  - '*'를 사용하면 NULL값도 하나의 행으로 취급
  - 컬럼명을 기술하면 해당 컬럼의 값이 NULL이 아닌 갯수를 반환
  
4. MAX(col),MIN(col)
 -  각 그룹내의 'col'컬럼에 저장된 값 중 최대값과 최소값을 구하여 반환
*** 집계함수는 다른 집계함수를 포함할 수 없다. ***

사용예)사원테이블에서 전체사원의 급여합계를 구하시오
사용예)사원테이블에서 전체사원의 평균급여를 구하시오
   SELECT SUM(SALARY) AS 급여합계,
          ROUND(AVG(SALARY)) AS 평균급여, -- 일반 함수와 집계함수는 서로 사용할 수 있다.
          MAX(SALARY) AS 최대급여,
          MIN(SALARY) AS 최소급여,
          COUNT(*) AS 사원수
     FROM HR.employees;
    
  SELECT AVG(TO_NUMBER(SUBSTR(PROD_ID,2,3))) -- 일반 함수와 집계함수는 서로 사용할수있다.
    FROM PROD;

사용예)사원테이블에서 부서별 급여합계를 구하시오
사용예)사원테이블에서 부서별 평균급여를 구하시오

  SELECT DEPARTMENT_ID AS 부서코드,
         SUM(SALARY) AS 급여합계,
         COUNT(EMPLOYEE_ID) AS 사원수,
         ROUND(AVG(SALARY)) AS 평균급여,
         MAX(SALARY) AS 최대급여,
         MIN(SALARY) AS 최소급여
    FROM HR.employees
   GROUP BY DEPARTMENT_ID
   ORDER BY 1;
      
/* 대분류와 소분류의 이해.
  SELECT DEPARTMENT_ID AS 부서코드,
         EMP_NAME AS 사원명,
         SUM(SALARY) AS 급여합계,
         COUNT(EMPLOYEE_ID) AS 사원수,
         ROUND(AVG(SALARY)) AS 평균급여,
         MAX(SALARY) AS 최대급여
    FROM HR.employees
   GROUP BY DEPARTMENT_ID, EMP_NAME
   -- 분류되어야할 부분이 두개가 나오기때문에 대분류, 소분류로 구분되어지나
   -- 최대급여의 사원 이름을 출력할 경우 서브쿼리를 사용하여야한다.
   ORDER BY 1;
*/

사용예)사원테이블에서 부서별 평균급여가 6000 이상인 부서를 조회하시오.

  SELECT DEPARTMENT_ID AS 부서코드,
         ROUND(AVG(SALARY)) AS 평균급여,
         COUNT(SALARY) AS 사원수
    FROM HR.employees
   GROUP BY DEPARTMENT_ID
  HAVING AVG(SALARY)>=6000 -- 집계함수에 조건이 붙을경우, WHERE 사용불가 및 HAVING에 기술.
   ORDER BY 2 DESC;
   
사용예) 장바구니 테이블에서 2020년 5월 회원별 구매수량합계를 조회하시오

   SELECT CART_MEMBER AS 회원코드,
          SUM(CART_QTY) AS 구매수량합계
     FROM CART
    WHERE CART_NO LIKE '202005%'
    GROUP BY CART_MEMBER
    ORDER BY 1;

    
사용예) 매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 월별, 제품별 매입집계를 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월별,
           BUY_PROD AS 제품코드,
           SUM(BUY_QTY) AS 매입수량합계,
           SUM(BUY_QTY*BUY_COST) AS 매입금액합계
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE), BUY_PROD
     ORDER BY 1,2;
     
     
사용예) 매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 월별 매입집계를 조회하되
       매입금액이 1억원 이상인 월만 조회하시오.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS 월별,
           SUM(BUY_QTY) AS 매입수량합계,
           SUM(BUY_QTY*BUY_COST) AS 매입금액합계           
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    HAVING SUM(BUY_QTY*BUY_COST)>=100000000
     ORDER BY 1;

       
사용예) 회원테이블에서 성별 평균 마일리지를 조회하시오.

  SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                   SUBSTR(MEM_REGNO2,1,1)='3' THEN
                   '남성'
              ELSE 
                   '여성'
         END AS 성별,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM MEMBER
   GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                      SUBSTR(MEM_REGNO2,1,1)='3' THEN
                      '남성'
                 ELSE 
                      '여성'
             END;

사용예) 회원테이블에서 연령별 평균마일리지를 조회하시오
  SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)||'대'
            AS 연령대,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM MEMBER
   GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)||'대'
   ORDER BY 1;

사용예) 회원테이블에서 거주지별 평균마일리지를 조회하시오.
  SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM MEMBER
   GROUP BY SUBSTR(MEM_ADD1,1,2);

사용예) 매입테이블(BUYPROD)에서 2020년 상반기(1월~6월) 제품별 매입집계를 조회하되
       금액 기준 상위 5개 제품만 조회하시오.
   SELECT A.BID AS 제품코드,
          A.QSUM AS 수량합계,
          A.CSUM AS 금액합계
     FROM (SELECT BUY_PROD AS BID, -- 참조 할때 한글은 정확하게 참조되어진다는 보장이 안된다. 가급적 영문명으로.
                  SUM(BUY_QTY) AS QSUM,
                  SUM(BUY_QTY*BUY_COST) AS CSUM
             FROM BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
            GROUP BY BUY_PROD
            ORDER BY 3 DESC)A
    WHERE ROWNUM<=5;
 
 
 5. ROLLUP과 CUBE
   1) ROLLUP
     - GROUP BY 절 안에 사용하여 레벨별 집계의 결과를 반환
    (사용형식)
      GROUP BY ROLLUP[컬럼명1[,컬럼명2,...,컬럼명n])
        . 컬럼명1,컬럼명2,...,컬럼명n 을(가장 하위레벨) 기준으로 그룹구성하여 그룹함수 수행한 후 
          오른쪽에 기술된 컬럼명을 하나씩 제거한 기준으로 그룹 구성, 마지막으로 전체 합계 반환
        . n개의 컬럼이  사용된 경우 n+1종류의 집계반환ㄴ
        
사용예) 장바구니테이블에서 2020년 월별,회원별,제품별 판매수량 집계 조회.        
 -- GROUP BY 만 사용한 경우.
      SELECT SUBSTR(CART_NO,5,2) AS 월,
             CART_MEMBER AS 회원번호,
             CART_PROD AS 제품코드,
             SUM(CART_QTY) AS 판매수량집계
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD
       ORDER BY 1;
       
 -- ROLLUP의 예       
      SELECT SUBSTR(CART_NO,5,2) AS 월,
             CART_MEMBER AS 회원번호,
             CART_PROD AS 제품코드,
             SUM(CART_QTY) AS 판매수량집계
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD)
       ORDER BY 1;
       
  ** 부분 ROLLUP
    . 그룹을 분류 기준 컬럼이 ROLLUP절 밖(GROUP BY 절 안)에 기술된 경우를 부분 ROLLUP 이라고 함
    . ex) GROUP BY 컬럼명1, ROLLUP(컬럼명2,컬럼명3) 인 경우
      => 컬럼명1, 컬럼명2, 컬럼명3 모두가 적용된 직계
         컬럼명1, 컬럼명2가 반영된 집계
         컬럼명1만 반영된 집계
  -- ROLLUP의 예       
      SELECT SUBSTR(CART_NO,5,2) AS 월,
             CART_MEMBER AS 회원번호,
             CART_PROD AS 제품코드,
             SUM(CART_QTY) AS 판매수량집계
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY CART_PROD, ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER)
       ORDER BY 1;


   2) CUBE
     - GROUP BY 절 안에서 사용(ROLLUP과 동일)
     - 레벨개념이 없음
     - CUBE 내에 기술된 컬럼들의 조합 가능한 경우마다 집계반환(2의 n승수 만큼의 집계반환)
   (사용형식)
     GROUP BY CUBE(컬럼명1,...컬럼명n);
     
      SELECT SUBSTR(CART_NO,5,2) AS 월,
             CART_MEMBER AS 회원번호,
             CART_PROD AS 제품코드,
             SUM(CART_QTY) AS 판매수량집계
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY CUBE(SUBSTR(CART_NO,5,2),CART_MEMBER,CART_PROD)
       ORDER BY 1;
     
     