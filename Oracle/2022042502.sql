2022-0425-02) �ܺ�����(OUTER JOIN)

  - �ڷ��� "����"�� ���� ���̺��� �������� �����ϴ� ����
  - �ڷᰡ ������ ���̺� NULL ���� �߰��Ͽ� ���� ����
  - �ܺ����� ������'(+)'�� �ڷᰡ �����ʿ� �߰�
  - �������� �� �ܺ������� �ʿ��� ��� ���ǿ� '(+)'�� ����ؾ���
  - ���ÿ� �� ���̺��� �ٸ� �� ���� ���̺�� �ܺ����ε� �� ����. ��, A,B,C
    ���̺��� �ܺ����ο� �����ϰ� A�� �������� B�� Ȯ��Ǿ� ���εǰ�, ���ÿ�
    C�� �������� B�� Ȯ��Ǵ� �ܺ������� ���ȵ�(A=B(+) AND C=B(+), ��ȣ�� �߻�.)
  - �Ϲ����ǰ� �ܺ����������� ���ÿ� �����ϴ� �ܺ������� �������ΰ����
    ��ȯ�� => ANSI�ܺ������̳� ���������� �ذ�

    -- ���� �ܺ����δ�� ���տ����ڸ� ����Ѵٰ��Ѵ�. (���տ����ڴ� ���̾��δ�)
    
  (�Ϲݿܺ����� �������)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2][,...]
   WHERE ��������(+);
          :
          
  (ANSI �ܺ����� �������)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1]
   LEFT|RIGHT|FULL OUTER JOIN ���̺��2 [��Ī] ON(�������� [AND �Ϲ�����])
          :
   [WHERE �Ϲ�����];
    . LEFT : FROM���� ����� ���̺��� �ڷ��� ������ JOIN���� ���̺��� �ڷẸ�� ���� ���
    . RIGHT : FROM���� ����� ���̺��� �ڷ��� ������ JOIN���� ���̺��� �ڷẸ�� ���� ���
    . FULL : FROM���� ����� ���̺�� JOIN���� ���̺��� �ڷᰡ ���� ������ ���
    
    
��뿹)��ǰ���̺��� ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�

   SELECT DISTINCT PROD_LGU
     FROM PROD;
          
   SELECT LPROD_GU AS �з��ڵ�,
          COUNT(PROD_ID) AS "�з��� ��ǰ�� ��" -- *�� ����ϸ� �ΰ��� �ٵ� ��1�� �νĵȴ�.
     FROM LPROD A, PROD B
    WHERE A.LPROD_GU=B.PROD_LGU(+) 
    GROUP BY LPROD_GU
    ORDER BY 1;
    
��뿹)������̺��� ��� �μ��� ������� ��ձ޿��� ��ȸ�Ͻÿ�
       ��, ��ձ޿��� ������ ����Ұ�.
   SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
          B.DEPARTMENT_NAME AS �μ���,
          COUNT(A.EMPLOYEE_ID) AS �����,
          NVL(ROUND(AVG(A.SALARY)),0) AS ��ձ޿�
     FROM HR.employees A, HR.departments B
    WHERE A.DEPARTMENT_ID(+)=B.DEPARTMENT_ID
    GROUP BY B.DEPARTMENT_ID,B.DEPARTMENT_NAME
    ORDER BY 1;
       
   SELECT COUNT(hr.departments.department_id) AS �μ���
     FROM HR.DEPARTMENTS;
     
   SELECT NVL(B.DEPARTMENT_ID,0) AS �μ��ڵ�,
          NVL(B.DEPARTMENT_NAME,'BOSS') AS �μ���,
          COUNT(A.EMPLOYEE_ID) AS �����,
          NVL(ROUND(AVG(A.SALARY)),0) AS ��ձ޿�
     FROM HR.employees A
     FULL OUTER JOIN HR.departments B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
    GROUP BY B.DEPARTMENT_ID,B.DEPARTMENT_NAME
    ORDER BY 1;

