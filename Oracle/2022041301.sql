2022-0413-01)�Լ�
 - ��� ����ڵ��� ������ �������� ����ϵ��� �̸� ���α׷��ֵǾ�
   �������� �� ���� ������ ���·� ����� ���
 - ���ڿ�, ����, ��¥, ����ȯ, ����(�׷�)�Լ��� ����
 
 
1. ���ڿ��Լ�
 1)CONCAT(c1,c2) 
  - �־��� �� ���ڿ� c1�� c2�� �����Ͽ� ���ο� ���ڿ��� ��ȯ 
  -- c1�� c2���̿� ���ڸ� �����Ұ�� 2������ �������� �ϱ⶧���� '||'�� ����ϴ°��� ȿ�����̴�.
  - ���ڿ� ���� ������ '||'�� ���� ��� -- ||�� �Ȱ��� �����Ѵ�.
 (��뿹)ȸ�����̺��� 2000�� ���� ����� ȸ�������� ��ȸ�Ͻÿ�
        Alias�� ȸ����ȣ,ȸ����,�ֹι�ȣ,�ּ��̴�.
        �ֹι�ȣ�� xxxxxx-xxxxxxx�������� �ּҴ� �⺻�ּҿ� ���ּҰ�
        ���� �ϳ��� �߰��Ͽ� �����Ұ�
   SELECT MEM_ID AS ȸ����ȣ,
          MEM_NAME AS ȸ����,
          CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS �ֹι�ȣ, -- CONCAT ��뿹
          MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ, -- '||' ��뿹
          MEM_ADD1||' '||MEM_ADD2 AS �ּ�
     FROM MEMBER 
    WHERE SUBSTR(MEM_REGNO2,1,1) IN('3','4');
    
    
 2) LOWER(c1), UPPER(c1), INITCAP(c1)
    LOWER(c1) : �־��� ���ڿ� c1�� ���ڸ� ��� �ҹ��ڷ� ��ȯ
    UPPER(c1) : �־��� ���ڿ� c1�� ���ڸ� ��� �빮�ڷ� ��ȯ
    INITCAP(c1) : c1 ���� ���� �� �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ
  ��뿹)ȸ�����̺��� ȸ����ȣ 'F001'ȸ���� ������ ��ȸ�Ͻÿ�
        Alias�� ȸ����ȣ,ȸ����,�ּ�,���ϸ����̴�.
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_ADD1 ||' '|| MEM_ADD2 AS �ּ�,
           MEM_MILEAGE AS ���ϸ���    
      FROM MEMBER
     WHERE UPPER(MEM_ID)='F001';
     
    SELECT EMPLOYEE_ID,
           LOWER(FIRST_NAME)||' '||LOWER(LAST_NAME),
           LOWER(FIRST_NAME)||' '||(LAST_NAME),
           INITCAP(LOWER(FIRST_NAME||' '||LAST_NAME)),
           EMP_NAME
      FROM HR.employees;
      
  3) LPAD(c1,n[,c2]),RPAD(c1,n[,c2])
    . LPAD(c1,n[,c2]): n�� �ڸ��� �־��� ���ڿ� c1�� ä��� ���� ���ʰ����� -- ������� ���ʿ� �α⿡ ������ ����
      c2 ���ڿ��� ä��, c2�� �����Ǹ� ������ ä����
    . RPAD(c1,n[,c2]): n�� �ڸ��� �־��� ���ڿ� c1�� ä��� ���� �����ʰ����� -- ������� �����ʿ� �α⿡ ���� ����
      c2 ���ڿ��� ä��, c2�� �����Ǹ� ������ ä����
   ��뿹)
     SELECT '1,000,000',
            LPAD('1,000,000','15','*'),
            RPAD('1,000,000','15','*')
       FROM DUAL;
     
/*
     SELECT A.CART_PROD,
            B.PROD_NAME,
            A.CART_QTY*B.PROD_PRICE
       FROM CART A,PROD=B.PROD;
*/
       
 ��뿹) �Ⱓ(��� ��)�� �Է¹޾� ����� ���� ���� 5�� ��ǰ�� �������踦 ���ϴ� ���ν����� �ۼ��Ͻÿ�
