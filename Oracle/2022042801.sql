2022-0428-01)SUBQUERY�� DML���
1. INSERT ������ �������� ���
 - INSERT INTO ���� ���������� ����ϸ� VALUES���� ������
 - ���Ǵ� ���������� '( )'�� �����ϰ� �����

(�������)
   INSERT INTO ���̺��[(�÷���[,�÷���,...])]
     ��������;
   . '���̺��'�� ����� �÷��� ����, ����, Ÿ�԰� �������� SELECT����
     SELECT���� �÷��� ����, ����, Ÿ���� �ݵ�� ��ġ�ؾ��Ѵ�.

��뿹)��� ���� ���̺��� �⵵���� '2020'��, ��ǰ�ڵ忡��
       ��ǰ���̺��� ��� ��ǰ�ڵ带 �Է��Ͻÿ�



    INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID)
      SELECT '2020', PROD_ID
        FROM PROD;
        
        
    SELECT * FROM REMAIN;
    
2. UPDATE ������ �������� ���
  (�������)
  UPDATE ���̺� [��Ī]
     SET (�÷���[,�÷���,...])=(��������)
   [WHERE ����];
   
   ��뿹)���������̺�(REMAIN)�� ������� �����Ͻÿ�.
          �������� ��ǰ���̺�� ����������� �ϸ� ��¥�� 2020�� 1�� 1�Ϸ� ����
    
    UPDATE REMAIN A
       SET (A.REMAIN_J_00,A.REMAIN_J_99,A.REMAIN_DATE)=
           (SELECT A.REMAIN_J_00+B.PROD_PROPERSTOCK,
                   A.REMAIN_J_99+B.PROD_PROPERSTOCK,
                   TO_DATE('20200101')
              FROM PROD B
             WHERE A.PROD_ID=B.PROD_ID)
    WHERE A.REMAIN_YEAR='2020';
    
    SELECT*
    FROM REMAIN;
    
