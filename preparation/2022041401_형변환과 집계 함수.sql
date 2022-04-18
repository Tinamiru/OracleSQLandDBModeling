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
    expr에 저장된 자료의 합계를 반환
  2)AVG(expr)
    주어진 데이터의 산술 평균값을 반환
  3)COUNT(*|colnum)
    그룹화된 자료의 행 수를 반환한다.(자료의수)
    colnum은 외부 조인 시 사용해야한다.
    일반적인 경우 *와 colnum은 어떤 것을 사용해도 같은 결과가 나온다.
  4)MIN(c),MAX(c)
    주어진 c(colnum)에서 가장 큰(MAX)값 또는 가장 작은(MIN)값을 반환한다.
  5)ROLLUP()
    GROUP BY 절에 사용하며 레벨별 집계를 구할때 사용된다.    
  6)CUBE()
    조합 가능한 모든 경우의 집계를 구할 때 사용된다.
  