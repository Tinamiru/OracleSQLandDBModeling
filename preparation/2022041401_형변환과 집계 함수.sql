2022-0418-01) 날짜형 함수와 형변환 함수

3. 날짜형 함수.
 1) SYSDATE
 2) ADD_MONTHS(d,n)
 3) NEXT_DAY(d,c)
 4) LAST_DAY(d)
 5) EXTRACT(fmt FROM d) -- 가장 많이 사용될 함수라고 한다.
  - fmt의 종류: YEAR, MONTH, DAY, HOUR, MINUTE, SECOND.
  - EXTRACT 함수는 한번에 한 종류의 fmt를 사용하여 하나의 값만을 반환한다. -- 중복불가.
  - 결과는 숫자자료.
  
4. 형변환 함수.
   type명(expr AS type명)
   . 데이터 타입을 형변환(Casting)해주는 함수이다.
   . 타입의 종류로는 가장 많이 쓰이는 순서로
     TO_CHAR, TO_DATE, TO_NUMBER, CAST가 있다.

5. 집계함수.

  1)SUM(expr)
  2)AVG(expr)
  3)COUNT(*|colnum)
  4)MIN(c),MAX(c)
  5)ROLLUP()
  6)CUBE()
  