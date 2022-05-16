/*
<학습목표>
. 프로시저 + 스케쥴러
. Exception
. Trigger

오라클 스케쥴러 사용하기!

1) 스케쥴러
  - 특정한 시간이 되면 자동적으로 질의(query)명령이 실행되도록 하는 방법ㄲ
  

*/

SELECT MEM_ID, MEM_MILEAGE
FROM MEMBER
WHERE   MEM_ID = 'a001';
/--PL/SQL은 /로 단락을 나누어 주는것이 좋다.
CREATE OR REPLACE PROCEDURE USP_UP_MEM_MIL
IS
BEGIN
    UPDATE  MEMBER
    SET     MEM_MILEAGE = mem_mileage + 10
    WHERE   MEM_ID = 'a001';
    COMMIT;
END;
/
EXEC usp_up_mem_mil;
/

--스케쥴 생성
DECLARE
    -- 스케쥴 JOB의 고유 아이디. 임의의 숫자
    V_JOB NUMBER(5);
BEGIN
    dbms_job.submit(
        V_JOB, -- JOB 아이디
        'USP_UP_MEM_MIL;', -- 실행할 프로시저 작업
        SYSDATE, -- 최초 작업을 실행할 시간
        'SYSDATE + (1/1440)', -- 1분 마다.
        FALSE -- 파싱(구문분석, 의미분석) 여부
    );
    DBMS_OUTPUT.PUT_LINE('JOB IS '|| TO_CHAR(V_JOB));
    COMMIT;
END;
/
--

--스케쥴러에 등록된 작업을 조회
SELECT * FROM USER_JOBS;
/
--스케쥴러에서 작업을 삭제하는 방법

BEGIN
    dbms_job.remove(1);
END;
/
SELECT  SYSDATE
      , TO_CHAR(SYSDATE + (1/1440),'YYYY-MM-DD HH24:MI:SS') 일분뒤
      , TO_CHAR(SYSDATE + (1/24),'YYYY-MM-DD HH24:MI:SS') 한시간뒤
      , TO_CHAR(SYSDATE + 1,'YYYY-MM-DD HH24:MI:SS') 하루뒤
FROM    DUAL;     
/
/*
2) Exception(예외)
  - PL/SQL에서 ERROR가 발생하면 EXCEPTION이 발생되고
    해당 블록을 중지하며 예외처리부분으로 이동함

예외 유형
  - 정의된 예외
    PL/SQL에서 자주 발생하는 ERROR를 미리 정의함
    선언할 필요가 없고 서버에서 암시적으로 발생함
    1) NO_DATA_FOUND : 결과없음
    2) TOO_MANY_DATA : 여러행 리턴
    3) DUP_VAL_ON_INDEX : 데이터 중복 오류(P.K / U.K)
    4) VALUE_ERROR : 값 할당 및 변환시 오류
    5) INVALID_NUMBER : 숫자로 변환이 안됨 EX) TO_NUMBER('개똥이')
    6) NOT_LOGGED_ON : DB에 접속이 안되었는데 실행
    7) LOGIN_DENIED : 잘못된 사용자 / 잘못된 비밀번호
    8) ZERO_DIVIDE : 0으로 나눔
    9) INVALID_CURSOR : 열리지 않은 커서에 접근

  - 정의되지 않은 예외
    기타표준 ERROR
    선언을 해야 하며 서버에서 임시적으로 발생

  - 사용자 정의 예외
    프로그래머가 정한 조건에 만족하지 않을경우 발생
    선언을 해야하고, 명시적으로 RAISE문을 사용하여 발생
*/

DECLARE
    V_NAME VARCHAR2(20);
BEGIN
    -- V_NAME에 '여성캐주얼'이 할당됨
    SELECT  LPROD_NM+10 INTO V_NAME
    FROM    LPROD
    WHERE   LPROD_GU LIKE 'P20%';
    DBMS_OUTPUT.PUT_LINE('분류명 : '||V_NAME);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN -- ORA-01403 오류
            DBMS_OUTPUT.PUT_LINE('해당정보가 없습니다.');
        WHEN TOO_MANY_ROWS THEN -- ORA-01422
            DBMS_OUTPUT.PUT_LINE('한개 이상의 값이 나왔습니다.');
        WHEN OTHERS THEN -- 아몰랑에러
            DBMS_OUTPUT.PUT_LINE('기타 에러 : '||SQLERRM);
END;
/
-- 정의되지 않은 예외
DECLARE
    -- EXCEPTION 타입의 exp_reference 변수
    exp_reference EXCEPTION;
    -- EXCEPTION_INIT을 통해 예외 이름과 오류번호를 컴파일러에게 등록함
    PRAGMA EXCEPTION_INIT (exp_reference, -2292);
BEGIN
    -- ORA-02292 오류 발생
    DELETE FROM LPROD WHERE LPROD_GU = 'P101';
    DBMS_OUTPUT.PUT_LINE('분류 삭제');
    EXCEPTION
        WHEN exp_reference THEN
            DBMS_OUTPUT.PUT_LINE('삭제 불가');
END;
/
SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'FR_BUYER_LGU';
/

