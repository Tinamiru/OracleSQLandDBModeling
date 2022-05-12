/*
2022-0512-01) 트리거(Trigger)
  - 특정 이벤트가 발생되기 전 혹은 발생된 후 자동적으로 호출되어 실행되는 일종의 프로시저
  - Procedure와 같이 반환값이 없음.(Function은 값이 있음.)
*/

  CREATE OR REPLACE TRIGGER 트리거명(EX. TG_...)
    BEFORE|AFTER [Event]INSERT|UPDATE|DELETE ON 테이블명
    [FOR EACH ROW]
    [WHEN 조건]
  [DECLARE]
    변수,상수,커서 선언
  BEGIN
    트리거 본문 (Trigger Body)
  END;
    . 'BEFORE|AFTER' : 트리거의 본문이 실행되는 시점 (이벤트 발생을 기준으로)
    . 'INSERT|UPDATE|DELETE' : 트리거의 발생 원인, 조합 사용할 수 있음 (EX. INSERT OR DELETE)
    . 'FOR EACH ROW' : 행단위 트리거인 경우 기술, 생략되면 문장단위 트리거
    . 'WHEN 조건' : 트리거가 실행되면서 지켜야할 조건 (조건에 맞는 데이터만 트리거 실행)

 사용예) 다음 조건에 맞는 사원테이블 (EMPT)을 HR계정의 사원테이블로부터 구조와 데이터를 가져와 생성하시오
         컬럼 : 사원번호(EID), 사원명(ENAME), 급여(SAL), 부서코드(DEPTION), 영업실적(COM_PCT)
        
    CREATE TABLE EMPT(EID,ENAME,SAL,DEPTID,COM_PCT) AS
        SELECT  EMPLOYEE_ID, EMP_NAME,SALARY,DEPARTMENT_ID,COMMISSION_PCT
        FROM    HR.EMPLOYEES   
        WHERE   SALARY<=6000;
    
    SELECT * FROM EMPT;
    
 트리거 사용예) 다음 데이터를 EMPT테이블에 저장하고 저장이 끝난 후
                '새로운 사원정보가 추가되었습니다'라는 메세지를 출력하는 트리거를 작성하시오
     [자료]
    사원명     급여  부서코드    영업실적코드
  ---------------------------------------------------  
     홍길동    5500    80             0.25
     
    CREATE OR REPLACE TRIGGER TG_EMP_INSERT
        AFTER INSERT ON EMPT
    BEGIN
        DBMS_OUTPUT.PUT_LINE('새로운 사원정보가 추가되었습니다');
    END;
/    
-- EMPT에 자료삽입
    INSERT INTO EMPT
      SELECT MAX(EID)+1,'홍길동',5500,80,0.25 FROM EMPT;
    COMMIT;
    
    INSERT INTO EMPT
      SELECT MAX(EID)+1,'강감찬',5500,80,0.25 FROM EMPT;
      
      
      
사용예) EMPT테이블의 영업실적을 이용하여 보너스를 개산하고 사원들에게
   지급할 지급액을 출력하시오
        Alias는 사원번호, 사원명, 급여, 영업실적, 보너스, 지급액
        보너스=급여*영업실적
        지급액=급여+보너스이며
        보너스를 계산하기전에 NULL인 영업실적을 0으로 변경하시오.
          
사용예) 사원테이블에서 115,126,132번 사원을 퇴직 처리하시오
        퇴직하는 사원정보는 사원테이블(EMPT)에서 삭제하시오
        삭제전에 퇴직하는 사원정보를 퇴직자 테이블에 저장하시오.
        
        CREATE OR REPLACE TRIGGER th_remove_empt
          BEFORE DELETE ON EMPT
          FOR EACH ROW
        DECLARE
            V_EID EMPT.EID%TYPE;
            V_DID EMPT.DEPTID%TYPE;
        BEGIN
            V_EID:=(:OLD.EID);
            V_DID:=(:OLD.DEPTID);
            
            INSERT INTO EM_RETIRE
            VALUES (V_EID,V_DID,SYSDATE);
        END;
        
퇴직자 자료 삭제
    DELETE  
    FROM    EMPT
    WHERE   EID IN(115,126,132);
    
    
    
    
    