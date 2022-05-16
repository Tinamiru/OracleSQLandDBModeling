/* 2022-0516-01)

** Ʈ���� �ǻ� ���ڵ� - ����� Ʈ���ſ����� ��� ���� (=FOR EACH ROW�� �����)
 :NEW   INSERT�� UPDATE���� ���
        �����Ͱ� ����(����)�ɶ� '���� �ԷµǴ� ��'�� ��Ī
        DELETE �� ��� NULL.
 :OLD   DELETE�� UPDATE���� ���
        �����Ͱ� ����(����)�ɶ� '�̹� ����Ǿ� �ִ� ��'�� ��Ī
        INSERT �� ��� NULL.
        
** Ʈ���� �Լ�
    INSERTING �̺�Ʈ�� INSERT �̸� true
    UPDATING �̺�Ʈ�� UPDATE �̸� true
    DELETING �̺�Ʈ�� DELETE �̸� true
*/

-- ��뿹) ��ٱ������̺� ���ó�¥�� �ڷᰡ �Է�(����/����/����)�Ǿ��� ��
--         ���������̺��� ���, ����� ���� �÷��� �����Ͻÿ�.

    CREATE OR REPLACE TRIGGER TG_CART_CHANGE 
        AFTER INSERT OR DELETE OR UPDATE ON CART
        FOR EACH ROW
    DECLARE
        V_QTY NUMBER:=0;
        V_PID PROD.PROD_ID%TYPE;
        V_DATE DATE;
    BEGIN
        IF INSERTING THEN
            V_PID:=(:NEW.CART_PROD);
            V_QTY:=(:NEW.CART_QTY);
            V_DATE:=TO_DATE(SUBSTR((:NEW.CART_NO),1,8));
        ELSIF UPDATING THEN
            V_PID:=(:NEW.CART_PROD);
            V_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
            V_DATE:=TO_DATE(SUBSTR((:NEW.CART_NO),1,8));
        ELSIF DELETING THEN
            V_PID:=(:OLD.CART_PROD);
            V_QTY:=(:OLD.CART_QTY);
            V_DATE:=TO_DATE(SUBSTR((:OLD.CART_NO),1,8));
        END IF;
        
        UPDATE  REMAIN A
        SET     a.remain_o=a.remain_o+V_QTY,
                A.REMAIN_J_99=A.REMAIN_J_99-V_QTY,
                A.REMAIN_DATE=V_DATE
        WHERE   A.REMAIN_YEAR='2020'
        AND     A.PROD_ID=V_PID;
    END;
/

INSERT INTO CART
    VALUES('f001','2022051600001', 'P201000018', 10);
    
    
-- 'f001'ȸ���� 'P201000018'�� ��ǰ ���ż����� 3���� ����
UPDATE  CART
SET     CART_QTY=3
WHERE   CART_NO='2022051600001'
AND     CART_PROD='P201000018';