-- 사용자 정의 예외
ACCEPT p_lgu PROMPT '등록하려는 분류코드 입력: '
DECLARE
    -- exception 타입의 변수 선언
    exp_lprod_gu EXCEPTION;
    v_lgu VARCHAR2(10) := UPPER('&p_lgu');
    -- DECLARE에서 변수를 선언하지 않고 직접 ACCEPT 변수를 사용(&로)할 수 있다.
BEGIN
    if v_lgu IN('P101','P102','P201','P202') THEN
        --실행부에서 RAISE문장으로 명시적으로 EXCEPTION을 발생함
        RAISE exp_lprod_gu;
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_lgu || '는 등록가능');
    
    EXCEPTION
        WHEN exp_lprod_gu THEN
             DBMS_OUTPUT.PUT_LINE(v_lgu||'는 이미 등록된 코드입니다.');
END;
/
select lprod_gu from lprod;
/

--DEPARTMENT 테이블에 학과코드를 '컴공',
--학과명을 '컴퓨터공학과', 전화번호를 '765-4100'
--으로 INSERT 해보자
--예외메시지 : <중복된 인덱스 예외 발생!>

DECLARE
    exp_reference EXCEPTION;
    PRAGMA EXCEPTION_INIT (exp_reference, -00001);
BEGIN
    INSERT INTO DEPARTMENT (DEPT_ID, DEPT_NAME, DEPT_TEL)
    VALUES ('컴공', '컴퓨터공학과', '765-4100');
    DBMS_OUTPUT.PUT_LINE('생성 성공');
    EXCEPTION
        WHEN exp_reference THEN
        DBMS_OUTPUT.PUT_LINE('<중복된 인덱스 예외 발생!>');
    
END;
/

SELECT * FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'DEPARTMENT_PK';
/

/*
COURSE 테이블의 과목코드가 'L1031'에 대하여
추가 수강료(COURSE_FEES)를 '삼만원'으로 수정해보자
[숫자형 데이터타입의 데이터 오류 발생]
*/

DECLARE
BEGIN
    UPDATE  COURSE
    SET     COURSE_FEES = '삼만원'
    WHERE   COURSE_ID = 'L1031';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('수정 성공');
    EXCEPTION
        WHEN invalid_number THEN
            DBMS_OUTPUT.PUT_LINE('[숫자형 데이터타입의 데이터 오류 발생]');
        WHEN OTHERS THEN
            NULL;
END;
/

/*
SG_SCORES 테이블에 저장된 SCORE 컬럼의 점수가
100점이 초과되는 값이 있는지 조사하는 블록을 작성해보자
단, 100점 초과 시 OVER_SCORE 예외를 선언해보자
[사용자정의 예외로 처리해보자]
*/

INSERT INTO SG_SCORES(STUDENT_ID, COURSE_ID, SCORE, SCORE_ASSIGNED)
VALUES ('A1701','L0013',107,'2010/12/29');
/
DECLARE -- 선언.
    OVER_SCORE EXCEPTION; -- 사용자 정의 예외 정의
    V_SCORE SG_SCORES.SCORE%TYPE; -- 스코어 변수 선언
    V_STUDENT sg_scores.student_id%TYPE; -- 학생id 선언
    
    CURSOR  CUR IS -- 커서 생성(DECLARE에서 정의)
            SELECT  STUDENT_ID,
                    SCORE
            FROM    SG_SCORES;
BEGIN 
    OPEN CUR;-- 커서 오픈
        FETCH CUR INTO V_STUDENT, V_SCORE; -- 휏치를 사용해 커서지정
            WHILE(CUR%FOUND) LOOP -- 반복문 시작
                IF V_SCORE>100 THEN -- 조건문 (점수가 100 이상일 경우)
                    DBMS_OUTPUT.PUT_LINE(V_STUDENT||'의 점수'||V_SCORE); -- 학생id와 점수 출력
                    RAISE OVER_SCORE; -- 예외 발생
                ELSE -- 점수가 100이상이 아닐경우
                    DBMS_OUTPUT.PUT_LINE(V_STUDENT||'의 점수'||V_SCORE); -- 학생id와 점수 출력
                    FETCH CUR INTO V_STUDENT, V_SCORE; -- 다음 행으로
                  END IF; -- 조건문 종료
             END LOOP; -- 반복문 종료
    CLOSE CUR; -- 커서 종료
   EXCEPTION -- 예외
        WHEN OVER_SCORE THEN -- 예외처리
            DBMS_OUTPUT.PUT_LINE('점수가 100점을 초과합니다.'); -- 예외 출력
END; -- 종료
/


SELECT *
FROM SJR.sg_scores;


commit;
--메모리 사용량 조회 쿼리문
SELECT 

to_char(( sum( se1.value)/1024)/1024, '999G999G990D00') || ' MB' "CURRENT_SIZE",

to_char(( sum(se2.value)/1024)/1024, '999G999G990D00') || ' MB' "MAXIMUM_SIZE"

FROM v$sesstat se1, v$sesstat se2, v$session ssn, v$bgprocess bgp, v$process prc,

v$instance ins, v$statname stat1, v$statname stat2

WHERE se1.statistic# = stat1.statistic# and stat1.name = 'session pga memory'

AND se2.statistic# = stat2.statistic# and stat2.name = 'session pga memory max'

AND se1.sid = ssn.sid

AND se2.sid = ssn.sid

AND ssn.paddr = bgp.paddr (+)

AND ssn.paddr = prc.addr (+)

order by CURRENT_SIZE desc 
/
