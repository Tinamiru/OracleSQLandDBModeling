2022-0407-01)
1.DML ���
 1) ���̺� �������(CREATE TABLE)
  - ����Ŭ���� ���� ���̺��� ����
  (�������)
  CREATE TABLE ���̺��(
    �÷��� ������ Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��] [,]
                    :
    �÷��� ������ Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��] [,]
    [CONSTRAINT �⺻Ű�ε����� PRIMARY KEY(�÷���[,�÷���,...])[,]]
    [CONSTRAINT �ܷ�Ű�ε����� FOREIGN KEY(�÷���[,�÷���,...])
     REFERENCES ���̺��(�÷���[,�÷���,...])[,]]
    [CONSTRAINT �ܷ�Ű�ε����� FOREIGN KEY(�÷���[,�÷���,...])
     REFERENCES ���̺��(�÷���[,�÷���,...])]
     );
    . '���̺��', �÷���, �ε����� : ��������Ǵܾ ���
    . 'NOT NULL'�� ����� �÷��� ������ ���Խ� ���� �Ұ���
    . 'DEFAULT ��':����ڰ� �����͸� �Է����� ���� ��� �ڵ����� ���ԵǴ� ��
    . '�⺻Ű�ε�����','�ܷ�Ű�ε�����','���̺��'�� �ߺ��Ǿ�� �ȵ�
    . '���̺��(�÷���[,�÷���,...])])': �θ����̺�� �� �θ����̺��� ���� �÷���
        �÷���
  ��뿹)���̺��1�� ���̺���� �����Ͻÿ�.

  CREATE TABLE GOODS(
    GOOD_ID CHAR(4) NOT NULL, --�⺻Ű
    GOOD_NAME VARCHAR2(50),
    PRICE NUMBER(8),
    CONSTRAINT pk_goods PRIMARY KEY(GOOD_ID)
  );

  CREATE TABLE CUSTS(
    CUST_ID CHAR(4), --�⺻Ű
    CUST_NAME VARCHAR2(50),
    ADDRESS VARCHAR2(100),
    CONSTRAINT pk_custs PRIMARY KEY(CUST_ID)
  );
    
  CREATE TABLE ORDERS(
    ORDER_ID CHAR(11),
    ORDER_DATE DATE DEFAULT SYSDATE,
    CUST_ID CHAR(4),
    ORDER_AMT NUMBER(10) DEFAULT 0, --10�����.(10���ڸ�)
    CONSTRAINT pk_orders PRIMARY KEY(ORDER_ID),
    CONSTRAINT fk_order_cust FOREIGN KEY(CUST_ID)
        REFERENCES CUSTS(CUST_ID)
  );
  
  CREATE TABLE GOOD_ORDERS(
    ORDER_ID CHAR(11),
    GOOD_ID CHAR(4),
    ORDER_QTY NUMBER(3),
    CONSTRAINT pk_gord PRIMARY KEY(GOOD_ID, ORDER_ID), --�ε����� PK_GORD�� ���� �� GOOD_ID, ORDER_ID�� �⺻Ű�� ����
    CONSTRAINT fk_gord_orders FOREIGN KEY(ORDER_ID)
        REFERENCES ORDERS(ORDER_ID),
    CONSTRAINT fk_gord_custs FOREIGN KEY(GOOD_ID)
        REFERENCES GOODS(GOOD_ID)
  );
  
2. INSERT ���
 - ������ ���̺� ���ο� �ڷḦ �Է�
 (�������)
  INSERT INTO ���̺��[(�÷���[,�÷���,...])]     -- INSERT INTO(�μ�Ʈ ����) '�÷���'�� ������ ������ �°� VALUES ��,
                                                -- ���� ���߾� �Է��ؾ� ������ �ȳ�. ���̺�� �����Ұ��, "���� ���̺� ���� ��� �÷��� �����͸� �ְڴ�."
    VALUES(��1[,��2,...]);
  . '���̺��[(�÷���[,�÷���,...])]': '�÷���'�� �����ǰ� ���̺�� ����Ǹ�
    ���̺��� ��� �÷��� �Էµ� �����͸� ������ ���߾� ����ؾ���(���� �� ���� ��ġ)
  . '(�÷���[,�÷���,...])': �Է��� �����Ϳ� �ش��ϴ� �÷��� ���, �� NOT NULL
    �÷��� ���� �� �� ����.

��뿹)���� �ڷḦ GOODS ���̺� �����Ͻÿ�.
    ��ǰ�ڵ�     ��ǰ��     ����
