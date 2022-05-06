/* 2022-0506-01)

<�н���ǥ>
1. Cursor
2. Procedure
3. Function

���μ�����, �������� ����.

<PL/SQL> - (�������� ���ν��� ����ȭ�� ���� ���)
--����, �б�, �ȱ�, ���� - ����Ÿ(����Ÿ)

PL/SQL�� ����.

    Package(��Ű��)
    User(����� ���� �Լ�)
    Stored Procedure(���� ���ν���)
    Trigger(Ʈ����)
    Anonymous Block(�͸��� ���)

1. Cursor
  �������,
  �����ڰ� PL/SQL���� �������� �����.
*/ 
/
SET SERVEROUTPUT ON;
/
DECLARE
    -- SCALAR(�Ϲ�) ����
    V_BUY_PROD VARCHAR2(10);
    V_QTY NUMBER(10,0);
    -- 2020�⵵ ��ǰ�� ���Լ����� ��
    CURSOR CUR IS
    SELECT  BUY_PROD, SUM(BUY_QTY)
    FROM    BUYPROD
    WHERE   BUY_DATE LIKE '2020%'
    GROUP BY BUY_PROD
    ORDER BY 1 ASC;
BEGIN 
    -- �޸𸮸� �Ҵ�(�ö�) : ���ε�
    OPEN CUR; -- OPEN = CUR��� Ŀ���� �� �����ġ(�޸�)�� �ø���.
    --�����(��ġ, ������, ���)
    --���� ������ �̵�, ���� �����ϴ��� üũ����.
    --��
    FETCH CUR INTO V_BUY_PROD, V_QTY;
    --��(FOUND : ����������? / NOTFOUND : �����Ͱ� ���°�? / ROWCOUNT : ���� ��)
    WHILE(CUR%FOUND) LOOP
    DBMS_OUTPUT.PUT_LINE(V_BUY_PROD||', '||V_QTY); -- ���.
    FETCH CUR INTO V_BUY_PROD, V_QTY;
    END LOOP;    
    -- ������� �޸𸮸� ��ȯ.(�ʼ�) (Garbige�� ����)
    CLOSE CUR;
END;
/

-- ȸ�����̺��� ȸ����� ���ϸ����� ����غ��� 
-- ��, ������ '�ֺ�'�� ȸ���� ����ϰ� ȸ�������� �������� �����غ���.
-- ALIAS : MEM_NAME, MEM_MILEAGE
-- CUR �̸��� CURSOR�� �����ϰ� �͸������� ǥ��
DECLARE
    -- REFERANCE ����
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
CURSOR CUR(V_JOB VARCHAR2) IS
    SELECT  MEM_NAME, MEM_MILEAGE
    FROM    MEMBER
    WHERE   MEM_JOB = V_JOB -- �Ű����� ����.
    ORDER BY 1;
BEGIN
    OPEN CUR ('�л�'); -- �μ����� Ŀ���� �Ű�������.
    LOOP
        FETCH CUR INTO V_NAME, V_MILEAGE;
        EXIT WHEN CUR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||', '|| V_NAME||', '||V_MILEAGE);
    END LOOP;
    CLOSE CUR;
END;
/

-- ������ �Է¹޾� FOR LOOP�� �̿��ϴ� CURSOR
DECLARE
    CURSOR CUR(V_JOB VARCHAR2) IS
         SELECT  MEM_NAME, MEM_MILEAGE
         FROM    MEMBER
         WHERE   MEM_JOB = V_JOB -- �Ű����� ����.
         ORDER BY 1;
BEGIN
    -- FOR������ �ݺ��ϴ� ���� Ŀ���� �ڵ����� OPEN�ϰ�
    -- ������� ó���Ǹ� �ڵ����� Ŀ���� CLOSE��
    -- REC : �ڵ� ���� ������ ����
    FOR REC IN CUR('�л�') LOOP
        DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||
        ', '|| REC.MEM_NAME||', '||REC.MEM_MILEAGE);
    END LOOP;
END;
/

DECLARE

BEGIN
    -- FOR������ �ݺ��ϴ� ���� Ŀ���� �ڵ����� OPEN�ϰ�
    -- ������� ó���Ǹ� �ڵ����� Ŀ���� CLOSE��
    -- REC : �ڵ� ���� ������ ����
    FOR REC IN (SELECT  MEM_NAME, MEM_MILEAGE -- ���������� �����,
                FROM    MEMBER
                WHERE   MEM_JOB = '�л�'
                ORDER BY 1) LOOP
        DBMS_OUTPUT.PUT_LINE(REC.MEM_NAME||', '||REC.MEM_MILEAGE);
    END LOOP;
END;
/

-- CURSOR����
-- 2020�⵵ ȸ���� �Ǹűݾ�(�ǸŰ�(PROD_SALE) 
--                          * ���ż���(CART_QTY))�� �հ踦
-- CURSOR�� FOR���� ���� ����غ���
-- ALIAS: MEM_ID,MEM_NAME,SUM_AMT
-- ��¿��� : a001, ������, 2000
--            b001, �̻���, 1750
--            ...
\
DECLARE
    CURSOR CUR IS
        SELECT  A.MEM_ID, A.MEM_NAME, SUM(C.PROD_SALE*B.CART_QTY) AS SUM_AMT
        FROM    MEMBER A
        INNER JOIN CART B ON(A.MEM_ID=B.CART_MEMBER)
        INNER JOIN PROD C ON(B.CART_PROD=C.PROD_ID)
        WHERE SUBSTR(B.CART_NO,1,4)='2020'
        GROUP BY A.MEM_ID, A.MEM_NAME
        ORDER BY 1;
BEGIN
   FOR REC IN CUR LOOP
       IF MOD(CUR%ROWCOUNT,2) = 1 THEN
           DBMS_OUTPUT.PUT_LINE(CUR%ROWCOUNT||', '||
                                REC.MEM_ID  ||', '||
                                REC.MEM_NAME||', '||
                                REC.SUM_AMT);
       END IF;
   END LOOP;
END;
/

