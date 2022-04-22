2022-0422-01)TABLE JOIN
  - ������ DB�� ���� �ٽɱ�� -- RDBS
  - �������� ���̺� ���̿� �����ϴ� ���踦 �̿��� ����
  - ����ȭ�� �����ϸ� ���̺��� ���ҵǰ� �ʿ��� �ڷᰡ �������� ���̺�
    �л� ����� ��� ����ϴ� ����
  - Join�� ����
   . �Ϲ����� VS ANSI JOIN -- ANSI ȸ�翡�� ����Ŭ �Ӹ� �ƴ϶� MY/SQL������ ���α׷����� ���������� ��� ������ JOIN�� ����.(����ǥ��)
   . INNER JOIN VS OUTER JOIN
   . Equi-JOIN VS Non Equi-JOIN -- =������ ��� ������ ������ Equi-Join�̶���Ѵ�.
   . ��Ÿ(Cartestian Product, Self Join,...etc)
  - �������(�Ϲ� ����)
    SELECT �÷�list
      FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2][,���̺��3 [��Ī3],...]
     WHERE ��������
      [AND �Ϲ�����]
    . ���̺� ��Ī�� �������� ���̺� ������ �÷����� �����ϰ� �ش� �÷��� �����ϴ�
      ��� �ݵ�� ���Ǿ�� �Ѵ�.
    . ���Ǵ� ���̺��� n�� �϶� ���������� ��� n-1�� �̻��̾�� �� -- WHERE ���� �Ұ�. Cartestian Product ����.
    . ���������� �����̺� ����


1. Cartestian Product -- ���� �ʿ��Ҷ��� �ƴѰ�� ����ؼ� �ȵȴ�.
  - ���������� ���ų� ���������� �߸��� ��� �߻�
  - �־��� ���(���������� ���� ���) A���̺�(a�� b��)�� B���̺�(c�� d��)�� 
    Cartestian Product�� �����ϸ� ����� a*c��, b+d���� ��ȯ�Ѵ�
  - ANSI������ CROSS JOIN�̶�� �ϸ� �ݵ�� �ʿ��� ��찡 �ƴϸ� �������� ���ƾ��ϴ� JOIN�̴�.
    
    (������� - �Ϲ�����)
    SELECT �÷�list
      FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2][,���̺��3 [��Ī3],...]
      
    (������� - ANSI����)
    SELECT �÷�list
      FROM ���̺��1 [��Ī1]
     CROSS JOIN ���̺��2;

��뿹)
    SELECT COUNT(*)
      FROM PROD;
      
    SELECT COUNT(*)
      FROM PROD A, CART B;
      
    SELECT COUNT(*)
      FROM BUYPROD;

    SELECT COUNT(*)
      FROM PROD A, CART B, BUYPROD C;
    
    SELECT COUNT(*)
      FROM PROD A
     CROSS JOIN CART B
     CROSS JOIN BUYPROD C;
      
   
2. Equi JOIN -- ��κ���(95~%) ���Ǵ� ����
  - �������ǿ� '='�����ڰ� ���� �������� ��κ��� ������ �̿� ���Եȴ�
  - �������� ���̺� �����ϴ� ������ �÷����� ��� �򰡿� ���� ����
  (�Ϲ� ���� �������)
  SELECT �÷�List
    FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2 [,���̺�3 ��Ī3,...]
   WHERE ��������
   
  (ANSI ���� �������)
  SELECT �÷�List
    FROM ���̺�1 ��Ī1 -- ANSI Ư¡. FROM���� ���̺��� �ϳ��� ����.
   INNER JOIN ���̺�2 ��Ī2 ON(�������� [AND �Ϲ�����])
  [INNER JOIN ���̺�3 ��Ī3 ON(�������� [AND �Ϲ�����])
             :
  [WHERE �Ϲ�����]
    . 'AND �Ϲ�����' : ON ���� ����� �Ϲ������� �ش� INNER JOIN ���� ���� 
      ���ο� �����ϴ� ���̺� ���ѵ� ����
    . 'WHERE �Ϲ�����' : ��� ���̺� ����Ǿ�� �ϴ� ���Ǳ��.
    
��뿹)2020�� 1�� ��ǰ�� �������踦 ��ȸ�Ͻÿ�
       Alias�� ��ǰ�ڵ�,��ǰ��,���Աݾ��հ��̸� ��ǰ�ڵ������ ���.

 (�Ϲ�����)
  SELECT A.BUY_PROD AS ��ǰ�ڵ�, -- �����̸Ӹ�Ű �������Ἲ.
         B.PROD_NAME AS ��ǰ��,
         SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ��հ�
    FROM BUYPROD A,PROD B 
   WHERE A.BUY_PROD=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY A.BUY_PROD,B.PROD_NAME
   ORDER BY 1;
    
 (ANSI JOIN)
  SELECT A.BUY_PROD AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ��հ�
    FROM BUYPROD A
   INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID
         AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')) -- [AND �Ϲ�����] ���� �� WHERE�� ���԰���
   GROUP BY A.BUY_PROD,B.PROD_NAME
   ORDER BY 1; 
 
 (ANSI JOIN) 
  SELECT A.BUY_PROD AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         SUM(A.BUY_QTY * B.PROD_COST) AS ���Աݾ��հ�
    FROM BUYPROD A
   INNER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
   WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY A.BUY_PROD,B.PROD_NAME
   ORDER BY 1;  
   
   
��뿹) ��ǰ���̺��� �ǸŰ��� 50�����̻��� ��ǰ�� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ�,��ǰ��,�з���,�ŷ�ó��,�ǸŰ����̰�
        �ǸŰ����� ū ��ǰ������ ����Ͻÿ�...


 (INNER JOIN) 
   SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         B.LPROD_NM AS �з���,
         C.BUYER_NAME AS �ŷ�ó��,
         A.PROD_PRICE AS �ǸŰ���
    FROM PROD A, LPROD B , BUYER C
   WHERE A.PROD_LGU=B.LPROD_GU
     AND A.PROD_BUYER=C.BUYER_ID
     AND A.PROD_PRICE>=500000
   ORDER BY 5 DESC;

 (ANSI JOIN) 
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         B.LPROD_NM AS �з���,
         C.BUYER_NAME AS �ŷ�ó��,
         A.PROD_PRICE AS �ǸŰ���
    FROM PROD A
   INNER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)
   INNER JOIN BUYER C ON(A.PROD_BUYER=C.BUYER_ID)
   WHERE A.PROD_PRICE>=500000
   ORDER BY 5 DESC;
   
��뿹)2020�� ��ݱ� �ŷ�ó�� �Ǹž����踦 ���Ͻÿ�
       Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,�Ǹž��հ�
    
  SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
         A.BUYER_NAME AS �ŷ�ó��,
         SUM(C.CART_QTY*B.PROD_PRICE)�Ǹž��հ�
    FROM BUYER A, PROD B, CART C
   WHERE A.BUYER_ID=B.PROD_BUYER AND B.PROD_ID=C.CART_PROD
     AND SUBSTR(C.CART_NO,1,8) BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
   GROUP BY A.BUYER_ID, A.BUYER_NAME
   ORDER BY 1;
   
   
   
   
   
   
   
   
   
   
   
   
  