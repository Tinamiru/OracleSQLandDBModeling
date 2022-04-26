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
           0 AS PARENT_ID,
           1 AS LEVELS
     FROM HR.DEPTS
    WHERE PARENT_ID IS NULL; 
UNION ALL
   SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
          LPAD(' ',4*(2-1))||B.DEPARTMENT_NAME AS �μ���,
          B.PARENT_ID AS �����μ��ڵ�,
          2 AS ����
     FROM HR.DEPTS A, HR.depts B 
    WHERE PARENT_ID IS NULL
      AND B.PARENT_ID=A.DEPARTMENT_ID;               