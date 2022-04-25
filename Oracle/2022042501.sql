2022-0425-01)

사용예)2020년 상반기 거래처별 판매액집계를 구하시오
       Alias는 거래처코드,거래처명,판매액합계
    
  SELECT A.BUYER_ID AS 거래처코드,
         A.BUYER_NAME AS 거래처명,
         SUM(C.CART_QTY*B.PROD_PRICE)판매액합계
    FROM BUYER A, PROD B, CART C
   WHERE A.BUYER_ID=B.PROD_BUYER AND B.PROD_ID=C.CART_PROD
     AND SUBSTR(C.CART_NO,1,6) BETWEEN '202001' AND '202006'
   GROUP BY A.BUYER_ID, A.BUYER_NAME
   ORDER BY 1;
   
   
 -- INNER JOIN 사용예   
  SELECT A.BUYER_ID AS 거래처코드,
         A.BUYER_NAME AS 거래처명,
         SUM(C.CART_QTY*B.PROD_PRICE)판매액합계
    FROM BUYER A
   INNER JOIN PROD B ON (A.BUYER_ID=B.PROD_BUYER)
   INNER JOIN CART C ON (B.PROD_ID=C.CART_PROD)
   WHERE SUBSTR(C.CART_NO,1,8) BETWEEN TO_DATE('20200101') AND TO_DATE('20200601')
   GROUP BY A.BUYER_ID, A.BUYER_NAME
   ORDER BY 1;
   

사용예) HR계정에서 미국 이외의 국가에 위치한 부서에 근무하는 사원조회하시오
        Alias는 사원번호, 사원명,부서명,직무코드,근무지주소
        미국의 국가코드는 'US'이다

    SELECT A.EMPLOYEE_ID AS 사원번호,
           A.EMP_NAME AS 사원명,
           B.DEPARTMENT_NAME AS 부서명,
           A.JOB_ID AS 직무코드,
           C.STREET_ADDRESS||' '||C.CITY||', '||C.STATE_PROVINCE||', '||
           C.POSTAL_CODE||', '||C.COUNTRY_ID AS 근무지주소
      FROM HR.employees A, HR.departments B, HR.locations C
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND B.LOCATION_ID=C.LOCATION_ID
       AND C.COUNTRY_ID!='US'
     ORDER BY 1;
     
 -- INNER JOIN 사용예
    SELECT A.EMPLOYEE_ID AS 사원번호,
           A.EMP_NAME AS 사원명,
           B.DEPARTMENT_NAME AS 부서명,
           A.JOB_ID AS 직무코드,
           C.STREET_ADDRESS||' '||C.CITY||', '||C.STATE_PROVINCE||', '||
           C.POSTAL_CODE||', '||C.COUNTRY_ID AS 근무지주소
      FROM HR.employees A
     INNER JOIN HR.departments B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
     INNER JOIN HR.locations C ON(B.LOCATION_ID=C.LOCATION_ID)
     WHERE C.COUNTRY_ID!='US'
     ORDER BY 1;
         
사용예)2020년 4월 거래처별 매입금액을 조회하시오.
       Alias는 거래처코드,거래처명,매입금액합계
       
   SELECT A.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(C.BUY_COST*C.BUY_QTY) AS 매입금액합계
     FROM BUYER A, PROD B, BUYPROD C
    WHERE A.BUYER_ID=B.PROD_BUYER
      AND C.BUY_PROD=B.PROD_ID
      AND A.BUY_DATE BETWEEN '20200401' AND '20200430'
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
    
    --ANCI JOIN
    
   SELECT A.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(C.BUY_COST*C.BUY_QTY) AS 매입금액합계
     FROM BUYER A 
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN BUYPROD C ON(C.BUY_PROD=B.PROD_ID)
    WHERE C.BUY_DATE BETWEEN '20200401' AND '20200430'
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
       
사용예)2020년 4월 거래처별 매출금액을 조회하시오.
       Alias는 거래처코드,거래처명,매출금액합계
       
   SELECT A.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(B.PROD_PRICE*C.CART_QTY) AS 매출금액합계
     FROM BUYER A, PROD B, CART C
    WHERE A.BUYER_ID=B.PROD_BUYER
      AND C.CART_PROD=B.PROD_ID
      AND SUBSTR(CART_NO,1,6) LIKE '202004%'
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
    
