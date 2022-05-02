2022-0502-01)
1.VIEW
 - 테이블과 유사한 객체
 - 기존의 테이블이나 뷰에 대한 SELECT문의 결과 집합에 이름을 부여한 객체
 - 필요한 정보가 여러 테이블에 분산되어 있는 경우 
 - 테이블의 모든 자료를 제공하지 않고 특정 결과만 제공하는 경우(보안)

 (사용형식)
  CREATE [OR REPLACE] VIEW 뷰이름[(컬럼list)] -- 컬럼리스트 미작성시 셀렉트문의 별칭이 뷰의 컬럼명이 됨.(별칭 미작성시 컬럼명이 삽입됨.)
  AS
    SELECT 문
    [WITH READ ONLY]
    [WITH CHECK OPTION]
    
    . 'REPLACE' : 이미 존재하는 뷰인 경우 대체 
    . 'WITH READ ONLY' : 읽기전용 뷰 생성 -- 읽기전용 미기입시 원본테이블이 변할 수 있음.
    . 'WITH CHECK OPTION' : 뷰를 생성하는 SELECT문의 조건을 위배하는 DML명령을  
      뷰에서 실행할때 오류 발생
                                               -- 읽기 전용과 CHECK OPTION은 동시사용 불가.
                                               -- 하나는 DML이 수행될때, 다른 하나는 DML을 수행 못하게 하는 기능이기 때문.
    
    -- ex. 조인을 사용하여 데이터 출력 후 저장하여 불러올수 있음(과부하 방지)
    
    
사용예) 회원테이블에서 마일리지가 3000이상인 회원의 회원번호,회원명,직업,마일리지
        로 구성된 뷰를 생성하시오.
        
        CREATE OR REPLACE VIEW V_MEM01(MID,MNAME,MJOB,MILE)
        AS
          SELECT MEM_ID,
                 MEM_NAME,
                 MEM_JOB,
                 MEM_MILEAGE
            FROM MEMBER
           WHERE MEM_MILEAGE>=3000;   
           
사용예)생성된 뷰(V_MEM01)에서 'c001'회원의 마일리지를 2500으로 변경
   UPDATE V_MEM01
      SET MILE=2500
    WHERE MID='c001';
    
   SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
     FROM MEMBER
    WHERE MEM_ID='g001';
    
   UPDATE MEMBER
      SET MEM_MILEAGE=3800
    WHERE MEM_ID='g001';
    
   
   
사용예) 회원테이블에서 마일리지가 3000이상인 회원의 회원번호,회원명,직업,마일리지
        로 구성된 뷰를 읽기전용으로 생성하시오.
        
        CREATE OR REPLACE VIEW V_MEM01
        AS
          SELECT MEM_ID,MEM_NAME,MEM_JOB,MEM_MILEAGE
            FROM MEMBER
           WHERE MEM_MILEAGE>=3000
            WITH READ ONLY;
           
SELECT * FROM V_MEM01; 

사용예) 생성된 뷰(V_MEM01)에서 'g001'회원(송경희)의 마일리지를 800으로 변경
   UPDATE V_MEM01  -- 읽기전용이기때문에 실행불가
      SET MEM_MILEAGE=800
    WHERE MEM_ID='g001';
    
(원본테이블에서 변경)
   UPDATE MEMBER
      SET MEM_MILEAGE=800
    WHERE MEM_ID='g001';
    
    
사용예) 회원테이블에서 마일리지가 3000이상인 회원의 회원번호,회원명,직업,마일리지
        로 구성된 뷰를 WITH CHECK OPTION으로 생성하시오.
        
        CREATE OR REPLACE VIEW V_MEM01
        AS
          SELECT MEM_ID,MEM_NAME,MEM_JOB,MEM_MILEAGE
            FROM MEMBER
           WHERE MEM_MILEAGE>=3000
            WITH CHECK OPTION;
            
            
SELECT * FROM V_MEM01;
     
사용예) 생성된 뷰에서 이혜나회원(e001)의 마일리지를 2500으로 변경
   UPDATE V_MEM01
      SET MEM_MILEAGE=6500
    WHERE MEM_ID='e001';
    
사용예) 신용환 회원('c001')마일리지를 MEMBER 테이블에서 3500으로 변경
   UPDATE MEMBER
      SET MEM_MILEAGE=3500
    WHERE MEM_ID='c001';
    
사용예) 오철희 회원('k001')마일리지를 뷰에서 4700으로 변경
   UPDATE V_MEM01
      SET MEM_MILEAGE=4700
    WHERE MEM_ID='k001';
    
   UPDATE MEMBER
      SET MEM_MILEAGE=2500
    WHERE MEM_ID='k001';
    
SELECT * FROM V_MEM01;