��뿹)��ٱ������̺��� 2020�� 6�� ���ȸ���� �����հ踦 ���Ͻÿ�
  
  (�Ϲ����� ��뿹)
   -- �Ϲ� �ܺ������� �Ѱ�
    SELECT C.MEM_ID AS ȸ����ȣ,
           C.MEM_NAME AS ȸ����, 
           SUM(A.CART_QTY*B.PROD_PRICE) AS ���űݾ��հ�
      FROM CART A, PROD B, MEMBER C
     WHERE A.CART_PROD=B.PROD_ID
       AND C.MEM_ID=A.CART_MEMBER(+)
       AND A.CART_NO LIKE '202006%'
     GROUP BY C.MEM_ID,C.MEM_NAME
     ORDER BY 1;

   
    
  (ANSI JOIN ��뿹)
    SELECT C.MEM_ID AS ȸ���ڵ�,
           C.MEM_NAME AS ȸ����,
           NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS ���űݾ��հ�
      FROM CART A
      LEFT OUTER JOIN PROD B ON(A.CART_PROD=B.PROD_ID AND A.CART_NO LIKE '202006%')
     RIGHT OUTER JOIN MEMBER C ON(C.MEM_ID=CART_MEMBER)
     GROUP BY C.MEM_ID,C.MEM_NAME
     ORDER BY 1;
     
     SELECT CART_MEMBER AS ȸ���ڵ�,
            SUM(CART_QTY) AS �����հ�
       FROM CART
      GROUP BY CART_MEMBER;
      ORDER BY 1;
      
  (��������)
    �������� : 2020�� 6�� ȸ���� �Ǹ����� -- ��ΰ� ����.=��������
    SELECT A.CART_MEMBER AS CID,
           SUM(A.CART_QTY * B.PROD_PRICE) AS ASUM
      FROM CART A, PROD B
     WHERE A.CART_PROD=B.PROD_ID
       AND A.CART_NO LIKE '202006%'
     GROUP BY A.CART_MEMBER
     ORDER BY 1;
     
     
    �������� : �������� ����� MEMBER ���̿� �ܺ�����.
    SELECT TB.MEM_ID AS ȸ����ȣ,
           TB.MEM_NAME AS ȸ����,
           NVL(TA.ASUM,0) AS ���űݾ��հ�
      FROM (SELECT A.CART_MEMBER AS AID,
                   SUM(A.CART_QTY * B.PROD_PRICE) AS ASUM
              FROM CART A, PROD B
             WHERE A.CART_PROD=B.PROD_ID
               AND A.CART_NO LIKE '202006%'
             GROUP BY A.CART_MEMBER
             ORDER BY 1) TA
     RIGHT OUTER JOIN MEMBER TB ON(TA.AID=TB.MEM_ID)
     ORDER BY 1;
             
    
    SELECT TB.MEM_ID AS ȸ����ȣ,
           TB.MEM_NAME AS ȸ����,
           NVL(TA.ASUM,0) AS ���űݾ��հ�
      FROM (SELECT A.CART_MEMBER AS AID,
                   SUM(A.CART_QTY * B.PROD_PRICE) AS ASUM
              FROM CART A, PROD B
             WHERE A.CART_PROD=B.PROD_ID
               AND A.CART_NO LIKE '202006%'
             GROUP BY A.CART_MEMBER
             ORDER BY 1) TA,
           MEMBER TB
     WHERE TA.AID(+)=TB.MEM_ID
     ORDER BY 1;
    
    
             
    SELECT C.MEM_ID AS ȸ���ڵ�,
           C.MEM_NAME AS ȸ����,
           NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS ���űݾ��հ�
      FROM CART A
      LEFT OUTER JOIN PROD B ON(A.CART_PROD=B.PROD_ID AND A.CART_NO LIKE '202006%')
     RIGHT OUTER JOIN MEMBER C ON(C.MEM_ID=CART_MEMBER)
     GROUP BY C.MEM_ID,C.MEM_NAME
     ORDER BY 1;