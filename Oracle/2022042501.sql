2022-0425-01)

��뿹)2020�� ��ݱ� �ŷ�ó�� �Ǹž����踦 ���Ͻÿ�
       Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,�Ǹž��հ�
    
  SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
         A.BUYER_NAME AS �ŷ�ó��,
         SUM(C.CART_QTY*B.PROD_PRICE)�Ǹž��հ�
    FROM BUYER A, PROD B, CART C
   WHERE A.BUYER_ID=B.PROD_BUYER AND B.PROD_ID=C.CART_PROD
     AND SUBSTR(C.CART_NO,1,6) BETWEEN '202001' AND '202006'
   GROUP BY A.BUYER_ID, A.BUYER_NAME
   ORDER BY 1;
   
   
 -- INNER JOIN ��뿹   
  SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
         A.BUYER_NAME AS �ŷ�ó��,
         SUM(C.CART_QTY*B.PROD_PRICE)�Ǹž��հ�
    FROM BUYER A
   INNER JOIN PROD B ON (A.BUYER_ID=B.PROD_BUYER)
   INNER JOIN CART C ON (B.PROD_ID=C.CART_PROD)
   WHERE SUBSTR(C.CART_NO,1,8) BETWEEN TO_DATE('20200101') AND TO_DATE('20200601')
   GROUP BY A.BUYER_ID, A.BUYER_NAME
   ORDER BY 1;
   

��뿹) HR�������� �̱� �̿��� ������ ��ġ�� �μ��� �ٹ��ϴ� �����ȸ�Ͻÿ�
        Alias�� �����ȣ, �����,�μ���,�����ڵ�,�ٹ����ּ�
        �̱��� �����ڵ�� 'US'�̴�

    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.JOB_ID AS �����ڵ�,
           C.STREET_ADDRESS||' '||C.CITY||', '||C.STATE_PROVINCE||', '||
           C.POSTAL_CODE||', '||C.COUNTRY_ID AS �ٹ����ּ�
      FROM HR.employees A, HR.departments B, HR.locations C
     WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
       AND B.LOCATION_ID=C.LOCATION_ID
       AND C.COUNTRY_ID!='US'
     ORDER BY 1;
     
 -- INNER JOIN ��뿹
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           B.DEPARTMENT_NAME AS �μ���,
           A.JOB_ID AS �����ڵ�,
           C.STREET_ADDRESS||' '||C.CITY||', '||C.STATE_PROVINCE||', '||
           C.POSTAL_CODE||', '||C.COUNTRY_ID AS �ٹ����ּ�
      FROM HR.employees A
     INNER JOIN HR.departments B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
     INNER JOIN HR.locations C ON(B.LOCATION_ID=C.LOCATION_ID)
     WHERE C.COUNTRY_ID!='US'
     ORDER BY 1;
         
��뿹)2020�� 4�� �ŷ�ó�� ���Աݾ��� ��ȸ�Ͻÿ�.
       Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,���Աݾ��հ�
       
   SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
          A.BUYER_NAME AS �ŷ�ó��,
          SUM(C.BUY_COST*C.BUY_QTY) AS ���Աݾ��հ�
     FROM BUYER A, PROD B, BUYPROD C
    WHERE A.BUYER_ID=B.PROD_BUYER
      AND C.BUY_PROD=B.PROD_ID
      AND A.BUY_DATE BETWEEN '20200401' AND '20200430'
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
    
    --ANCI JOIN
    
   SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
          A.BUYER_NAME AS �ŷ�ó��,
          SUM(C.BUY_COST*C.BUY_QTY) AS ���Աݾ��հ�
     FROM BUYER A 
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN BUYPROD C ON(C.BUY_PROD=B.PROD_ID)
    WHERE C.BUY_DATE BETWEEN '20200401' AND '20200430'
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
       
��뿹)2020�� 4�� �ŷ�ó�� ����ݾ��� ��ȸ�Ͻÿ�.
       Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,����ݾ��հ�
       
   SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
          A.BUYER_NAME AS �ŷ�ó��,
          SUM(B.PROD_PRICE*C.CART_QTY) AS ����ݾ��հ�
     FROM BUYER A, PROD B, CART C
    WHERE A.BUYER_ID=B.PROD_BUYER
      AND C.CART_PROD=B.PROD_ID
      AND SUBSTR(CART_NO,1,6) LIKE '202004%'
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
    