-----------------------------------------------------
    P101        ����       500
    P102        ���콺     15000
    P103        ����       300
    P104        ���찳     1000
    P201        A4����     7000
    
    INSERT INTO GOODS VALUES('P101','����',500);
    INSERT INTO GOODS(good_id,GOOD_NAME) 
        VALUES('P102','���콺');       -- ���콺�� ������ �Էµ��� �ʾҴ�. (NULL). �̶� �μ�Ʈ ������ ����. ������ ��쿡�� UPDATE�� ����ؾ��Ѵ�.
    INSERT INTO GOODS(good_id,GOOD_NAME,PRICE)
        VALUES('P103','����',300);
        
    SELECT * FROM GOODS;
    
��뿹)�����̺�(CUSTS)�� ���� �ڷḦ �Է��Ͻÿ�
        ����ȣ    ����     �ּ�
    ---------------------------------------
        a001       ȫ�浿      ������ �߱� ���� 846
        a002       ���μ�      ����� ���ϱ� ����1�� 66
    
    INSERT INTO CUSTS VALUES('a001','ȫ�浿','������ �߱� ���� 846');
    -- INSERT INTO CUSTS(cust_id,ADDRESS) VALUES('a002','���μ�','����� ���ϱ� ����1�� 66'); �� too many values �÷����� ���� ���� �����ʴ�. �ʹ�����.
    -- INSERT INTO CUSTS(cust_id,ADDRESS) VALUES('a001','����� ���ϱ� ����1�� 66'); �� �⺻Ű�� �ߺ�, �� ���ϼ��� �ߺ�(a001�� �ߺ���.)
    
    INSERT INTO CUSTS(cust_id,ADDRESS) VALUES('a002','����� ���ϱ� ����1�� 66');
     SELECT * FROM CUSTS;
     
��뿹)���� ȫ�浿 ���� �α��� ���� ��� �ֹ����̺� �ش� ������ �Է��Ͻÿ�.
    INSERT INTO ORDERS(ORDER_ID,CUST_ID)
        VALUES('20220407001','a001');
        


��뿹)���� ȫ�浿 ���� ������ ���� �������� �� ���Ż�ǰ���̺�(GOOD_ORDERS)
      �� �ڷḦ �����Ͻÿ�.
        ���Ź�ȣ        ��ǰ��ȣ    ����
      -------------------------------------------------------------
        20220407001     P101      5
        20220407001     P102      10
        20220407001     P103      2

    INSERT INTO GOOD_ORDERS
      VALUES('20220407001','P101',5);

    INSERT INTO GOOD_ORDERS
      VALUES('20220407001','P102',10);
    
    INSERT INTO GOOD_ORDERS
      VALUES('20220407001','P103',2);
      
    UPDATE GOODS
      SET PRICE=15000
    WHERE GOOD_ID='P102';
    
    
    UPDATE ORDERS
      SET ORDER_AMT=ORDER_AMT+(SELECT A.ORDER_QTY*B.PRICE
                              FROM GOOD_ORDERS A, GOODS B
                              WHERE A.GOOD_ID=B.GOOD_ID
                              AND ORDER_ID='20220407001')
                              AND A.GOOD_ID='P103')
    WHERE ORDER_ID='20220407001';
     -- �μ�Ʈ �� ��� �ڵ����� ������Ʈ �� �� �ִ� ����� �ִ� �̰��� Ʈ���Ŷ�� �Ѵ�.
    SELECT * FROM orders;
    SELECT * FROM GOOD_ORDERS;
    
3. UPDATE ���
 - �̹� ���̺� �����ϴ� �ڷḦ ������ �� ���
 (�������)
   UPDATE ���̺��
      SET �÷���=��[,]
            :
          �÷���=��
    [WHERE ����]; -- WHERE�� ������������� ��� ���� �����Ѵ�. ��, WHERE�� ���� �����ϴ°��̶�� �����ϸ� �ɰͰ���.
    
    SELECT PROD_NAME AS ��ǰ��,
           PROD_COST AS ���Դܰ�
      FROM PROD;
      
    UPDATE PROD              -- WHERE�� �������� ���� ��� ��(�Ｚ����� 19��ġ ���ݺ���)
       SET PROD_COST=500000;
    
    ROLLBACK; -- �ǵ����� ���.
    
       UPDATE PROD              -- +10%
       SET PROD_COST=PROD_COST+ROUND(PROD_COST*0.1);
       
    --�����ϴ� �ڷḦ '������Ʈ'�ϴ� ���.
    
��뿹) ��ǰ���̺��� �з��ڵ尡 'P101'�� ���� ��ǰ�� ���԰����� 10%
       �λ��Ͻÿ�.
       
    UPDATE PROD              -- +10%
       SET PROD_COST=PROD_COST+ROUND(PROD_COST*0.1)
       WHERE PROD_LGU='P101';
    