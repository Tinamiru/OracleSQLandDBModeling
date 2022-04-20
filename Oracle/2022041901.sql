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

    
��뿹) �������̺�(BUYPROD)���� 2020�� ��ݱ�(1��~6��) ����, ��ǰ�� �������踦 ��ȸ�Ͻÿ�.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS ����,
           BUY_PROD AS ��ǰ�ڵ�,
           SUM(BUY_QTY) AS ���Լ����հ�,
           SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE), BUY_PROD
     ORDER BY 1,2;
     
     
��뿹) �������̺�(BUYPROD)���� 2020�� ��ݱ�(1��~6��) ���� �������踦 ��ȸ�ϵ�
       ���Աݾ��� 1��� �̻��� ���� ��ȸ�Ͻÿ�.
    SELECT EXTRACT(MONTH FROM BUY_DATE) AS ����,
           SUM(BUY_QTY) AS ���Լ����հ�,
           SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�           
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    HAVING SUM(BUY_QTY*BUY_COST)>=100000000
     ORDER BY 1;

       
��뿹) ȸ�����̺��� ���� ��� ���ϸ����� ��ȸ�Ͻÿ�.

  SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                   SUBSTR(MEM_REGNO2,1,1)='3' THEN
                   '����'
              ELSE 
                   '����'
         END AS ����,
         ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
    FROM MEMBER
   GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                      SUBSTR(MEM_REGNO2,1,1)='3' THEN
                      '����'
                 ELSE 
                      '����'
             END;

��뿹) ȸ�����̺��� ���ɺ� ��ո��ϸ����� ��ȸ�Ͻÿ�
  SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)||'��'
            AS ���ɴ�,
         ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
    FROM MEMBER
   GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR),-1)||'��'
   ORDER BY 1;

��뿹) ȸ�����̺��� �������� ��ո��ϸ����� ��ȸ�Ͻÿ�.
  SELECT SUBSTR(MEM_ADD1,1,2) AS ������,
         ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
    FROM MEMBER
   GROUP BY SUBSTR(MEM_ADD1,1,2);

��뿹) �������̺�(BUYPROD)���� 2020�� ��ݱ�(1��~6��) ��ǰ�� �������踦 ��ȸ�ϵ�
       �ݾ� ���� ���� 5�� ��ǰ�� ��ȸ�Ͻÿ�.
   SELECT A.BID AS ��ǰ�ڵ�,
          A.QSUM AS �����հ�,
          A.CSUM AS �ݾ��հ�
     FROM (SELECT BUY_PROD AS BID, -- ���� �Ҷ� �ѱ��� ��Ȯ�ϰ� �����Ǿ����ٴ� ������ �ȵȴ�. ������ ����������.
                  SUM(BUY_QTY) AS QSUM,
                  SUM(BUY_QTY*BUY_COST) AS CSUM
             FROM BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
            GROUP BY BUY_PROD
            ORDER BY 3 DESC)A
    WHERE ROWNUM<=5;
 
 
 5. ROLLUP�� CUBE
   1) ROLLUP
     - GROUP BY �� �ȿ� ����Ͽ� ������ ������ ����� ��ȯ
    (�������)
      GROUP BY ROLLUP[�÷���1[,�÷���2,...,�÷���n])
        . �÷���1,�÷���2,...,�÷���n ��(���� ��������) �������� �׷챸���Ͽ� �׷��Լ� ������ �� 
          �����ʿ� ����� �÷����� �ϳ��� ������ �������� �׷� ����, ���������� ��ü �հ� ��ȯ
        . n���� �÷���  ���� ��� n+1������ �����ȯ��
        
��뿹) ��ٱ������̺��� 2020�� ����,ȸ����,��ǰ�� �Ǹż��� ���� ��ȸ.        
 -- GROUP BY �� ����� ���.
      SELECT SUBSTR(CART_NO,5,2) AS ��,
             CART_MEMBER AS ȸ����ȣ,
             CART_PROD AS ��ǰ�ڵ�,
             SUM(CART_QTY) AS �Ǹż�������
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD
       ORDER BY 1;
       
 -- ROLLUP�� ��       
      SELECT SUBSTR(CART_NO,5,2) AS ��,
             CART_MEMBER AS ȸ����ȣ,
             CART_PROD AS ��ǰ�ڵ�,
             SUM(CART_QTY) AS �Ǹż�������
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER,CART_PROD)
       ORDER BY 1;
       
  ** �κ� ROLLUP
    . �׷��� �з� ���� �÷��� ROLLUP�� ��(GROUP BY �� ��)�� ����� ��츦 �κ� ROLLUP �̶�� ��
    . ex) GROUP BY �÷���1, ROLLUP(�÷���2,�÷���3) �� ���
      => �÷���1, �÷���2, �÷���3 ��ΰ� ����� ����
         �÷���1, �÷���2�� �ݿ��� ����
         �÷���1�� �ݿ��� ����
  -- ROLLUP�� ��       
      SELECT SUBSTR(CART_NO,5,2) AS ��,
             CART_MEMBER AS ȸ����ȣ,
             CART_PROD AS ��ǰ�ڵ�,
             SUM(CART_QTY) AS �Ǹż�������
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY CART_PROD, ROLLUP(SUBSTR(CART_NO,5,2), CART_MEMBER)
       ORDER BY 1;


   2) CUBE
     - GROUP BY �� �ȿ��� ���(ROLLUP�� ����)
     - ���������� ����
     - CUBE ���� ����� �÷����� ���� ������ ��츶�� �����ȯ(2�� n�¼� ��ŭ�� �����ȯ)
   (�������)
     GROUP BY CUBE(�÷���1,...�÷���n);
     
      SELECT SUBSTR(CART_NO,5,2) AS ��,
             CART_MEMBER AS ȸ����ȣ,
             CART_PROD AS ��ǰ�ڵ�,
             SUM(CART_QTY) AS �Ǹż�������
        FROM CART
       WHERE SUBSTR(CART_NO,1,4)='2020'
       GROUP BY CUBE(SUBSTR(CART_NO,5,2),CART_MEMBER,CART_PROD)
       ORDER BY 1;
     
     