-- ANCI JOIN

   SELECT A.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(B.PROD_PRICE*C.CART_QTY) AS 매출금액합계
     FROM BUYER A
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN CART C ON(C.CART_PROD=B.PROD_ID AND SUBSTR(CART_NO,1,6) LIKE '202004%')
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
       
       
사용예)2020년 4월 거래처별 매입/매출금액을 조회하시오.
       Alias는 거래처코드,거래처명,매입금액합계,매출금액합계
       
/*   SELECT A.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(B.PROD_COST*C.BUY_QTY) AS 매입금액합계,
          SUM(B.PROD_PRICE*D.CART_QTY) AS 매출금액합계
     FROM BUYER A, PROD B, BUYPROD C, CART D
    WHERE A.BUYER_ID=B.PROD_BUYER
      AND C.BUY_PROD=B.PROD_ID
      AND D.CART_PROD=B.PROD_ID
      
      AND C.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
      AND SUBSTR(D.CART_NO,1,6) LIKE '202004%'
      
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
    
    
   SELECT A.BUYER_ID AS 거래처코드,
          A.BUYER_NAME AS 거래처명,
          SUM(C.BUY_COST*C.BUY_QTY) AS 매입금액합계,
          SUM(B.PROD_PRICE*D.CART_QTY) AS 매출금액합계
     FROM BUYER A
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN BUYPROD C ON(C.BUY_PROD=B.PROD_ID
               AND C.BUY_DATE BETWEEN '20200401' AND '20200430')
    INNER JOIN CART D ON (D.CART_PROD=B.PROD_ID
               AND SUBSTR(D.CART_NO,1,8) BETWEEN '20200401' AND '20200430')
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
*/
   
    -- 서브쿼리와 외부조인을 같이 써야한다.
   
   SELECT TB.CID AS 거래처코드,  -- 공통컬럼을 참조한다면 많은쪽을 출력해야한다. 
          TB.CNAME AS 거래처명,
          NVL(TA.BSUM,0) AS 매입금액합계,
          NVL(TB.CSUM,0) AS 매출금액합계
     FROM (SELECT A.BUYER_ID AS BID, -- TA.BID를 기준을 넣으면 널값이 발생함.
                  SUM(C.BUY_COST*C.BUY_QTY) AS BSUM
             FROM BUYER A, PROD B, BUYPROD C
            WHERE A.BUYER_ID=B.PROD_BUYER
              AND C.BUY_PROD=B.PROD_ID
              AND C.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
            GROUP BY A.BUYER_ID) TA,
          (SELECT A.BUYER_ID AS CID,
                  A.BUYER_NAME AS CNAME,
                  SUM(B.PROD_PRICE*C.CART_QTY) AS CSUM
             FROM BUYER A, PROD B, CART C
            WHERE A.BUYER_ID=B.PROD_BUYER
              AND C.CART_PROD=B.PROD_ID
              AND SUBSTR(C.CART_NO,1,6) LIKE '202004%'
            GROUP BY A.BUYER_ID,A.BUYER_NAME) TB            
    WHERE TA.BID(+)=TB.CID -- 외부조인조건. TA자료를 TB에 맞게 확장.((+)) 
    ORDER BY 1;
    
    -- 조인과 서브쿼리는 같이 많이 쓴다.
 
 
    
 -- Non Equi-JOIN
   
사용예)사원테이블에서 전체사원의 평균급여보다 더 많은 급여를 받는 사원을
       조회하시오.
       Alias는 사원번호,사원명,부서코드,급여
       
   SELECT A.EMPLOYEE_ID AS 사원번호,
          A.EMP_NAME AS 사원명,
          A.DEPARTMENT_ID AS 부서코드,
          A.SALARY AS 급여
     FROM HR.employees A,
          (SELECT AVG(SALARY) AS BSAL
             FROM HR.EMPLOYEES) B
    WHERE A.SALARY>B.BSAL; -- Non Equi-JOIN의 특징(연산자)
    ORDER BY 3;
    
    
    -- 부서명까지 출력할 경우
    
   SELECT A.EMPLOYEE_ID AS 사원번호,
          A.EMP_NAME AS 사원명,
          A.DEPARTMENT_ID AS 부서코드,
          C.DEPARTMENT_NAME AS 부서명,
          A.SALARY AS 급여
     FROM HR.employees A,
          (SELECT AVG(SALARY) AS BSAL
             FROM HR.EMPLOYEES) B,
          HR.departments C
    WHERE A.SALARY>B.BSAL
      AND A.DEPARTMENT_ID=C.DEPARTMENT_ID
    ORDER BY 3;
            
   