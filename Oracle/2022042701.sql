2022-0427-01)��������
  - SQL�� �ȿ� �����ϴ� �� �ٸ� SQL��
  - SQL���� �ȿ� ������ ���Ǵ� �߰� ����� ��ȯ�ϴ� SQL��
  - �˷����� ���� ���ǿ� �ٰ��� ������ �˻��ϴ� SELECT���� ���
  - ���������� �˻���(SELECT)�Ӹ� �ƴ϶� DML(INSERT,UPDATE,DELETE)��������
    ����
  - ���������� '( )' �ȿ� ����Ǿ�� ��(��, INSERT���� ����ϴ� SUBQUERY�� ����)
  - ���������� �ݵ�� ������ �����ʿ� ����ؾ���
  - ���� ��� ��ȯ ��������(������ ������:>,<,>=,<=,=,!=)
    vs ���� ��� ��ȯ ��������(������ ������: IN ALL, ANY, SOME, EXISTS)
  - ������ �ִ� �������� vs ������ ���� ��������
  - �Ϲݼ������� vs in-line ��������(���ϼ��ý���� ���� �ʼ�) vs ��ø��������(WHERE�� ����Ǵ� ��������)
  
1. ������ ���� ��������
  - ���������� ���̺�� ���������� ���̺��� �������� ������� ���� ���
��뿹)������̺��� ������� ��ձ޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�.
       Alias�� �����ȣ,�����,�μ���,�޿�
       
(�������� : ������� �����ȣ,�����,�μ���,�޿��� ��ȸ)
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.SALARY AS �޿�
      FROM HR.employees A, HR.departments B
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND A.SALARY>(��ձ޿�);
       
(�������� : ������� ��ձ޿��� ��ȸ)
    SELECT AVG(SALARY)
      FROM HR.employees;

(����)
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.SALARY AS �޿�
      FROM HR.employees A, HR.departments B
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND A.SALARY>(SELECT AVG(SALARY)
                       FROM HR.employees)
     ORDER BY 1;
     
     
(��ձ޿� ���)
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.SALARY AS �޿�
      FROM HR.employees A, HR.departments B
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND A.SALARY>(SELECT AVG(SALARY)
                       FROM HR.employees)
     ORDER BY 1;

(in-line ��������)
SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.SALARY AS �޿�,
           ROUND(C.ASAL) AS ��ձ޿�
      FROM HR.employees A, HR.departments B,
           (SELECT AVG(SALARY) AS ASAL
              FROM HR.employees) C
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND A.SALARY>C.ASAL
     ORDER BY 1;


(in-line ��������)
SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.SALARY AS �޿�,
           ROUND(C.ASAL) AS ��ձ޿�
      FROM HR.employees A, HR.departments B,
           (SELECT AVG(SALARY) AS ASAL
              FROM HR.employees) C
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND A.SALARY>C.ASAL
     ORDER BY 1;
     
(in-line ��������)
/*SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.SALARY AS �޿�,
           ROUND(C.ASAL) AS ��ձ޿�
      FROM HR.employees A, HR.departments B,
           (SELECT AVG(SALARY) AS ASAL
              FROM HR.employees) C
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND A.SALARY>ANY
     ORDER BY 1;
*/
2. ������ �ִ� ��������
  - ���������� ����Ŀ���� �������� ����� ���
  - ��κ��� ��������
  
��뿹) �����������̺�(JOB_HISTORY)�� �μ����̺��� �μ���ȣ�� ����
        �ڷḦ ��ȸ�Ͻÿ�
        Alias�� �μ���ȣ,�μ��� �̴�.
        
        
 (IN ������ ���)       ANY SUM -- ������ ������
  SELECT A.DEPARTMENT_ID AS �μ���ȣ,
         A.DEPARTMENT_NAME AS �μ���
    FROM HR.departments A
   WHERE A.DEPARTMENT_ID IN(SELECT DEPARTMENT_ID -- IN Ȥ�� =ANY =SUM
                              FROM HR.job_history); 

(EXISTS ������ ���)
  SELECT A.DEPARTMENT_ID AS �μ���ȣ,
         A.DEPARTMENT_NAME AS �μ���
    FROM HR.departments A
   WHERE EXISTS (SELECT 1             -- ������ ���� �ǹ̾��� ��� '1' ����.
                                      -- Ư¡. EXISTS �տ��� ��� �÷��̳� ���� ���� �ʴ´�.
                                      -- ���ü� �ִ� ���������� ���Ǿ����.
                   FROM HR.job_history B
                  WHERE B.DEPARTMENT_ID=A.DEPARTMENT_ID);
     
