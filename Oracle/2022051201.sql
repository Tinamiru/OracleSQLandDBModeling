/*
2022-0512-01) Ʈ����(Trigger)
  - Ư�� �̺�Ʈ�� �߻��Ǳ� �� Ȥ�� �߻��� �� �ڵ������� ȣ��Ǿ� ����Ǵ� ������ ���ν���
  - Procedure�� ���� ��ȯ���� ����.(Function�� ���� ����.)
*/

  CREATE OR REPLACE TRIGGER Ʈ���Ÿ�(EX. TG_...)
    BEFORE|AFTER [Event]INSERT|UPDATE|DELETE ON ���̺��
    [FOR EACH ROW]
    [WHEN ����]
  [DECLARE]
    ����,���,Ŀ�� ����
  BEGIN
    Ʈ���� ���� (Trigger Body)
  END;
    . 'BEFORE|AFTER' : Ʈ������ ������ ����Ǵ� ���� (�̺�Ʈ �߻��� ��������)
    . 'INSERT|UPDATE|DELETE' : Ʈ������ �߻� ����, ���� ����� �� ���� (EX. INSERT OR DELETE)
    . 'FOR EACH ROW' : ����� Ʈ������ ��� ���, �����Ǹ� ������� Ʈ����
    . 'WHEN ����' : Ʈ���Ű� ����Ǹ鼭 ���Ѿ��� ���� (���ǿ� �´� �����͸� Ʈ���� ����)

 ��뿹) ���� ���ǿ� �´� ������̺� (EMPT)�� HR������ ������̺�κ��� ������ �����͸� ������ �����Ͻÿ�
         �÷� : �����ȣ(EID), �����(ENAME), �޿�(SAL), �μ��ڵ�(DEPTION), ��������(COM_PCT)
        
    CREATE TABLE EMPT(EID,ENAME,SAL,DEPTID,COM_PCT) AS
        SELECT  EMPLOYEE_ID, EMP_NAME,SALARY,DEPARTMENT_ID,COMMISSION_PCT
        FROM    HR.EMPLOYEES   
        WHERE   SALARY<=6000;
    
    SELECT * FROM EMPT;
    
 Ʈ���� ��뿹) ���� �����͸� EMPT���̺� �����ϰ� ������ ���� ��
                '���ο� ��������� �߰��Ǿ����ϴ�'��� �޼����� ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�
     [�ڷ�]
    �����     �޿�  �μ��ڵ�    ���������ڵ�
  ---------------------------------------------------  
     ȫ�浿    5500    80             0.25
     
    CREATE OR REPLACE TRIGGER TG_EMP_INSERT
        AFTER INSERT ON EMPT
    BEGIN
        DBMS_OUTPUT.PUT_LINE('���ο� ��������� �߰��Ǿ����ϴ�');
    END;
/    
-- EMPT�� �ڷ����
    INSERT INTO EMPT
      SELECT MAX(EID)+1,'ȫ�浿',5500,80,0.25 FROM EMPT;
    COMMIT;
    
    INSERT INTO EMPT
      SELECT MAX(EID)+1,'������',5500,80,0.25 FROM EMPT;
      
      
      
��뿹) EMPT���̺��� ���������� �̿��Ͽ� ���ʽ��� �����ϰ� ����鿡��
   ������ ���޾��� ����Ͻÿ�
        Alias�� �����ȣ, �����, �޿�, ��������, ���ʽ�, ���޾�
        ���ʽ�=�޿�*��������
        ���޾�=�޿�+���ʽ��̸�
        ���ʽ��� ����ϱ����� NULL�� ���������� 0���� �����Ͻÿ�.
          
��뿹) ������̺��� 115,126,132�� ����� ���� ó���Ͻÿ�
        �����ϴ� ��������� ������̺�(EMPT)���� �����Ͻÿ�
        �������� �����ϴ� ��������� ������ ���̺� �����Ͻÿ�.
        
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
        
������ �ڷ� ����
    DELETE  
    FROM    EMPT
    WHERE   EID IN(115,126,132);
    
    
    
    
    