/*
      CREATE OR REPLACE PROCEDURE PROC_CALCULATE(
       P_PERIOD VARCHAR2)
    IS
      CURSOR CUR_TOP5 IS
       SELECT TA.CID AS TID, TA.CSUM AS TSUM
         FROM (SELECT A.CART_PROD AS CID,
                      SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                 FROM CART A, PROD B
                WHERE A.CART_PROD=B.PROD_ID
                  AND A.CART_NO LIKE P_PERIOD||'%'
                GROUP BY A.CART_PROD
                ORDER BY 2 DESC) TA
        WHERE ROWNUM<=5;
      V_PNAME PROD.PROD_NAME%TYPE;
      V_RES VARCHAR2(100); 
   BEGIN
     FOR REC IN CUR_TOP5 LOOP
       SELECT PROD_NAME INTO V_PNAME
         FROM PROD
        WHERE PROD_ID=REC.TID;
        VRES:=REC.TID||'  '||RPAD(V_PNAME,30)|| TO_CHAR(REC.TSUM,'99,999,999');
        DBMS_OUTPUT.PUT_LINE(V_RES);
     END LOOP;
   END;
   
   EXECUTE PROC_CALCULATE('202007');
*/


  4) LTRIM(c1 [,c2]), RTRIM(c1 [,c2]) -- �����̳� �����ʿ��� �����Ͽ� ������ ���ڿ��� �����ϴ� �Լ�
   - LTRIM(c1 [,c2]): c1 ���ڿ��� ���� ������ġ���� c2���ڿ��� ã��
     ���� ���ڿ��� ������ ����, c2�� �����Ǹ� ���� ������ ����
   - RTRIM(c1 [,c2]): c1 ���ڿ��� ������ ������ġ���� c2���ڿ��� ã��
     ���� ���ڿ��� ������ ����, c2�� �����Ǹ� ������ ������ ����
  (��뿹)
   SELECT LTRIM('PERSIMMON BANANA APPLE','ER'), -- ER�� ���̻��������� ER�� �������� �ʾ� �״��.
          LTRIM('PERSIMMON BANANA APPLE','PE'), -- PE����
          LTRIM('   PERSIMMON BANANA APPLE') -- ��������
     FROM DUAL;

  SELECT RTRIM('...ORACLE...','.'),
         RTRIM('ASDR...OR...OR...','OR...'), -- OR�� ��� �Էµȵ޺κ� ...���� ��������.
         RTRIM('...         ') AS C -- c2�Է��� ���Ұ�� ������ ��������.
    FROM DUAL;
    
    
 5) TRIM(c1)
  - c1���ڿ� ���ʰ� �����ʿ� �ִ� ��� ������ ����
  - �ٸ� ���ڿ� ������ ������ �������� ���Ѵ�.(REPLACE�� ����) -- ��ȿ���鸸 ����. ��ȿ������ REPLACE �Լ��� ���Ű���.
 
  (��뿹)
    SELECT TRIM('   QWER   '), -- �̷��� ������ ��ȿ �����̴�.
           TRIM('   ����ȭ ���� �Ǿ����ϴ�!!   ') --�̷��� ������ ������ ��ȿ �����̶��Ѵ�.
      FROM DUAL;

  (��뿹)������ 2020�� 4�� 1���̶�� �Ҷ� ��ٱ������̺��� -- ������ ������ ���� 3���� ��ȣ�� �̹� ������.
         ��ٱ��Ϲ�ȣ(CART_NO)�� �����Ͻÿ�. -- DATE+5�ڸ��� ��

