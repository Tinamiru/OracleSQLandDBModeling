2022-0503-02)�б⹮�� �ݺ���
1. �б⹮
 - ���߾���� �б⹮�� ���� ��� ����
 - IF��, CASE WHEN �� ���� ����
  1) IF��
    - ���Ǻб⹮
    (�������1)
    IF ���ǹ�1 THEN
       ��ɹ�1;
    [ELSE
       ��ɹ�2;]
    END IF;
    
    (�������2)
    IF ���ǹ�1 THEN
       ��ɹ�1;
    ELSIF ���ǹ�2 THEN
       ��ɹ�2;
            :
    ELSE
       ��ɹ�n;
    END IF;
    
    (�������3)
    IF ���ǹ�1 THEN
       IF ���ǹ�2
          ��ɹ�1;
             :
       END IF;
    ELSE
       ��ɹ�n;
    END IF;
    
��뿹) ���� ����� ������̺� �����ϴ� �͸����� �ۼ��Ͻÿ�
        �����ϱ����� �ش� ��� �̸����� ������ ���� ������ �Ǵ��Ͽ�
        ���� �̸��� ������ ������, ������ ������ �����Ͻÿ�.
        �����ȣ�� ���� ū �����ȣ ������ȣ�� �����Ѵ�.
        ����� : ȫ�浿, �Ի��� : ����, �����ڵ� : IT_PROG
        
  DECLARE
    V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_CNT NUMBER:=0; -- �ش� ��������� �������� �Ǵ�
    
  BEGIN
    SELECT COUNT(*) INTO V_CNT
      FROM HR.EMPLOYEES
     WHERE EMP_NAME='ȫ�浿';
    
    IF V_CNT = 0 THEN
       SELECT MAX(EMPLOYEE_ID)+1 INTO V_EID
         FROM HR.EMPLOYEES;
         
       INSERT INTO HR.EMPLOYEES(EMPLOYEE_ID,EMP_NAME,JOB_ID,HIRE_DATE)
         VALUES(V_EID,'ȫ�浿','IT_PROG',SYSDATE);
    ELSE
       UPDATE HR.EMPLOYEES
          SET HIRE_DATE=SYSDATE,
              JOB_ID='IT_PROG'
        WHERE EMP_NAME='ȫ�浿';
        
    END IF;
    
    COMMIT;            
    
  END;
      
  SELECT * FROM HR.employees;
    
2. CASE WHEN ��
  - ���� �б��� (�ڹ��� SWITCH CASE ���� ����)

 (�������1)
  CASE WHEN ����1 THEN
            ���1;
       WHEN ����2 THEN
            ���2; 
              :
      [ELSE
            ���n;]
  END CASE;  
  
(�������2)
  CASE ����1 WHEN ��1 THEN
                 ���1;
            WHEN ��2 THEN
                 ���2; 
              :
  [ELSE
                 ���n;]
  END CASE;

��뿹)ȸ�����̺��� ���ϸ����� ��ȸ�Ͽ�
       0 ~ 2000 : 'Biginner'
       2001 ~ 5000 : 'Nomal'
       5001 ~      : 'Excellent'�� ��� ����Ͻÿ�
       ����� ȸ����, ���ϸ���, ����̴�.
       
 DECLARE
   CURSOR CUR_MEM02  IS  -- �������. ��� ����
     SELECT MEM_NAME,MEM_MILEAGE FROM MEMBER; -- Ŀ���� ����Ͽ� �Ʒ��� ����Ʈ���� ������ ����.
   V_RES VARCHAR2(200);
 BEGIN
   FOR REC IN CUR_MEM02 LOOP
       CASE WHEN REC.MEM_MILEAGE < 2001 THEN
                 V_RES:=RPAD(REC.MEM_NAME,10)||
                        LPAD(REC.MEM_MILEAGE,7)||'  Beginner';
            WHEN REC.MEM_MILEAGE < 5001 THEN
                 V_RES:=RPAD(REC.MEM_NAME,10)||
                        LPAD(REC.MEM_MILEAGE,7)||'  Normal';   
            ELSE
                 V_RES:=RPAD(REC.MEM_NAME,10)||
                        LPAD(REC.MEM_MILEAGE,7)||'  Excellent';
       END CASE;
       DBMS_OUTPUT.PUT_LINE(V_RES);
       DBMS_OUTPUT.PUT_LINE('-------------------------------');
   END LOOP;         
 END;