2022-0426-01)���տ�����
  - SQL������ ����� ������ ����(set)�̶�� ��.
  - �̷� ���յ� ������ ������ �����ϱ� ���� �����ڸ� ���տ����ڶ� ��.
  - UNION, UNION ALL, INTERSECT, MINUS�� ����
  - ���տ����ڷ� ����Ǵ� �� SELECT���� SELECT���� �÷��� ����, ����, Ÿ����
    ��ġ�ؾ���.
  - ORDER BY ���� �� ������ SELECT������ ��� ����.
  - ����� ù ��° SELECT���� SELECT���� ������ ��.
  - 

(�������)
   SELECT �÷�LIST
     FROM ���̺��
   [WHERE ����]
  UNION|UNION ALL|INTERSECT|MINUS
   SELECT �÷�LIST
     FROM ���̺��
   [WHERE ����]
        :
        :
  UNION|UNION ALL|INTERSECT|MINUS
   SELECT �÷�LIST
     FROM ���̺��
   [WHERE ����]
   [ORDER BY �÷���|�÷�index [ASC|DESC],...];
   
1. UNION
  - �ߺ��� ������� ���� �������� ����� ��ȯ.
  - �� SELECT���� ����� ��� ����
  
��뿹)ȸ�����̺��� 30�� ����ȸ���� �泲����ȸ����
       ȸ����ȣ,ȸ����,����,���ϸ����� ��ȸ�Ͻÿ�

  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)
         BETWEEN 20 AND 29
     AND SUBSTR(MEM_REGNO2,1,1) IN('2','4')
UNION
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_ADD1 LIKE '�泲%'
   ORDER BY 1;
   
2. INTERSECT
  - ������(����κ�)�� ��� ��ȯ
  
��뿹)ȸ�����̺��� 30�� ����ȸ���� �泲����ȸ�� �� ���ϸ����� 2000�̻���
       ȸ����ȣ,ȸ����,����,���ϸ����� ��ȸ�Ͻÿ�
        
        
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)
         BETWEEN 20 AND 29
     AND SUBSTR(MEM_REGNO2,1,1) IN('2','4')
UNION
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_ADD1 LIKE '�泲%'
INTERSECT
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE>2000
   ORDER BY 1;

3. UNION ALL
  - �ߺ��� ����Ͽ� �������� ����� ��ȯ.
  - �� SELECT���� ����� ��� ����(�ߺ� ����)
  -- ������ ������ ����Ŭ���� ����

��뿹)
    1) DEPTS���̺��� PARENT_ID�� NULL�� �ڷ���  �μ��ڵ�,�μ���,�����μ��ڵ�,
       ������ ��ȸ�Ͻÿ�
       ��, �����μ��ڵ�� 0�̰� ������ 1�̴�
       
    SELECT DEPARTMENT_ID,
           DEPARTMENT_NAME,
           0 AS PARENT_ID,
           1 AS LEVELS
     FROM HR.DEPTS
    WHERE PARENT_ID IS NULL; 
              
    2) DEPTS���̺��� PARENT_ID�� NULL�� �����μ��ڵ带 �����μ��ڵ�� ����
       �μ��� �μ��ڵ�,�μ���,�����μ��ڵ�,������ ��ȸ�Ͻÿ�.
       ��, ������ 2�̰� �μ����� ���ʿ� 4ĭ�� ������ ���� �� �μ��� ���

   SELECT A.DEPARTMENT_ID,
          LPAD(' ',4*(2-1))||A.DEPARTMENT_NAME AS DEPARTMENT_NAME,
          B.PARENT_ID AS PARENT_ID,
          2 AS LEVELS
     FROM HR.departments A, HR.depts B 
    WHERE B.PARENT_ID IS NULL
      AND B.PARENT_ID=A.DEPARTMENT_ID;
      
      
      
      
   SELECT DEPARTMENT_ID,
          DEPARTMENT_NAME,
          NVL(PARENT_ID,0) AS PARENT_ID,
          1 AS LEVELS,
          PARENT_ID||DEPARTMENT_ID AS TEMP
     FROM HR.DEPTS
    WHERE PARENT_ID IS NULL
UNION ALL
   SELECT B.DEPARTMENT_ID,
          LPAD(' ',4*(2-1))||B.DEPARTMENT_NAME AS DEPARTMENT_NAME,
          NVL(B.PARENT_ID,0) AS PARENT_ID,
          2 AS LEVELS,
          B.PARENT_ID||B.DEPARTMENT_ID AS TEMP
     FROM HR.depts A, HR.depts B 
    WHERE A.PARENT_ID IS NULL
      AND B.PARENT_ID=A.DEPARTMENT_ID