(��뿹)2020�� 1�� ��ǰ�� ���Լ����� ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�
        
    UPDATE REMAIN A
       SET (A.REMAIN_I, A.REMAIN_J_99,A.REMAIN_DATE)= -- ������ �߻��� �ڷḸ ����Ǿ����.
           (SELECT A.REMAIN_I+B.BSUM, A.REMAIN_J_99+B.BSUM, TO_DATE('20200201')
              FROM (SELECT BUY_PROD AS BID,
                           SUM(BUY_QTY) AS BSUM
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                     GROUP BY BUY_PROD) B
             WHERE A.PROD_ID=B.BID)             
     WHERE A.REMAIN_YEAR='2020'
       AND A.PROD_ID IN(SELECT DISTINCT(BUY_PROD)
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'));
                         
                         
    (2020�� 2������ 4�������� ��ǰ�� ���Լ����� ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�.)
    UPDATE REMAIN A
       SET (A.REMAIN_I, A.REMAIN_J_99,A.REMAIN_DATE)= -- ������ �߻��� �ڷḸ ����Ǿ����.
           (SELECT A.REMAIN_I+B.BSUM, A.REMAIN_J_99+B.BSUM, TO_DATE('20200430')
              FROM (SELECT BUY_PROD AS BID,
                           SUM(BUY_QTY) AS BSUM
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200430')
                     GROUP BY BUY_PROD) B
             WHERE A.PROD_ID=B.BID)             
     WHERE A.REMAIN_YEAR='2020'
       AND A.PROD_ID IN(SELECT DISTINCT(BUY_PROD)
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200430'));
                         
  SELECT * FROM REMAIN;
       
ROLLBACK;

    (��������1:2020�� 1�� ��ǰ�� ���Լ���)
      SELECT BUY_PROD,
             SUM(BUY_QTY)
        FROM BUYPROD
       WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
       GROUP BY BUY_PROD;
    (��������2:2020�� 1�� ���Ի�ǰ ��ȸ)
    SELECT DISTINCT(BUY_PROD)
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');
     
     
     
��뿹) 2020�� 4�� ��ٱ������̺��� �Ǹż����� ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�.

    UPDATE REMAIN A
       SET (A.REMAIN_O, A.REMAIN_J_99,A.REMAIN_DATE)=
           (SELECT A.REMAIN_O+B.BSUM, A.REMAIN_J_99-B.BSUM, TO_DATE('20200430')
              FROM (SELECT CART_PROD AS BID,
                           SUM(CART_QTY) AS BSUM
                      FROM CART
                     WHERE SUBSTR(CART_NO,1,6) LIKE '202004'
                     GROUP BY CART_PROD) B
             WHERE A.PROD_ID=B.BID)             
     WHERE A.REMAIN_YEAR='2020'
       AND A.PROD_ID IN(SELECT DISTINCT(CART_PROD)
                          FROM CART
                         WHERE SUBSTR(CART_NO,1,6) LIKE '202004');
                         
SELECT * FROM REMAIN;
                         
ROLLBACK;
                                            
commit;

(��������1 2020�� 4�� ��ǰ�� �Ǹż���)     
     SELECT CART_PROD AS BNO,
            SUM(CART_QTY) AS BSUM
       FROM CART
      WHERE SUBSTR(CART_NO,1,6) LIKE '202004'
      GROUP BY CART_PROD
      ORDER BY 1
      
(��������2 2020�� 4�� �Ǹ���ǰ)           
    SELECT DISTINCT(CART_PROD)
      FROM CART
      WHERE SUBSTR(CART_NO,1,6) LIKE '202004'
      
** ������� ���� Ʈ����
  - �԰�߻��� �ڵ����� �������
  
  CREATE OR REPLACE TRIGGER TG_INPUT
    AFTER INSERT ON BUYPROD
    FOR EACH ROW
DECLARE -- ��������
     V_QTY NUMBER:=0;
     V_PROD PROD.PROD_ID%TYPE;
BEGIN -- 
     V_QTY:=(:NEW.BUY_QTY);
     V_PROD:=(:NEW.BUY_PROD);
     
     UPDATE REMAIN A
        SET A.REMAIN_I=A.REMAIN_I+V_QTY,
            A.REMAIN_J_99=A.REMAIN_J_99+V_QTY,
            A.REMAIN_DATE=SYSDATE
      WHERE A.PROD_ID=V_PROD;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܹ߻� : '||SQLERRM);
END;

**��ǰ�ڵ�'P101000001' ��ǰ 50���� ���ó�¥�� �����Ѵ�.
  (���Դܰ��� 210000��)
  ����Ȳ          ��  ��  ��  ��
  2020	P101000001	99	38	5	132	2020/04/30
  
  INSERT INTO BUYPROD 
    VALUES(SYSDATE,'P101000001',50,210000);


SELECT * FROM REMAIN;

**���������� �̿��� ���̺����
 - CREATE TABLE ��ɰ� ���������� ����Ͽ� ���̺��� �����ϰ�
   �ش�Ǵ� ���� ������ �� �ִ�.
 - �������� ����(����)��������
 (�������)
  CREATE TABLE ���̺��[(�÷���[,�÷���,...])]
    AS (��������);
 (��뿹) ���������̺��� ��� �����͸� �����Ͽ� ���ο����̺���
          �����Ͻÿ�. ���̺���� TEMP_REMAIN�̴�.
    CREATE TABLE TEMP_REMAIN AS 
      (SELECT * FROM REMAIN);
          
          SELECT * FROM TEMP_REMAIN;
          
3. DELETE ������ �������� ���
  ** �������
      DELETE FROM ���̺��
    [WHERE����];    
    
(��뿹)TEMP_REMAIN ���̺��� 2020�� 7�� �Ǹŵ�
        ��ǰ�� ���� �ڵ��� �ڷḦ �����Ͻÿ�.
        
    SELECT DISTINCT CART_PROD
      FROM CART
     WHERE CART_NO LIKE '202007%' 
     
     DELETE FROM TEMP_REMAIN A
      HERE REMAIN_TEAR='2020'
       AND A.PROD_ID=(SELECT DISTINCT CART_PROD
                        FROM CART
                       WHERE CART_NO LIKE '202007%');