2022-0502-02)
2. SEQUENCE
  - ���������� ����(�Ǵ� ����)�Ǵ� ���� ��ȯ�ϴ� ��ü
  - Ư�� ���̺� ���ӵ��� ����
  - �⺻Ű�� ������ Ư�� �׸��� ���� ��� �ַ� ���
 (�������)
  CREATE SEQUENCE �������� -- ������, DROP SEQUNCE ��������
    [START WITH n] -- n���� ����
    [INCREMENT BY n] --���� ���Ұ�(n)
    [MAXVALUE n|NOMAXVALUE} --������ ����, �⺻�� NOMAXVALUE�̸� 10^27
    [MINVALUE n|NOMINVALUE} --�ּҰ� ����, �⺻�� NOMINVALUE�̸� ���� 1 ��
    [CYCLE|NOCYCLE] : -- ����/�ּ� ������ ������ �� �ٽ� �������� ����. �⺻��
                      -- NOMAXVALUE�̸� 1��
    [CACHE n|NOCACHE] : -- ������ �������� ĳ�� �޸𸮿� ������ ������ ����.
                        -- �⺻�� NOCACHE 20
    [ORDER | NOORDER] : --���ǵȴ�� ������ ���忩�� �⺻�� NOORDER
    
** ������ ����� ���ѵǴ� �� -- INSERT���� VALUES�� �ַ� �����
  . SELECT, UPDATE, DELETE ���� SUBQUERY
  . VIEW�� ��������ϴ� QUERY
  . DISTINCT�� ���� SELECT��
  . GROUP BY, ORDER BY ���� ���� SELECT��
  . ���տ����ڰ� ���� SELECT��
  . SELECT���� WHERE ��

** �������� ���Ǵ� �ǻ��÷�
   ��������.CURRVAL : ��������ü�� ���簪
   ��������.NEXTVAL : ��������ü�� ������
 ** �������� �����ǰ� ù ���� �����ؾ��� ����� �ݵ�� NEXTVALUE �� �Ǿ�� ��
  

��뿹)�з����̺� ����� �������� �����Ͻÿ�.
       ���۰��� 10�̰� 1�� �����ؾ���
       
    CREATE SEQUENCE SEQ_LPROD
      START WITH 10;
    
    SELECT SEQ_LPROD.NEXTVAL FROM DUAL;
    SELECT SEQ_LPROD.CURRVAL FROM DUAL;
    
    DROP SEQUENCE SEQ_LPROD;
    
��뿹) �����ڷḦ �з����̺� �����Ͻÿ�.
   [�ڷ�]
    LPROD_ID        LPROD_GU        LPROD_NM
-----------------------------------------------------
    ���������        P501           ��깰
    ���������        P502           ���깰
    ���������        P503           �ӻ깰
    
  INSERT INTO LPROD
    VALUES(SEQ_LPROD.NEXTVAL,'P501','��깰');
    
  INSERT INTO LPROD
    VALUES(SEQ_LPROD.NEXTVAL,'P502','���깰');
    
  INSERT INTO LPROD
    VALUES(SEQ_LPROD.NEXTVAL,'P503','�ӻ깰');    
    
    

3.SYNONYM(���Ǿ�)
  - ����Ŭ���� ���Ǵ� ��ü�� �ο��� �� �ٸ� �̸�.
  - �� ��ü���̳� ����ϱ� ����� ��ü���� ����ϱ� ���� ����ϱ⽬��
    �̸����� ��� -- ��Ī�� �ٸ���.
    
 (�������)
 CREATE OR REPLACE SYNONYM ��Ī FOR ��ü��;
   .'��ü��'�� '��Ī'���� �� �ٸ� �̸� �ο�
   
��뿹) HR������ ������̺�� �μ����̺���
        EMP, DEPT�� ��Ī(���Ǿ�)�� �ο��Ͻÿ�
        
   CREATE OR REPLACE SYNONYM EMP FOR HR.employees; 
   CREATE OR REPLACE SYNONYM DEPT FOR HR.departments;
   
   SELECT * FROM EMP;
   SELECT * FROM DEPT;
   
4. INDEX
  - ���̺� ����� �ڷḦ ȿ����(����)���� �˻��ϱ����� ���
  - ����Ŭ������ ����ڷκ��� �˻������ �ԷµǸ� ��ü�� �������
    �˻�(FULL SCAN)���� �Ǵ� �ε��� ��ĵ(INDEX SCAN)�� ���� ������
  - �ε����� �ʿ��� �÷�
    . ���� �˻��ϴ� �÷�
    . WHERE ������ '='�����ڷ� Ư�� �ڷḦ �˻��ϴ� ���
    . �⺻Ű
    . SORT(ORDER BY)�� JOIN���꿡 ���� ���Ǵ� �÷�
    
    -- ? ����, �ε���ó�� �ð�,�ҿ�ð�, �ð����⵵�� �߿�����
  
  - �ε����� ����
    . Unique / Non-unique
         -- ����. Null�� �ѹ� ���(Null�� �����ͷ� ����ϱ⶧����)
                -- Non. �ߺ�����.
    . Single / Composite �÷��� �ϳ��ϰ�� Single, �ΰ��̻��ϰ�� Composite
    . Normal(Default��) / Bitmap / Function-based(�Լ����)
    
  (�������)
   CREATE [UNIQUE|BITMAP] INDEX ���ؽ���
     ON ���̺�(�÷���[,�÷���,...]) [ASC|DESC];
    . 'ASC|DESC' : �������� �Ǵ� ������������ �ε��� ����
                   �⺻�� ASC
    
    
��뿹)
  CREATE INDEX IDX_MEM_NAME
    ON MEMBER(MEM_NAME);
    
    SELECT * FROM MEMBER
     WHERE MEM_NAME='����ȸ';
     
  DROP INDEX IDX_MEM_NAME;
    
    
��뿹)
  CREATE INDEX IDX_PROD
    ON PROD(SUBSTR(PROD_ID,1,5)||SUBSTR(PROD_ID,9));
    
    SELECT * FROM PROD
     WHERE SUBSTR(PROD_ID,1,5)||SUBSTR(PROD_ID,9)='P202013';
 
** �ε����� �籸��
  - �ε����� �ٸ����̺����̽��� �̵���Ű�� ���
  - ���������̺��� �̵��� ���
  - ���Ի����� �ټ� �߻��� ����
  ALTER �ε����� REBUILD:
  
    
    
    
    
        