UNION ALL
   SELECT C.DEPARTMENT_ID,
          LPAD(' ',4*(3-1))||C.DEPARTMENT_NAME AS DEPARTMENT_NAME,
          NVL(C.PARENT_ID,0) AS PARENT_ID,
          3 AS LEVELS,
          B.PARENT_ID||C.PARENT_ID||C.DEPARTMENT_ID AS TEMP         
     FROM HR.depts A, HR.depts B, HR.depts C
    WHERE A.PARENT_ID IS NULL
      AND B.PARENT_ID=A.DEPARTMENT_ID
      AND C.PARENT_ID=B.DEPARTMENT_ID
    ORDER BY 5;
    
**������ ����
  - ������ ������ ���� ���̺��� ������ ����Ҷ� ���
  - Ʈ�������� �̿��� ���
  (�������)
     SELECT �÷�list
       FROM ���̺��
      START WITH ���� -- ��Ʈ(root)��� ����
    CONNECT BY NOCYCLE|PRIOR �������� ���� -- ���������� ������� ����Ǿ����� ����
    

** CONNECT BY PRIOR �ڽ��÷� = �θ��÷� : �θ𿡼� �ڽ����� Ʈ������(Top DOWN)
   CONNECT BY PRIOR �θ��÷� = �ڽ��÷� : �ڽĿ��� �θ�� Ʈ������(DOWN Top)

** PRIOR �����ġ�� ���� ����
     CONNECT
  

**������ ���� Ȯ��
    CONNECT_BY_ROOT �÷��� : ��Ʈ��� ã��
    CONNECT_BY_ISCYCLE : �ߺ������� ã��
    CONNECT_BY_ISLEAF : �ܸ���� ã��
    
    
    
    
    
    
    
    
    
(��뿹) ��ٱ������̺��� 4���� 6���� �Ǹŵ� ��� ��ǰ������ �ߺ����� �ʰ� ��ȸ�Ͻÿ�
         Alias�� ��ǰ��ȣ, ��ǰ��, �Ǹż��� �̸� ��ǰ��ȣ ������ ����Ͻÿ�.

(�Ϲݻ��)
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS �Ǹż���
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
           AND (SUBSTR(CART_NO,5,2)='04'
                OR SUBSTR(CART_NO,5,2)='06')
     GROUP BY A.CART_PROD, B.PROD_NAME
     ORDER BY 1;
     
(���տ����� ���)
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS �Ǹż���
      FROM CART A, PROD B      
     WHERE A.CART_PROD=B.PROD_ID
       AND SUBSTR(A.CART_NO,5,2)='06'
     GROUP BY A.CART_PROD, B.PROD_NAME
UNION
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS �Ǹż���
      FROM CART A, PROD B      
     WHERE A.CART_PROD=B.PROD_ID
       AND SUBSTR(A.CART_NO,5,2)='04'
     GROUP BY A.CART_PROD, B.PROD_NAME
     ORDER BY 1;
     
(ANSI)
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS �Ǹż���
      FROM CART A
     INNER JOIN PROD B ON(A.CART_PROD=B.PROD_ID AND SUBSTR(A.CART_NO,5,2)='06')
     GROUP BY A.CART_PROD, B.PROD_NAME
UNION
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS �Ǹż���
      FROM CART A
     INNER JOIN PROD B ON(A.CART_PROD=B.PROD_ID AND SUBSTR(A.CART_NO,5,2)='04')
     GROUP BY A.CART_PROD, B.PROD_NAME
     ORDER BY 1;     
     
          
(��뿹) ��ٱ������̺��� 4������ �Ǹŵǰ� 6������ �Ǹŵ� ��ǰ������ ��ȸ�Ͻÿ�
         Alias�� ��ǰ��ȣ, ��ǰ���̸� ��ǰ��ȣ ������ ����Ͻÿ�.
         
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
       AND SUBSTR(CART_NO,5,2)='04'
     GROUP BY A.CART_PROD, B.PROD_NAME
INTERSECT
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
       AND SUBSTR(CART_NO,5,2)='06'
     GROUP BY A.CART_PROD, B.PROD_NAME
     ORDER BY 1;
         
         
(��뿹) ��ٱ������̺��� 4���� 6���� �Ǹŵ� ��ǰ �� 6������ �Ǹŵ� ��ǰ������ ��ȸ�Ͻÿ�
         Alias�� ��ǰ��ȣ, ��ǰ��, �Ǹż��� �̸� ��ǰ��ȣ ������ ����Ͻÿ�.

    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS �Ǹż���
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
           AND (CART_NO LIKE '202004%'
                OR CART_NO LIKE '202006%')
     GROUP BY A.CART_PROD, B.PROD_NAME
MINUS
    SELECT A.CART_PROD AS ��ǰ��ȣ,
           B.PROD_NAME AS ��ǰ��,
           SUM(A.CART_QTY) AS �Ǹż���
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
       AND CART_NO LIKE '202004%'
     GROUP BY A.CART_PROD, B.PROD_NAME
     ORDER BY 1;