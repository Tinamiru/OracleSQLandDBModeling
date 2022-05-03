2022-0502-02)
2. SEQUENCE
  - 연속적으로 증가(또는 감소)되는 값을 반환하는 객체
  - 특정 테이블에 종속되지 않음
  - 기본키로 설정할 특정 항목이 없는 경우 주로 사용
 (사용형식)
  CREATE SEQUENCE 시퀸스명 -- 삭제시, DROP SEQUNCE 시퀀스명
    [START WITH n] -- n부터 생성
    [INCREMENT BY n] --증가 감소값(n)
    [MAXVALUE n|NOMAXVALUE} --최종값 설정, 기본은 NOMAXVALUE이며 10^27
    [MINVALUE n|NOMINVALUE} --최소값 설정, 기본은 NOMINVALUE이며 값은 1 임
    [CYCLE|NOCYCLE] : -- 최종/최소 값까지 도달한 후 다시 생성할지 여부. 기본은
                      -- NOMAXVALUE이며 1임
    [CACHE n|NOCACHE] : -- 생성된 순서값을 캐쉬 메모리에 저장할 것인지 여부.
                        -- 기본은 NOCACHE 20
    [ORDER | NOORDER] : --정의된대로 생성의 보장여부 기본은 NOORDER
    
** 시퀀스 사용이 제한되는 곳 -- INSERT문의 VALUES에 주로 사용함
  . SELECT, UPDATE, DELETE 문의 SUBQUERY
  . VIEW를 대상으로하는 QUERY
  . DISTINCT가 사용된 SELECT문
  . GROUP BY, ORDER BY 절이 사용된 SELECT문
  . 집합연산자가 사용된 SELECT문
  . SELECT문의 WHERE 절

** 시퀀스에 사용되는 의사컬럼
   시퀀스명.CURRVAL : 시퀀스객체의 현재값
   시퀀스명.NEXTVAL : 시퀀스객체의 다음값
 ** 시퀀스가 생성되고 첫 번쨰 수행해야할 명령은 반드시 NEXTVALUE 가 되어야 함
  

사용예)분류테이블에 사용할 시퀀스를 생성하시오.
       시작값은 10이고 1씩 증가해야함
       
    CREATE SEQUENCE SEQ_LPROD
      START WITH 10;
    
    SELECT SEQ_LPROD.NEXTVAL FROM DUAL;
    SELECT SEQ_LPROD.CURRVAL FROM DUAL;
    
    DROP SEQUENCE SEQ_LPROD;
    
사용예) 다음자료를 분류테이블에 저장하시오.
   [자료]
    LPROD_ID        LPROD_GU        LPROD_NM
-----------------------------------------------------
    시퀀스사용        P501           농산물
    시퀀스사용        P502           수산물
    시퀀스사용        P503           임산물
    
  INSERT INTO LPROD
    VALUES(SEQ_LPROD.NEXTVAL,'P501','농산물');
    
  INSERT INTO LPROD
    VALUES(SEQ_LPROD.NEXTVAL,'P502','수산물');
    
  INSERT INTO LPROD
    VALUES(SEQ_LPROD.NEXTVAL,'P503','임산물');    
    
    

3.SYNONYM(동의어)
  - 오라클에서 사용되는 객체에 부여한 또 다른 이름.
  - 긴 객체명이나 사용하기 어려운 객체명을 사용하기 쉽고 기억하기쉬운
    이름으로 사용 -- 별칭과 다르다.
    
 (사용형식)
 CREATE OR REPLACE SYNONYM 별칭 FOR 객체명;
   .'객체명'을 '별칭'으로 또 다른 이름 부여
   
사용예) HR계정의 사원테이블과 부서테이블을
        EMP, DEPT로 별칭(동의어)을 부여하시오
        
   CREATE OR REPLACE SYNONYM EMP FOR HR.employees; 
   CREATE OR REPLACE SYNONYM DEPT FOR HR.departments;
   
   SELECT * FROM EMP;
   SELECT * FROM DEPT;
   
4. INDEX
  - 테이블에 저장된 자료를 효율적(빨리)으로 검색하기위한 기술
  - 오라클서버는 사용자로부터 검색명령이 입력되면 전체를 대상으로
    검색(FULL SCAN)할지 또는 인덱스 스캔(INDEX SCAN)을 할지 결정함
  - 인덱스가 필요한 컬럼
    . 자주 검색하는 컬럼
    . WHERE 절에서 '='연산자로 특정 자료를 검색하는 경우
    . 기본키
    . SORT(ORDER BY)나 JOIN연산에 자주 사용되는 컬럼
    
    -- ? 현업, 인덱스처럼 시간,소요시간, 시간복잡도가 중요한지
  
  - 인덱스의 종류
    . Unique / Non-unique
         -- 유일. Null값 한번 허용(Null도 데이터로 취급하기때문에)
                -- Non. 중복가능.
    . Single / Composite 컬럼이 하나일경우 Single, 두개이상일경우 Composite
    . Normal(Default값) / Bitmap / Function-based(함수기반)
    
  (사용형식)
   CREATE [UNIQUE|BITMAP] INDEX 인텍스명
     ON 테이블(컬럼명[,컬럼명,...]) [ASC|DESC];
    . 'ASC|DESC' : 오름차순 또는 내림차순으로 인덱스 생성
                   기본은 ASC
    
    
사용예)
  CREATE INDEX IDX_MEM_NAME
    ON MEMBER(MEM_NAME);
    
    SELECT * FROM MEMBER
     WHERE MEM_NAME='육평회';
     
  DROP INDEX IDX_MEM_NAME;
    
    
사용예)
  CREATE INDEX IDX_PROD
    ON PROD(SUBSTR(PROD_ID,1,5)||SUBSTR(PROD_ID,9));
    
    SELECT * FROM PROD
     WHERE SUBSTR(PROD_ID,1,5)||SUBSTR(PROD_ID,9)='P202013';
 
** 인덱스의 재구성
  - 인덱스를 다른테이블스페이스로 이동시키는 경우
  - 데이터테이블이 이동된 경우
  - 삽입삭제가 다수 발생된 직후
  ALTER 인덱스명 REBUILD:
  
    
    
    
    
        