/*
2022-0513-01)������ ���̺�(tbl_good, customer)�� �ڷ� ����


��ǰ����
---------------------------------
��ǰ��ȣ    �̸�          ����
---------------------------------
p101        �����        1200
p102        �Ŷ��        1500
p103        �κ�          2500
p104        ��ġ(200g)    1750
---------------------------------
*/

INSERT INTO TBL_GOOD VALUES('p101','�����',1200);
INSERT INTO TBL_GOOD VALUES('p102','�Ŷ��',1500);
INSERT INTO TBL_GOOD VALUES('p103','�κ�',2500);
INSERT INTO TBL_GOOD VALUES('p104','��ġ(200g)',1750);

/*
������

---------------------------------
����ȣ    �̸�          �ּ�
---------------------------------
2201        ������        ����� ���ϱ� ������� 100
2210        ������        ������ ����� ������ 1555
2205        �յ���        û�ֽ� û���� ���� 102
---------------------------------
*/

INSERT INTO CUSTOMER VALUES('2201','������','����� ���ϱ� ������ 100');
INSERT INTO CUSTOMER VALUES('2210','������','������ ����� ������ 1555');
INSERT INTO CUSTOMER VALUES('2205','�յ���','û�ֽ� û���� ���� 102');

SELECT *
FROM CUSTOMER;

-- ��뿹)ȸ���� ��ǰ�� ������ ��� ���Ż�ǰ(ORDER_GOOD)���̺� ���������� ��ϵǾ���Ѵ�.
--        �̶� �������̺��� ����(AMOUNT)�� �ڵ����� ���ŵ� �� �ִ� Ʈ���Ÿ� �ۼ��Ͻÿ�.
/     
CREATE OR REPLACE FUNCTION FN_CREATE_ORDER_NUMBER -- �Լ��� ����
    RETURN NUMBER -- �ѹ�Ÿ�� ��ȯ(�ֹ���ȣ�� Ÿ��)
IS -- ���� ����
    V_ONUM tbl_ORDER.ORDERNUM%TYPE;
    V_FLAG NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO V_FLAG -- �α��� �� ȸ���� ��
    FROM TBL_ORDER -- �ֹ����̺���
    WHERE TRUNC(ODATE)=TRUNC(SYSDATE); -- ���ó�¥�� �ش��ϴ�
    
        IF  V_FLAG=0 THEN -- �α����� ȸ���� ���� 0�ϰ��
            V_ONUM:=TO_NUMBER(TO_CHAR(SYSDATE,'YYYYMMDD')||TRIM('001'));-- ���� ��¥�� ù��° �ֹ���ȣ ����.
        ELSE -- �� ���� ���
            SELECT MAX(ORDERNUM)+1 INTO V_ONUM -- ORDERNUM ���� �� ���� �� ����
            FROM TBL_ORDER -- �ֹ����̺���
            WHERE TRUNC(ODATE)=TRUNC(SYSDATE); -- ���ó�¥�� �ش��ϴ�
        END IF;
    RETURN V_ONUM; -- �ֹ���ȣ ����
END;
/
INSERT INTO TBL_ORDER VALUES(20220513004,SYSDATE,0,NULL);

SELECT FN_CREATE_ORDER_NUMBER FROM DUAL;

COMMIT;
       
-- 2) Ʈ���� ����.
/
   CREATE OR REPLACE TRIGGER TG_UPDATE_ORDER
     AFTER INSERT ON ORDER_GOOD
     FOR EACH ROW
   DECLARE
     V_GID tbl_good.good_id%TYPE;
     V_AMT NUMBER:=0;
     V_PRICE NUMBER:=0;
   BEGIN
     V_GID:=(:NEW.GOOD_ID);
     SELECT GOOD_PRICE INTO V_PRICE
       FROM TBL_GOOD
      WHERE GOOD_ID=V_GID; 
     V_AMT:=V_PRICE*(:NEW.ORDER_QTY);
     
     UPDATE TBL_ORDER
        SET AMOUNT=AMOUNT+V_AMT
      WHERE ORDERNUM=(:NEW.ORDERNUM);
   END;
/
SELECT ORDERNUM
FROM TBL_ORDER;
/
CREATE OR REPLACE PROCEDURE PROC_INSERT_ORDER_GOOD(
    P_CID IN CUSTOMER.CID%TYPE,
    P_GID IN TBL_GOOD.good_id%TYPE,
    P_SU IN NUMBER)
IS
    V_ORDER_NUM TBL_ORDER.ordernum%TYPE;
BEGIN
    SELECT  ORDERNUM INTO V_ORDER_NUM
    FROM    TBL_ORDER
    WHERE   TRUNC(ODATE)=TRUNC(SYSDATE)
    AND     CID=P_CID;
    
    INSERT INTO ORDER_GOOD
        VALUES(P_GID,V_ORDER_NUM,P_SU);
    COMMIT;
END;
/
   EXEC PROC_INSERT_ORDER_GOOD('2205','p102',5);
   EXEC PROC_INSERT_ORDER_GOOD('2205','p104',2);  
/