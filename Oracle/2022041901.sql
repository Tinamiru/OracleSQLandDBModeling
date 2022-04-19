2022-0419-01) �����Լ�
 - �ڷḦ �׷�ȭ�ϰ� �׷쳻���� �հ�, �ڷ��, ���, �ִ�, �ּ� ���� ���ϴ� �Լ�
 - SUM, AVG, COUNT, MAX, MIN �� ������
 - SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ���� ��� �ݵ�� GROUP BY ����
   ����Ǿ�� ��.
 (�������)
    SELECT [�÷���1,
           [�÷���2,...]]
           �����Լ�         -- �Ϲ��÷��� ������� �ϳ��� �׷����� ���⶧���� GROUP BY �̻��.
      FROM ���̺��
    [WHERE ����]
    [GROUP BY �÷���1[,�÷���2,...]] -- ����Ʈ���� ���� �Ϲ� �÷��� �ݵ�� ����ؾ��Ѵ�.
   [HAVING ����]
    [ORDER BY �ε���|�÷��� [ASC|DESC][,...]]
      . GROUP BY���� ���� �÷����� ���ʿ� ����� ������� ��з�, �Һз��� ���� �÷���
      . HAVING ����: �����Լ��� ������ �ο��� ���
      
1. SUM(col)
  - �� �׷� ���� 'col' �÷��� ����� ���� ��� ���Ͽ� ��ȯ

2. AVG(col)
  - �� �׷� ���� 'col' �÷��� ����� ���� ����� ���Ͽ� ��ȯ
  
3. COUNT(*|col)
  - �� �׷� ���� ���� ���� ��ȯ
  - '*'�� ����ϸ� NULL���� �ϳ��� ������ ���
  - �÷����� ����ϸ� �ش� �÷��� ���� NULL�� �ƴ� ������ ��ȯ
  
4. MAX(col),MIN(col)
 -  �� �׷쳻�� 'col'�÷��� ����� �� �� �ִ밪�� �ּҰ��� ���Ͽ� ��ȯ
*** �����Լ��� �ٸ� �����Լ��� ������ �� ����. ***

��뿹)������̺��� ��ü����� �޿��հ踦 ���Ͻÿ�
��뿹)������̺��� ��ü����� ��ձ޿��� ���Ͻÿ�
   SELECT SUM(SALARY) AS �޿��հ�,
          ROUND(AVG(SALARY)) AS ��ձ޿�, -- �Ϲ� �Լ��� �����Լ��� ���� ����� �� �ִ�.
          MAX(SALARY) AS �ִ�޿�,
          MIN(SALARY) AS �ּұ޿�,
          COUNT(*) AS �����
     FROM HR.employees;
    
  SELECT AVG(TO_NUMBER(SUBSTR(PROD_ID,2,3))) -- �Ϲ� �Լ��� �����Լ��� ���� ����Ҽ��ִ�.
    FROM PROD;

��뿹)������̺��� �μ��� �޿��հ踦 ���Ͻÿ�
��뿹)������̺��� �μ��� ��ձ޿��� ���Ͻÿ�

  SELECT DEPARTMENT_ID AS �μ��ڵ�,
         SUM(SALARY) AS �޿��հ�,
         COUNT(EMPLOYEE_ID) AS �����,
         ROUND(AVG(SALARY)) AS ��ձ޿�,
         MAX(SALARY) AS �ִ�޿�,
         MIN(SALARY) AS �ּұ޿�
    FROM HR.employees
   GROUP BY DEPARTMENT_ID
   ORDER BY 1;
      
/* ��з��� �Һз��� ����.
  SELECT DEPARTMENT_ID AS �μ��ڵ�,
         EMP_NAME AS �����,
         SUM(SALARY) AS �޿��հ�,
         COUNT(EMPLOYEE_ID) AS �����,
         ROUND(AVG(SALARY)) AS ��ձ޿�,
         MAX(SALARY) AS �ִ�޿�
    FROM HR.employees
   GROUP BY DEPARTMENT_ID, EMP_NAME
   -- �з��Ǿ���� �κ��� �ΰ��� �����⶧���� ��з�, �Һз��� ���еǾ�����
   -- �ִ�޿��� ��� �̸��� ����� ��� ���������� ����Ͽ����Ѵ�.
   ORDER BY 1;
*/

��뿹)������̺��� �μ��� ��ձ޿��� 6000 �̻��� �μ��� ��ȸ�Ͻÿ�.

  SELECT DEPARTMENT_ID AS �μ��ڵ�,
         ROUND(AVG(SALARY)) AS ��ձ޿�,
         COUNT(SALARY) AS �����
    FROM HR.employees
   GROUP BY DEPARTMENT_ID
  HAVING AVG(SALARY)>=6000 -- �����Լ��� ������ �������, WHERE ���Ұ� �� HAVING�� ���.
   ORDER BY 2 DESC;
   
��뿹) ��ٱ��� ���̺��� 2020�� 5�� ȸ���� ���ż����հ踦 ��ȸ�Ͻÿ�

   SELECT CART_MEMBER AS ȸ���ڵ�,
          SUM(CART_QTY) AS ���ż����հ�
     FROM CART
    WHERE CART_NO LIKE '202005%'
    GROUP BY CART_MEMBER
    ORDER BY 1;