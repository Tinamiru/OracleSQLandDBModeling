2022-04-13)예습
문자열 함수
1. CONCAT(c1,c2)

2. 대문자와 소문자 변환 함수
    1) LOWER(c1)
     - c1에 저장된 자료를 모두 소문자로 변환
     (사용예) EMPLOYEES에서 100부터 130까지의 사원들의 EMAIL을 모두 소문자로 변환하고
             사원번호를 역순으로 조회하시오.
             Alias는 사원번호,사원명,이메일,번호
      SELECT EMPLOYEE_ID AS 사원번호,
             EMP_NAME AS 사원명,
             LOWER(EMAIL) AS 이메일,
             PHONE_NUMBER AS 번호
        FROM HR.employees
       WHERE EMPLOYEE_ID BETWEEN '100' AND '130'
       ORDER BY 1 DESC;
     
    2) UPPER(c1)
     - c1에 저장된 자료를 모두 대문자로 변환
     (사용예) EMPLOYEES에서 100부터 180까지의 사원들의 이름을 모두 대문자로 변환하고
             사원번호를 역순으로 조회하시오.
             Alias는 사원번호,사원명,이메일,번호
      SELECT EMPLOYEE_ID AS 사원번호,
             UPPER(EMP_NAME) AS 사원명,
             EMAIL AS 이메일,
             PHONE_NUMBER AS 번호
        FROM HR.employees
       WHERE EMPLOYEE_ID BETWEEN '100' AND '180'
       ORDER BY 1 DESC;             

     
    3) INITCAP(c1)
     - C1에 저장된 자료중 단어의 첫 글자만 대문자로 변환
     (사용예) EMPLOYEES에서 100부터 130까지의 사원들의 EMAIL의 앞문자를 제외하고 소문자로 변환,
             사원번호를 역순으로 조회하시오.
             Alias는 사원번호,사원명,이메일,번호
      SELECT EMPLOYEE_ID AS 사원번호,
             EMP_NAME AS 사원명,
             INITCAP(EMAIL) AS 이메일,
             PHONE_NUMBER AS 번호
        FROM HR.employees
       WHERE EMPLOYEE_ID BETWEEN '100' AND '130'
       ORDER BY 1 DESC;
    
3. LPAD, RPAD
    1) 