2022-0414-01) 문자열 함수 복습 및 예습
1. 문자열 함수
  1) COMCAT 함수(=||)

  2) LOWER,UPPER,INITCAP 함수(영어의 소문자와 대문자 치환 함수)

  3) LPAD,RPAD 함수 (주어진 공간(EX.데이터의 저장량만큼)을 값으로 채운 후 나머지 값을 왼쪽, 혹은 오른쪽에 지정한 문자를 채운다.

  4) LTRIM,RTRIM 함수 (왼쪽, 혹은 오른쪽의 '끝'에서 시작하며 지정한 값(공백 혹은 ANY)을 삭제한다.)

  5) TRIM 함수 (양쪽 끝의 공백을 삭제한다. 문자열 내부의 공백은 삭제할수 없으며 이 부분은 REPLACE 함수로 삭제 가능하다.)

  6) SUBSTR 함수 (지정한 컬럼 값의 문자열의 시작부분을 설정하고 출력할 양을 설정하면 지정한 값만 출력한다.) -- 가장 많이 쓰임

  7) REPLACE 함수 (문자열 치환 함수. 바꿀 단어를 지정 하고 바뀔 단어를 공백으로 둘 경우 모두 삭제.)

 .................2022-04-14 -ing..................

  8) INSTR(c1,c2[,m[,n]]) / 문자열의 색인. Index of String -- 위치 탐색 함수? 정수로 위치를 나타냄
    . 주어진 문자열 c1에서 문자열 c2가 처음 나타난 위치를 반환.
    . 검색 시작위치를 m에서 지정.
    . 문자열 c1에서 찾으려는 문자열 c2가 n번째로 나오는 위치를 반환.
    . 지정한 위치가 문자열의 범위를 넘어설 경우 Null값이 아닌 0으로 나타남.
  
    (사용예)
      SELECT INSTR('가바다 가가다바마바사','마') AS 마,
             INSTR('가바다 가가다바마바사','다',5) AS "5에서 시작, 다",
             INSTR('가바다 가가다바마바사','바',3,2) AS "3에서 시작,두번째 바"
        FROM DUAL;
----------------------------------------------------------------------------

2. 숫자함수
 2-1 수학적 함수.
  1) ABS(n)
    - 절댓값 반환 함수
  2) SIGN(n)
    - n의 부호에따라 양수일경우 1, 음수일경우 -1, 0일경우 0을 반환
  3) COS(n),SIN(n),TAN(n)
    - 삼각함수의 값 변환 함수. (코싸인, 싸인, 탄젠트) 
  4) SQRT(n)
    - n의 제곱근을 반환하는 함수.
  5) POWER(n,a)
    - 거듭제곱 계산 함수. n의 a승 값 반환(n-밑,a-지수)
  6) EXP(n)
    - 지수 함숫값 (지수함수: a가 양수이며 1이 아닐때 함수(y = a^x) a를 밑으로하는 x의 지수함수라고 한다.)
    - 지수함수의 역함수(대칭이동)는 로그함수이다.

 2-2 GREATEST(n1,n2[,n3,...]), LEAST(n1,n2[,n3,...])
    - 주어진 자료들에서 가장 큰값(GREATEST)과 작은값(LEAST)을 찾아 반환한다.
    
 2-3 반올림 함수
  1) ROUND(n[,m])
    - 실수 n의 소수점 이하 m번째 자리 미만의 값을 n2자리로 반올림
  2) TRUNC(n1[,n2])
    - 실수 n의 소수점 이하 m번째 자리 미만의 값을 n2자리로 반내림(절삭)
  . 반올림 함수들의 m번째 자리의 값이 음수일경우 정수부분의 자릿수에서 반올림 혹은 절삭한다.(자릿수가 거꾸로)
  
 2-4 나머지 함수
    - n을 m으로 나눈 나머지를 반환한다.(%계산의 기능)
  1) MOD(n,m)
    - 내부 동작방식: SIGN(n)*(ABS(n)-(ABS(m)*FLOOR(ABS(n)/ABD(m)))
  2) REMAINDER(n,m)
    - 내부 동작방식: n-m*ROUND(n,m)
  . MOD와 REMAINDER 모두 나머지를 반환하나 동작 방식이 다르다.
  . 일반적으로 MOD 함수를 많이 쓴다.
  
 2-5 WIDTH_BUCKET(n,min,max,block_cnt)
  . n에서 min과 max로 구간을 정하고 블록의 갯수(block_cnt로 지정)를 지정한다.
  . min최솟값
  
 (사용예) 급여가 2000이상, 20000이하의 사원을 조회하고 3구간으로 나누어
         급여가 적은순으로 1구간은 '저임금 사원', 2구간은 '평균임금 사원',
         3구간은 '고임금 사원'으로 분류하시오
         Alias는 사원명,부서명,직무명,급여,비고이며
         비고란에 급여별 분류를 입력하고 급여가 적은순으로 조회하시오
         
   SELECT A.EMP_NAME AS 사원명, -- 테이블 별칭을 사용하여 각 테이블별 컬럼들을 지정한다.
          C.DEPARTMENT_NAME AS 부서명,
          B.JOB_TITLE AS 직무명,
          A.SALARY AS 급여,
          CASE WHEN WIDTH_BUCKET(A.SALARY, 2000, 20000, 3)=1 THEN -- CASE를 사용하여 WIDTH_BUCKET 함수로 구간을 지정하여준다.
                    '저임금 사원'
               WHEN WIDTH_BUCKET(A.SALARY, 2000, 20000, 3)=2 THEN
                    '평균임금사원'
               ELSE
                    '고임금사원'
               END AS 비고
     FROM HR.EMPLOYEES A, HR.JOBS B, HR.DEPARTMENTS C -- 서로다른 테이블에서 가져오기 때문에 테이블 별칭을 지정하여준다.
    WHERE A.DEPARTMENT_ID=C.DEPARTMENT_ID -- 외래키 지정
          AND A.JOB_ID=B.JOB_ID -- 외래키 지정
    ORDER BY 4; 
 