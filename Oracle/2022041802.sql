2022-0418-02)형 변환 함수
 - 함수가 사용된 위치에서 "일시적으로 데이터타입"의 형을 변환시킴 -- "일시적"중요
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST이 제공 -- 제일 많이쓰는 순서
 1) CAST(expr AS type명)
   . 'expr'에 저장된 값의 데이터타입을 'type'으로 변환
   
사용예) SELECT '홍길동',
              CAST('홍길동' AS CHAR(20)), -- 문자열 디폴트는 VARCHAR2.
              CAST('20200418' AS DATE)
         FROM DUAL
 
 
 SELECT MAX(CAST(CART_NO AS NUMBER))+1
   FROM CART
  WHERE CART_NO LIKE '20200507%';
  
  2) TO_CHAR(c), TO_CHAR(d | n [,fmt]) -- 고정길이, 대용량의 경우에 변환하는 경우가 있다.
    - 주어진 문자열을 문자열로 변환(단, c의 타입이 CHAR or CLOB인 경우
      VARCHAR2로 변환하는 경우만 허용
    - 주어진 날짜(d) 또는 숫자(n)을 정의된 형식(fmt)으로 변환
    - 날짜관련 형식문자
------------------------------------------------------------------
 FORMAT문자          의미        사용예
------------------------------------------------------------------
    AD, BD           서기         SELECT TO_CHAR(SYSDATE, 'AD') FROM DUAL;
    CC, YEAR         세기, 년도    SELECT TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;
    YYYY,YYY,YY,Y    년도         SELECT TO_CHAR(SYSDATE, 'YYYY YYY YY Y') FROM DUAL;
    Q                분기         SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
    MM, RM           월           SELECT TO_CHAR(SYSDATE, 'YY:MM:RM') FROM DUAL;                                        
    MOUTH MON        월           SELECT TO_CHAR(SYSDATE, 'YY:MONTH MON') DUAL;                                        
    W, WW, IW        주차         SELECT TO_CHAR(SYSDATE, 'W WW IW') FROM DUAL;
    DD,DDD,J         일차         SELECT TO_CHAR(SYSDATE, 'DD DDD J') FROM DUAL; -- 천문학에서는 J(줄리어스력)을 아직 사용한다
    DAY, DY, D       요일         SELECT TO_CHAR(SYSDATE, 'DAY DY D') FROM DUAL;
    AM, PM           오전/오후     SELECT TO_CHAR(SYSDATE, 'AM A.M.') FROM DUAL;
    A.M.,P.M.                     
    HH,HH12,HH24     시간         SELECT TO_CHAR(SYSDATE, 'HH HH12 HH24') FROM DUAL;
    MI               분           SELECT TO_CHAR(SYSDATE, 'HH24:MI') FROM DUAL;  
    SS,SSSSS         초           SELECT TO_CHAR(SYSDATE, 'HH:MI:SS SSSSS') FROM DUAL;  
     "문자열"         사용자정의    SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') FROM DUAL;
                     
------------------------------------------------------------------
 FORMAT문자          의미        
------------------------------------------------------------------
    9               출력형식의 자리설정,유효숫자인 경우 숫자를 출력하고 무효의 0인 경우 공백처리 -- 9과0 둘다 소수점 이하는 0으로 출력된다.
    0               출력형식의 자리설정,유효숫자인 경우 숫자를 출력하고 무효의 0인 경우 0을 출력
    $, L            화폐기호 출력 -- 시스템 설정의 통화(화폐)기호로 표기된다.
    PR              원본자료가 음수인 경우"-" 부호 대신 "< >"안에 숫자가 출력
    ,(Comma)        3자리마다의 자리점 출력
    .(Dot)          소숫점 출력
-----------------------------------------------------------------------------------
사용예)
  SELECT TO_CHAR(12345,'999999'),
         TO_CHAR(12345,'999,999.99'),
         TO_CHAR(12345.786,'000,000.0'),
         TO_CHAR(12345,'0,000,000'),
         TO_CHAR(-12345,'999999PR'),
         TO_CHAR(12345,'L999999'),
         TO_CHAR(12345,'$999999')
    FROM DUAL;
    
  3) TO_NUMBER(c[,fmt])
   - 주어진 문자열 자료 c를 fmt 형식의 숫자로 변환
     
사용예) -- 가공되지 않은 원본을 출력하는 것이라 생각하면 된다.
  SELECT --TO_NUMBER('12,345'), -- ,(Comma)는 숫자가 아니다.
         TO_NUMBER('12345') AS "fmt 생략",
         TO_NUMBER('12,345','99,999') AS "콤마의 예",
         TO_NUMBER('<1234>','9999PR') AS 음수,
         TO_NUMBER('$12,234.00','$99,999.99')*1100 AS 달러사인
    FROM DUAL;
    
  3) TO_DATE(c[,fmt])
   - 주어진 문자열 자료 c를 fmt 형식의 날짜 자료로 변환
   
사용예)
  SELECT TO_DATE('20220405'),
         TO_DATE('220405','YYMMDD')
    FROM DUAL;