��뿹) 2020�� 5�� ��ǰ�� �Ǹ����� �� �ݾױ��� ���� 3�� ��ǰ �Ǹ�����������
        ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�,��ǰ��,�ŷ�ó��,�Ǹűݾ��հ�
 
(��������: �ݾױ��� ���� 3�� ��ǰ�� ���� ��ǰ�ڵ�,��ǰ��,�ŷ�ó��,�Ǹűݾ��հ�)
   SELECT CID AS ��ǰ�ڵ�,
          CNAME AS ��ǰ��,
          C.BUY_NAME AS �ŷ�ó��,
          CSUM AS �Ǹűݾ��հ�
     FROM PROD A, BUYER C
    WHERE A.PROD_ID=(���� 3���� ��ǰ�� ��ǰ�ڵ�)
      AND A.PROD_BUYER=C.BUYER_ID
      
(��������: �Ǹűݾױ������� �Ǹ����� ����)     
   SELECT A.CART_PROD AS CID,
          B.PROD_NAME AS CNAME,
          SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
     FROM CART A, PROD B
    WHERE A.CART_PROD=B.PROD_ID
      AND CART_NO LIKE '202005%'
    GROUP BY A.CART_PROD,B.PROD_NAME
    ORDER BY 3 DESC;


(����)
   SELECT C.CID AS ��ǰ�ڵ�,
          C.CNAME AS ��ǰ��,
          B.BUYER_NAME AS �ŷ�ó��,
          C.CSUM AS �Ǹűݾ��հ�
     FROM PROD A, BUYER B, (SELECT A.CART_PROD AS CID,
                                   B.PROD_NAME AS CNAME,
                                   SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                              FROM CART A, PROD B
                             WHERE A.CART_PROD=B.PROD_ID
                               AND CART_NO LIKE '202005%'
                             GROUP BY A.CART_PROD,B.PROD_NAME
                             ORDER BY 3 DESC) C
    WHERE A.PROD_ID=C.CID
      AND A.PROD_BUYER=B.BUYER_ID
      AND ROWNUM<=3; 
   
��뿹) 2020�� ��ݱ⿡ ���žױ��� 1000���� �̻��� ������ ȸ��������
        ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ,ȸ����,����,���ž�,���ϸ���
        
(��������:ȸ������(ȸ����ȣ,ȸ����,����,���ž�,���ϸ���)��ȸ

  SELECT A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         A.MEM_JOB AS ����,
         B.*****���ž�,
         A.MEM_MILEAGE AS ���ϸ���
    FROM MEMBER A,
         (1000���� �̻� ����ȸ��)B
   WHERE A.MEM_ID=B.MEM      
          ����:2020�� ��ݱ⿡ ���žױ��� 1000���� �̻�)
          
 (��������)
     SELECT A.CART_MEMBER AS BID,
            SUM(A.CART_QTY*B.PROD_PRICE) AS BSUM
       FROM CART A, PROD B
      WHERE A.CART_PROD=B.PROD_ID
        AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006'
      GROUP BY A.CART_MEMBER
     HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=10000000
      ORDER BY 1;
      
  (����-INLINE VIEW ���) -- ������ ���� ����.
  SELECT A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         A.MEM_JOB AS ����,
         B.BSUM AS ���ž�,
         A.MEM_MILEAGE AS ���ϸ���
    FROM MEMBER A,
         (SELECT A.CART_MEMBER AS BID,
                 SUM(A.CART_QTY*B.PROD_PRICE) AS BSUM
            FROM CART A, PROD B
           WHERE A.CART_PROD=B.PROD_ID
             AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006'
           GROUP BY A.CART_MEMBER
          HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=10000000)B
   WHERE A.MEM_ID=B.BID
   ORDER BY 1;
   
 (����-��ø�������� ���)
  SELECT A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         A.MEM_JOB AS ����,
  --       B.BSUM AS ���ž�,
         A.MEM_MILEAGE AS ���ϸ���
    FROM MEMBER A
    WHERE A.MEM_ID IN(SELECT B.BID
                        FROM (SELECT A.CART_MEMBER AS BID,
                                     SUM(A.CART_QTY*B.PROD_PRICE) AS BSUM
                                FROM CART A, PROD B
                               WHERE A.CART_PROD=B.PROD_ID
                                 AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006'
                               GROUP BY A.CART_MEMBER
                              HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=10000000)B)
   ORDER BY 1;