-- SYS��¥�� 2020�� 4�� 1�Ϸ� �����ϰ� �۾��Ͽ�����.
    SELECT TO_CHAR(SYSDATE,'YYYYMMDD')|| 
           TRIM(TO_CHAR(MAX(TO_NUMBER(SUBSTR(CART_NO,9))) + 1,'00000')) AS ����ȯ, -- SUBSTR�Լ����� �������� �ڿ� ��(����)�� �����ϸ� ������ �����ȴ�.
           MAX(CART_NO)+1 AS �ڵ�����ȯȰ�� -- ����Ŭ�� �ڹٿ� �޸� ���ڿ�+ANYŸ���϶� �������ַ� �ٲ��.
      FROM CART
     WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%';


 6) SUBSTR(c,m[,n]) -- ���� ���� ���̴� ���ڿ� �Լ�
  - �־��� ���ڿ� c�� m��°���� n���� ���ڿ��� �����Ͽ� ��ȯ.
  - n�� �����Ǹ� m��°�������� ������ ��� ���ڿ��� �����Ͽ� ��ȯ.
  - m�� 1���� ������(0�� ����Ǹ� 1�� ����) -- ����Ŭ�� �ڹٿ� �޸� 0�� �ƴ� 1���� ����
  - m�� �����̸� �����ʺ��� ó����
  - n���� ���� ������ ���� ���� ��� n�� ������ ���� ����
  (��뿹)
  SELECT SUBSTR('�����Ⱑ ���ܿ� ���Ƕ�����',5,6) AS COL1,
         SUBSTR('�����Ⱑ ���ܿ� ���Ƕ�����',5) AS COL2,
         SUBSTR('�����Ⱑ ���ܿ� ���Ƕ�����',0,6) AS COL3,
         SUBSTR('�����Ⱑ ���ܿ� ���Ƕ�����',5,30) AS COL4,
         SUBSTR('�����Ⱑ ���ܿ� ���Ƕ�����',-5,6) AS COL5
    FROM DUAL;
    
��뿹)ȸ�����̺��� �������� ȸ������ ��ȸ�Ͻÿ�
      Alias�� ������,ȸ�����̴�.
      SELECT SUBSTR(MEM_ADD1,1,2) AS ������,
             COUNT(*)AS ȸ����
        FROM MEMBER
       GROUP BY SUBSTR(MEM_ADD1,1,2);
        

 7) REPLACE(c1,c2[c3]) -- ���ڿ� ġȯ �Լ�
  - ���ڿ� c1���� c2���ڿ��� ã�� c3���ڿ��� ġȯ
  - c3���ڿ��� �����Ǹ� ã�� c2 ���ڿ��� ������
  - c3�� �����ǰ� c2�� �������� ����ϸ� �ܾ� ������ ������ ������
 (��뿹)
  SELECT MEM_NAME,       
         REPLACE(MEM_NAME,'��','��')
    FROM MEMBER;
    
  SELECT PROD_NAME,
         REPLACE(PROD_NAME,'�ﺸ','SAMBO'), --�ﺸ��� �ܾ SAMBO�� ġȯ
         REPLACE(PROD_NAME,'�ﺸ'), -- �ﺸ��� �ܾ ��� ����
         REPLACE(PROD_NAME,' ') -- �÷� ���� ��� ������ ����
    FROM PROD;
         
 (��뿹) ȸ�����̺��� '����'�� �����ϴ� ȸ������ �⺻�ּ��� ������
         ��Ī�� ��� '����������'�� ���Ͻ�Ű�ÿ�
      SELECT MEM_NAME AS ȸ���̸�,
                 -- CASE���� �ڹ��� IF���� �����ϴ�.
             CASE WHEN SUBSTR(MEM_ADD1,1,3)='������' THEN -- �������� ���
                       REPLACE(MEM_ADD1,SUBSTR(MEM_ADD1,1,3),'����������')
                  WHEN SUBSTR(MEM_ADD1,1,5)!='����������' THEN -- �����ð� �ƴ� �����ϰ��
                       REPLACE(MEM_ADD1,SUBSTR(MEM_ADD1,1,2),'����������')
                  ELSE MEM_ADD1
                   END AS �⺻�ּ� -- CASE ��ħ.
        FROM MEMBER -- ������̺� ����.
       WHERE MEM_ADD1 LIKE '����%'; -- ADD1 �÷������� �������ν����ϴ� ��� �����Ͱ� ����

 8) INSTR(c1,c2[,m[,n]])
  - �־��� c1 ���ڿ����� c2 ���ڿ��� ó�� ��Ÿ���� ��ġ�� ��ȯ
  - m�� ������ġ�� ��Ÿ����
  - n�� �ݺ� ��Ÿ�� Ƚ��
 (��뿹)
  SELECT INSTR('APPLEBANANAPERSIMMON','L') AS COL1,
         INSTR('APPLEBANANAPERSIMMON','A',3) AS COL1,
         INSTR('APPLEBANANAPERSIMMON','A',3,2) AS COL1
         INSTR('APPLEBANANAPERSIMMON','A',-3) AS COL1,
    FROM DUAL;

 9) LENGTHB(c1), LENGTH(c1)
  - �־��� ���ڿ��� ���̸� BYTE����(LENGTHB), ���ڼ���(LENGTH)�� ��ȯ
  
    
    