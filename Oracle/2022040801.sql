2022-0408-01)
 사용예)사원테이블(HR계정 EMPLOYEES테이블)에서 모든 사원의 급여를
       15%인상하여 변경하시오.
       
COMMIT;
ROLLBACK;
    SELECT FIRST_NAME, SALARY
      FROM HR.EMPLOYEES
      
    UPDATE HR.EMPLOYEES
       SET SALARY=SALARY+ROUND(SALARY*0.15) -- 라운드 함수는 소수점 이하를 없애준다.
       ;
       
  4. DELETE 명령
    -불필요한 자료를 테이블에서 삭제.
    (사용형식)
    DELETE FROM 테이블명
    [WHERE 조건]
    
사용예)
    DELETE FROM CART;
    ROLLBACK;
   -- 딜리트 또한 WHERE를 사용하지 않을 경우 모든 테이블의 자료가 없어진다.


  DELETE와 DROP의 차이)
사용예)
    DELETE FROM 테이블명
    DROP TABLE 테이블명
    딜리트는 테이블 내의 데이터 삭제에 사용되는 명령어이며, 드롭은 테이블 삭제 명령어이다.
    
5. 오라클 데이터타입
  - 오라클에 문자 데이터 타입은 존재하지않음
  - 문자열, 숫자, 날짜, 2진 데이터타입 제공
  1) 문자열 자료형
  - 오라클의 문자열 자료는 ' '에 기술
  - 문자열 자료형은 CHAR, VARCHAR, VARCHAR2, NVARCHAR, NVARCHAR2, LONG, CLOB, NCLOB 등이 제공
  -- 여기서 n이 붙으면 국제화 코드가 붙는 것이라 생각하면 된다. VARCHAR는 오라클에서만 사용한다.
  -- LONG은 서비스종료, CLOB는 LONG이 기능 업그레이드된것. (Character Large OBjects)
  
  (1) CHAR
    . 고정길이 문자열 자료 저장 -- CHAR을 제외한 다른 문자열 자료형은 가변길이.
    . 최대 2000byte 까지 저장가능
    . 기억공간이 남으면 오른쪽 공간에 공백이 pedding, 기억공간이 작으면 
      error
    . 기본키나 고정된자료(주민번호 등) 저장에 주로 사용
    (사용예)
      컬럼명 CHAR(크기[byte|char]) -- 나타냄말
        . '크기[byte|char]' : '크기'로 지정된 값이 byte인지 char(글자수)인지를 결정.
          생략하면 byte로 간주. 즉, defalt는 byte이다.
        . 한글 한글자는 3byte에 저장되며 CHAR(2000CHAR)로 선언되었다 할지라도 
          전체 공간은 2000byte를 초과할 수 없음
          
  (사용예)
  
    CREATE TABLE TEMP01(
      COL1 CHAR(20), -- 수정하고싶을때는 UPDATE?    
      COL2 CHAR(20 BYTE),
      COL3 CHAR(20 CHAR));
      
    INSERT INTO TEMP01 VALUES('대전시 중구','대전시 중구','대전시 중구');
    INSERT INTO TEMP01 VALUES('대전시 중구 계룡로 846','대전시 중구','대전시 중구');
     --value too large for column이 뜬다.
    SELECT * FROM TEMP01;
    SELECT LENGTHB(COL1),
           LENGTHB(COL2),
           LENGTHB(COL3)
      FROM TEMP01;
      
      
  (2) VARCHAR2
    . 가변길이 문자열 자료를 저장
    . 최대 4000byte까지 저장 가능
    . VARCHAR와 동일 기능
    . NVARCHAR 및 NVARCHAR2는 국제 표준코드인 UTF-8, UTF-16방식으로
      데이터를 인코딩하여 저장
  (사용형식)
    컬럼명 VARCHAR2(크기[byte|char]) -- 거의 99% 생략하여 사용된다.
    
  (사용예)
    CREATE TABLE TEMP02(
      COL1 VARCHAR2(100),
      COL2 VARCHAR2(100 BYTE),
      COL3 VARCHAR2(100 CHAR),
      COL4 CHAR(100)
    );
    
    INSERT INTO TEMP02
      VALUES('IL POSTINO', 'IL POSTINO', 'IL POSTINO', 'IL POSTINO');
    
    SELECT * FROM TEMP02
    
  (3) LONG    
    . 가변길이 데이터 저장
    . 최대 2GB 까지 저장 가능
    . 한 테이블에 하나의 LONG타입 컬럼만 사용
    . CLOB(Character Large OBjects)로 기능 업그레이드 됨 -- BLOB(bin)도 존재함
    . select 문의 seclet절, update문의 set절, insert문의 values절에서 사용가능
    . 일부 함수에서는 사용될 수 없음
  (사용형식)
    컬럼명 long
    
  (사용예)
   CREATE TABLE TEMP03(
     COL1 LONG,
     COL2 VARCHAR2(4000));
     
   INSERT INTO TEMP03 VALUES('BANNA APPLE PERSIMMON', 'BANNA APPLE PERSIMMON');
   SELECT * FROM TEMP03
   
   --오라클은 자바와 다르게 0부터가 아닌 1부터 카운트된다.
   SELECT SUBSTR(COL2,7,5) -- COL1로 설정하여 LONG타입을 불러오면 오류가 생긴다.
     FROM TEMP03;
  (4) CLOB
    . 가변길이 데이터 저장
    . 최대 4GB 까지 처리 가능
    . 한 테이블에 여러개의 CLOB자료타입의 컬럼 사용 가능
    . 일부 기능은 DBMS_LOB API의 지원을 받아야사용 가능
  (사용형식)
   컬럼명 CLOB;
   
  (사용예)
   CREATE TABLE TEMP04(
    COL1 LONG,
    COL2 CLOB,
    COL3 CLOB,
    COL4 VARCHAR2(4000)
  );
  
  INSERT INTO TEMP04
   VALUES('', '대전시 중구 계룡로 846','대전시 중구 계룡로 846','대전시 중구 계룡로 846');
   SELECT * FROM TEMP04;
   
   SELECT SUBSTR(COL2, 5,2), -- 다섯번째에서 두글자까지 호출
          DBMS_LOB.SUBSTR(COL2,5,2), -- 2번째에서 다섯글자까지 호출
          -- DBMS_LOB API는 순서가 달라진다.
          
          DBMS_LOB.GETLENGTH(COL3), -- DBMS_LOB API 호출 바이트 길이수
          LENGTHB(COL4) -- 바이트라 기입 안함.
     FROM TEMP04;
  
    
    
    