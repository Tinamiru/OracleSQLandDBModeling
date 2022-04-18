2022-0418-02)형 변환 함수
 - 함수가 사용된 위치에서 "일시적으로 데이터타입"의 형을 변환시킴 -- "일시적"중요
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST이 제공 -- 제일 많이쓰는 순서
 1. CAST(expr AS type명)
   . 'expr'에 저장된 값의 데이터타입을 'type'으로 변환
   
사용예) SELECT '홍길동',
              CAST('홍길동' AS CHAR(20)), -- 문자열 디폴트는 VARCHAR2.
              CAST('20200418' AS DATE)
         FROM DUAL
 
 
 SELECT MAX(CAST(CART_NO AS NUMBER))+1
   FROM CART
  WHERE CART_NO LIKE '20200507%';