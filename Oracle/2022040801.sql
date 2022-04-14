2022-0408-01)
 ��뿹)������̺�(HR���� EMPLOYEES���̺�)���� ��� ����� �޿���
       15%�λ��Ͽ� �����Ͻÿ�.
       
COMMIT;
ROLLBACK;
    SELECT FIRST_NAME, SALARY
      FROM HR.EMPLOYEES
      
    UPDATE HR.EMPLOYEES
       SET SALARY=SALARY+ROUND(SALARY*0.15) -- ���� �Լ��� �Ҽ��� ���ϸ� �����ش�.
       ;
       
  4. DELETE ���
    -���ʿ��� �ڷḦ ���̺��� ����.
    (�������)
    DELETE FROM ���̺��
    [WHERE ����]
    
��뿹)
    DELETE FROM CART;
    ROLLBACK;
   -- ����Ʈ ���� WHERE�� ������� ���� ��� ��� ���̺��� �ڷᰡ ��������.


  DELETE�� DROP�� ����)
��뿹)
    DELETE FROM ���̺��
    DROP TABLE ���̺��
    ����Ʈ�� ���̺� ���� ������ ������ ���Ǵ� ��ɾ��̸�, ����� ���̺� ���� ��ɾ��̴�.
    
5. ����Ŭ ������Ÿ��
  - ����Ŭ�� ���� ������ Ÿ���� ������������
  - ���ڿ�, ����, ��¥, 2�� ������Ÿ�� ����
  1) ���ڿ� �ڷ���
  - ����Ŭ�� ���ڿ� �ڷ�� ' '�� ���
  - ���ڿ� �ڷ����� CHAR, VARCHAR, VARCHAR2, NVARCHAR, NVARCHAR2, LONG, CLOB, NCLOB ���� ����
  -- ���⼭ n�� ������ ����ȭ �ڵ尡 �ٴ� ���̶� �����ϸ� �ȴ�. VARCHAR�� ����Ŭ������ ����Ѵ�.
  -- LONG�� ��������, CLOB�� LONG�� ��� ���׷��̵�Ȱ�. (Character Large OBjects)
  
  (1) CHAR
    . �������� ���ڿ� �ڷ� ���� -- CHAR�� ������ �ٸ� ���ڿ� �ڷ����� ��������.
    . �ִ� 2000byte ���� ���尡��
    . �������� ������ ������ ������ ������ pedding, �������� ������ 
      error
    . �⺻Ű�� �������ڷ�(�ֹι�ȣ ��) ���忡 �ַ� ���
    (��뿹)
      �÷��� CHAR(ũ��[byte|char]) -- ��Ÿ����
        . 'ũ��[byte|char]' : 'ũ��'�� ������ ���� byte���� char(���ڼ�)������ ����.
          �����ϸ� byte�� ����. ��, defalt�� byte�̴�.
        . �ѱ� �ѱ��ڴ� 3byte�� ����Ǹ� CHAR(2000CHAR)�� ����Ǿ��� ������ 
          ��ü ������ 2000byte�� �ʰ��� �� ����
          
  (��뿹)
  
    CREATE TABLE TEMP01(
      COL1 CHAR(20), -- �����ϰ�������� UPDATE?    
      COL2 CHAR(20 BYTE),
      COL3 CHAR(20 CHAR));
      
    INSERT INTO TEMP01 VALUES('������ �߱�','������ �߱�','������ �߱�');
    INSERT INTO TEMP01 VALUES('������ �߱� ���� 846','������ �߱�','������ �߱�');
     --value too large for column�� ���.
    SELECT * FROM TEMP01;
    SELECT LENGTHB(COL1),
           LENGTHB(COL2),
           LENGTHB(COL3)
      FROM TEMP01;
      
      
  (2) VARCHAR2
    . �������� ���ڿ� �ڷḦ ����
    . �ִ� 4000byte���� ���� ����
    . VARCHAR�� ���� ���
    . NVARCHAR �� NVARCHAR2�� ���� ǥ���ڵ��� UTF-8, UTF-16�������
      �����͸� ���ڵ��Ͽ� ����
  (�������)
    �÷��� VARCHAR2(ũ��[byte|char]) -- ���� 99% �����Ͽ� ���ȴ�.
    
  (��뿹)
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
    . �������� ������ ����
    . �ִ� 2GB ���� ���� ����
    . �� ���̺� �ϳ��� LONGŸ�� �÷��� ���
    . CLOB(Character Large OBjects)�� ��� ���׷��̵� �� -- BLOB(bin)�� ������
    . select ���� seclet��, update���� set��, insert���� values������ ��밡��
    . �Ϻ� �Լ������� ���� �� ����
  (�������)
    �÷��� long
    
  (��뿹)
   CREATE TABLE TEMP03(
     COL1 LONG,
     COL2 VARCHAR2(4000));
     
   INSERT INTO TEMP03 VALUES('BANNA APPLE PERSIMMON', 'BANNA APPLE PERSIMMON');
   SELECT * FROM TEMP03
   
   --����Ŭ�� �ڹٿ� �ٸ��� 0���Ͱ� �ƴ� 1���� ī��Ʈ�ȴ�.
   SELECT SUBSTR(COL2,7,5) -- COL1�� �����Ͽ� LONGŸ���� �ҷ����� ������ �����.
     FROM TEMP03;
  (4) CLOB
    . �������� ������ ����
    . �ִ� 4GB ���� ó�� ����
    . �� ���̺� �������� CLOB�ڷ�Ÿ���� �÷� ��� ����
    . �Ϻ� ����� DBMS_LOB API�� ������ �޾ƾ߻�� ����
  (�������)
   �÷��� CLOB;
   
  (��뿹)
   CREATE TABLE TEMP04(
    COL1 LONG,
    COL2 CLOB,
    COL3 CLOB,
    COL4 VARCHAR2(4000)
  );
  
  INSERT INTO TEMP04
   VALUES('', '������ �߱� ���� 846','������ �߱� ���� 846','������ �߱� ���� 846');
   SELECT * FROM TEMP04;
   
   SELECT SUBSTR(COL2, 5,2), -- �ټ���°���� �α��ڱ��� ȣ��
          DBMS_LOB.SUBSTR(COL2,5,2), -- 2��°���� �ټ����ڱ��� ȣ��
          -- DBMS_LOB API�� ������ �޶�����.
          
          DBMS_LOB.GETLENGTH(COL3), -- DBMS_LOB API ȣ�� ����Ʈ ���̼�
          LENGTHB(COL4) -- ����Ʈ�� ���� ����.
     FROM TEMP04;
  
    
    
    