-- ANCI JOIN

   SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
          A.BUYER_NAME AS �ŷ�ó��,
          SUM(B.PROD_PRICE*C.CART_QTY) AS ����ݾ��հ�
     FROM BUYER A
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN CART C ON(C.CART_PROD=B.PROD_ID AND SUBSTR(CART_NO,1,6) LIKE '202004%')
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
       
       
��뿹)2020�� 4�� �ŷ�ó�� ����/����ݾ��� ��ȸ�Ͻÿ�.
       Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,���Աݾ��հ�,����ݾ��հ�
       
/*   SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
          A.BUYER_NAME AS �ŷ�ó��,
          SUM(B.PROD_COST*C.BUY_QTY) AS ���Աݾ��հ�,
          SUM(B.PROD_PRICE*D.CART_QTY) AS ����ݾ��հ�
     FROM BUYER A, PROD B, BUYPROD C, CART D
    WHERE A.BUYER_ID=B.PROD_BUYER
      AND C.BUY_PROD=B.PROD_ID
      AND D.CART_PROD=B.PROD_ID
      
      AND C.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
      AND SUBSTR(D.CART_NO,1,6) LIKE '202004%'
      
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
    
    
   SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
          A.BUYER_NAME AS �ŷ�ó��,
          SUM(C.BUY_COST*C.BUY_QTY) AS ���Աݾ��հ�,
          SUM(B.PROD_PRICE*D.CART_QTY) AS ����ݾ��հ�
     FROM BUYER A
    INNER JOIN PROD B ON(A.BUYER_ID=B.PROD_BUYER)
    INNER JOIN BUYPROD C ON(C.BUY_PROD=B.PROD_ID
               AND C.BUY_DATE BETWEEN '20200401' AND '20200430')
    INNER JOIN CART D ON (D.CART_PROD=B.PROD_ID
               AND SUBSTR(D.CART_NO,1,8) BETWEEN '20200401' AND '20200430')
    GROUP BY A.BUYER_ID,A.BUYER_NAME
    ORDER BY 1;
*/
   
    -- ���������� �ܺ������� ���� ����Ѵ�.
   
   SELECT TB.CID AS �ŷ�ó�ڵ�,  -- �����÷��� �����Ѵٸ� �������� ����ؾ��Ѵ�. 
          TB.CNAME AS �ŷ�ó��,
          NVL(TA.BSUM,0) AS ���Աݾ��հ�,
          NVL(TB.CSUM,0) AS ����ݾ��հ�
     FROM (SELECT A.BUYER_ID AS BID, -- TA.BID�� ������ ������ �ΰ��� �߻���.
                  SUM(C.BUY_COST*C.BUY_QTY) AS BSUM
             FROM BUYER A, PROD B, BUYPROD C
            WHERE A.BUYER_ID=B.PROD_BUYER
              AND C.BUY_PROD=B.PROD_ID
              AND C.BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200430')
            GROUP BY A.BUYER_ID) TA,
          (SELECT A.BUYER_ID AS CID,
                  A.BUYER_NAME AS CNAME,
                  SUM(B.PROD_PRICE*C.CART_QTY) AS CSUM
             FROM BUYER A, PROD B, CART C
            WHERE A.BUYER_ID=B.PROD_BUYER
              AND C.CART_PROD=B.PROD_ID
              AND SUBSTR(C.CART_NO,1,6) LIKE '202004%'
            GROUP BY A.BUYER_ID,A.BUYER_NAME) TB            
    WHERE TA.BID(+)=TB.CID -- �ܺ���������. TA�ڷḦ TB�� �°� Ȯ��.((+)) 
    ORDER BY 1;
    
    -- ���ΰ� ���������� ���� ���� ����.
 
 
    
 -- Non Equi-JOIN
   
��뿹)������̺��� ��ü����� ��ձ޿����� �� ���� �޿��� �޴� �����
       ��ȸ�Ͻÿ�.
       Alias�� �����ȣ,�����,�μ��ڵ�,�޿�
       
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.DEPARTMENT_ID AS �μ��ڵ�,
          A.SALARY AS �޿�
     FROM HR.employees A,
          (SELECT AVG(SALARY) AS BSAL
             FROM HR.EMPLOYEES) B
    WHERE A.SALARY>B.BSAL; -- Non Equi-JOIN�� Ư¡(������)
    ORDER BY 3;
    
    
    -- �μ������ ����� ���
    
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.DEPARTMENT_ID AS �μ��ڵ�,
          C.DEPARTMENT_NAME AS �μ���,
          A.SALARY AS �޿�
     FROM HR.employees A,
          (SELECT AVG(SALARY) AS BSAL
             FROM HR.EMPLOYEES) B,
          HR.departments C
    WHERE A.SALARY>B.BSAL
      AND A.DEPARTMENT_ID=C.DEPARTMENT_ID
    ORDER BY 3;
            
   