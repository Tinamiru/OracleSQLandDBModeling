2022-0418-02)�� ��ȯ �Լ�
 - �Լ��� ���� ��ġ���� "�Ͻ������� ������Ÿ��"�� ���� ��ȯ��Ŵ -- "�Ͻ���"�߿�
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST�� ���� -- ���� ���̾��� ����
 1. CAST(expr AS type��)
   . 'expr'�� ����� ���� ������Ÿ���� 'type'���� ��ȯ
   
��뿹) SELECT 'ȫ�浿',
              CAST('ȫ�浿' AS CHAR(20)), -- ���ڿ� ����Ʈ�� VARCHAR2.
              CAST('20200418' AS DATE)
         FROM DUAL
 
 
 SELECT MAX(CAST(CART_NO AS NUMBER))+1
   FROM CART
  WHERE CART_NO LIKE '20200507%';