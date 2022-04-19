2022-0418-02)�� ��ȯ �Լ�
 - �Լ��� ���� ��ġ���� "�Ͻ������� ������Ÿ��"�� ���� ��ȯ��Ŵ -- "�Ͻ���"�߿�
 - TO_CHAR, TO_DATE, TO_NUMBER, CAST�� ���� -- ���� ���̾��� ����
 1) CAST(expr AS type��)
   . 'expr'�� ����� ���� ������Ÿ���� 'type'���� ��ȯ
   
��뿹) SELECT 'ȫ�浿',
              CAST('ȫ�浿' AS CHAR(20)), -- ���ڿ� ����Ʈ�� VARCHAR2.
              CAST('20200418' AS DATE)
         FROM DUAL
 
 
 SELECT MAX(CAST(CART_NO AS NUMBER))+1
   FROM CART
  WHERE CART_NO LIKE '20200507%';
  
  2) TO_CHAR(c), TO_CHAR(d | n [,fmt]) -- ��������, ��뷮�� ��쿡 ��ȯ�ϴ� ��찡 �ִ�.
    - �־��� ���ڿ��� ���ڿ��� ��ȯ(��, c�� Ÿ���� CHAR or CLOB�� ���
      VARCHAR2�� ��ȯ�ϴ� ��츸 ���
    - �־��� ��¥(d) �Ǵ� ����(n)�� ���ǵ� ����(fmt)���� ��ȯ
    - ��¥���� ���Ĺ���
------------------------------------------------------------------
 FORMAT����          �ǹ�        ��뿹
------------------------------------------------------------------
    AD, BD           ����         SELECT TO_CHAR(SYSDATE, 'AD') FROM DUAL;
    CC, YEAR         ����, �⵵    SELECT TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;
    YYYY,YYY,YY,Y    �⵵         SELECT TO_CHAR(SYSDATE, 'YYYY YYY YY Y') FROM DUAL;
    Q                �б�         SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
    MM, RM           ��           SELECT TO_CHAR(SYSDATE, 'YY:MM:RM') FROM DUAL;                                        
    MOUTH MON        ��           SELECT TO_CHAR(SYSDATE, 'YY:MONTH MON') DUAL;                                        
    W, WW, IW        ����         SELECT TO_CHAR(SYSDATE, 'W WW IW') FROM DUAL;
    DD,DDD,J         ����         SELECT TO_CHAR(SYSDATE, 'DD DDD J') FROM DUAL; -- õ���п����� J(�ٸ����)�� ���� ����Ѵ�
    DAY, DY, D       ����         SELECT TO_CHAR(SYSDATE, 'DAY DY D') FROM DUAL;
    AM, PM           ����/����     SELECT TO_CHAR(SYSDATE, 'AM A.M.') FROM DUAL;
    A.M.,P.M.                     
    HH,HH12,HH24     �ð�         SELECT TO_CHAR(SYSDATE, 'HH HH12 HH24') FROM DUAL;
    MI               ��           SELECT TO_CHAR(SYSDATE, 'HH24:MI') FROM DUAL;  
    SS,SSSSS         ��           SELECT TO_CHAR(SYSDATE, 'HH:MI:SS SSSSS') FROM DUAL;  
     "���ڿ�"         ���������    SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') FROM DUAL;
                     
------------------------------------------------------------------
 FORMAT����          �ǹ�        
------------------------------------------------------------------
    9               ��������� �ڸ�����,��ȿ������ ��� ���ڸ� ����ϰ� ��ȿ�� 0�� ��� ����ó�� -- 9��0 �Ѵ� �Ҽ��� ���ϴ� 0���� ��µȴ�.
    0               ��������� �ڸ�����,��ȿ������ ��� ���ڸ� ����ϰ� ��ȿ�� 0�� ��� 0�� ���
    $, L            ȭ���ȣ ��� -- �ý��� ������ ��ȭ(ȭ��)��ȣ�� ǥ��ȴ�.
    PR              �����ڷᰡ ������ ���"-" ��ȣ ��� "< >"�ȿ� ���ڰ� ���
    ,(Comma)        3�ڸ������� �ڸ��� ���
    .(Dot)          �Ҽ��� ���
-----------------------------------------------------------------------------------
��뿹)
  SELECT TO_CHAR(12345,'999999'),
         TO_CHAR(12345,'999,999.99'),
         TO_CHAR(12345.786,'000,000.0'),
         TO_CHAR(12345,'0,000,000'),
         TO_CHAR(-12345,'999999PR'),
         TO_CHAR(12345,'L999999'),
         TO_CHAR(12345,'$999999')
    FROM DUAL;
    
  3) TO_NUMBER(c[,fmt])
   - �־��� ���ڿ� �ڷ� c�� fmt ������ ���ڷ� ��ȯ
     
��뿹) -- �������� ���� ������ ����ϴ� ���̶� �����ϸ� �ȴ�.
  SELECT --TO_NUMBER('12,345'), -- ,(Comma)�� ���ڰ� �ƴϴ�.
         TO_NUMBER('12345') AS "fmt ����",
         TO_NUMBER('12,345','99,999') AS "�޸��� ��",
         TO_NUMBER('<1234>','9999PR') AS ����,
         TO_NUMBER('$12,234.00','$99,999.99')*1100 AS �޷�����
    FROM DUAL;
    
  3) TO_DATE(c[,fmt])
   - �־��� ���ڿ� �ڷ� c�� fmt ������ ��¥ �ڷ�� ��ȯ
   
��뿹)
  SELECT TO_DATE('20220405'),
         TO_DATE('220405','YYMMDD')
    FROM DUAL;