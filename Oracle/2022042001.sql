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
    
  