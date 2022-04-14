2022-0411-02)
6. SELECT
 - SQL명령 중 가장 많이 사용되는 명령
 - 자료 검색을 위한 명령
 (사용형식)
  SELECT *|[DISTINCT]컬럼명 [AS 별칭][,] -- [DISTINCT = 중복배제] (복습필수)
         컬럼명 [AS 별칭][,] -- 별칭에 특수문자를 사용할경우 ""로 묶어주어야한다. 공백( ),_와 같은.
                :
         컬럼명 [AS 별칭]
    FROM 테이블명 -- 테이블명 혹은 뷰만 올수 있으며 서브쿼리가 사용될경우 서브 쿼리의 결과값이 무조건 테이블 혹은 뷰가 돼야 한다. 테이블명 뒤에 별칭을 줄 수 있다.
 [WHERE 조건] -- 여기까지 주로 사용
  [GROUP BY 컬럼명[,컬럼명,...]
 [HAVING 조건] -- 함수사용때에 WHERE 대신사용
  [ORDER BY 컬럼인덱스|컬럼명 [ASC|DESC][,컬럼인덱스|컬럼명 [ASC|DESC],...]]]; -- ASC 오름차순, DESC 내림차순 DEFULT는 오름차순(ASC)
  
 (사용예)회원테이블에서 회원번호,회원명,주소를 조회하시오.
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_ADD1||' '||MEM_ADD2 AS "주  소"
    FROM MEMBER;
    
 (사용예)회원테이블에서 '대전'에 거주하는 회원번호,회원명,주소를 조회하시오.
   SELECT MEM_ID AS 회원번호,
          MEM_NAME AS 회원명,
          MEM_ADD1||' '||MEM_ADD2 AS "주  소"
     FROM MEMBER
     WHERE MEM_ADD1 LIKE '대전%'; --시작글자가 대전으로 시작하면. 이라는 조건
    
 (사용예)회원테이블에서 '대전'에 거주하는 여성회원의
        회원번호,회원명,주소를 조회하시오.
        
   SELECT MEM_ID AS 회원번호,
          MEM_NAME AS 회원명,
          MEM_ADD1||' '||MEM_ADD2 AS "주  소"
     FROM MEMBER
     WHERE MEM_ADD1 LIKE '대전%'
       AND SUBSTR(MEM_REGNO2, 1, 1) IN('2','4'); --SUBSTR(대상,시작지점,갯수)
       
 (사용예)회원테이블에서 회원들의 거주지역(광역시도)을 조회하시오
        SELECT DISTINCT SUBSTR(MEM_ADD1,1,2) AS 거주지
          FROM MEMBER;
 
 
 
 
 
 
 
 
 