/*
<�н���ǥ>
. ���ν��� + �����췯
. Exception
. Trigger

����Ŭ �����췯 ����ϱ�!

1) �����췯
  - Ư���� �ð��� �Ǹ� �ڵ������� ����(query)����� ����ǵ��� �ϴ� �����
  

*/

SELECT MEM_ID, MEM_MILEAGE
FROM MEMBER
WHERE   MEM_ID = 'a001';
/--PL/SQL�� /�� �ܶ��� ������ �ִ°��� ����.
CREATE OR REPLACE PROCEDURE USP_UP_MEM_MIL
IS
BEGIN
    UPDATE  MEMBER
    SET     MEM_MILEAGE = mem_mileage + 10
    WHERE   MEM_ID = 'a001';
    COMMIT;
END;
/
EXEC usp_up_mem_mil;
/

--������ ����
DECLARE
    -- ������ JOB�� ���� ���̵�. ������ ����
    V_JOB NUMBER(5);
BEGIN
    dbms_job.submit(
        V_JOB, -- JOB ���̵�
        'USP_UP_MEM_MIL;', -- ������ ���ν��� �۾�
        SYSDATE, -- ���� �۾��� ������ �ð�
        'SYSDATE + (1/1440)', -- 1�� ����.
        FALSE -- �Ľ�(�����м�, �ǹ̺м�) ����
    );
    DBMS_OUTPUT.PUT_LINE('JOB IS '|| TO_CHAR(V_JOB));
    COMMIT;
END;
/
--

--�����췯�� ��ϵ� �۾��� ��ȸ
SELECT * FROM USER_JOBS;
/
--�����췯���� �۾��� �����ϴ� ���

BEGIN
    dbms_job.remove(1);
END;
/
SELECT  SYSDATE
      , TO_CHAR(SYSDATE + (1/1440),'YYYY-MM-DD HH24:MI:SS') �Ϻе�
      , TO_CHAR(SYSDATE + (1/24),'YYYY-MM-DD HH24:MI:SS') �ѽð���
      , TO_CHAR(SYSDATE + 1,'YYYY-MM-DD HH24:MI:SS') �Ϸ��
FROM    DUAL;     
/
/*
2) Exception(����)
  - PL/SQL���� ERROR�� �߻��ϸ� EXCEPTION�� �߻��ǰ�
    �ش� ����� �����ϸ� ����ó���κ����� �̵���

���� ����
  - ���ǵ� ����
    PL/SQL���� ���� �߻��ϴ� ERROR�� �̸� ������
    ������ �ʿ䰡 ���� �������� �Ͻ������� �߻���
    1) NO_DATA_FOUND : �������
    2) TOO_MANY_DATA : ������ ����
    3) DUP_VAL_ON_INDEX : ������ �ߺ� ����(P.K / U.K)
    4) VALUE_ERROR : �� �Ҵ� �� ��ȯ�� ����
    5) INVALID_NUMBER : ���ڷ� ��ȯ�� �ȵ� EX) TO_NUMBER('������')
    6) NOT_LOGGED_ON : DB�� ������ �ȵǾ��µ� ����
    7) LOGIN_DENIED : �߸��� ����� / �߸��� ��й�ȣ
    8) ZERO_DIVIDE : 0���� ����
    9) INVALID_CURSOR : ������ ���� Ŀ���� ����

  - ���ǵ��� ���� ����
    ��Ÿǥ�� ERROR
    ������ �ؾ� �ϸ� �������� �ӽ������� �߻�

  - ����� ���� ����
    ���α׷��Ӱ� ���� ���ǿ� �������� ������� �߻�
    ������ �ؾ��ϰ�, ��������� RAISE���� ����Ͽ� �߻�
*/

DECLARE
    V_NAME VARCHAR2(20);
BEGIN
    -- V_NAME�� '����ĳ�־�'�� �Ҵ��
    SELECT  LPROD_NM+10 INTO V_NAME
    FROM    LPROD
    WHERE   LPROD_GU LIKE 'P20%';
    DBMS_OUTPUT.PUT_LINE('�з��� : '||V_NAME);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN -- ORA-01403 ����
            DBMS_OUTPUT.PUT_LINE('�ش������� �����ϴ�.');
        WHEN TOO_MANY_ROWS THEN -- ORA-01422
            DBMS_OUTPUT.PUT_LINE('�Ѱ� �̻��� ���� ���Խ��ϴ�.');
        WHEN OTHERS THEN -- �Ƹ�������
            DBMS_OUTPUT.PUT_LINE('��Ÿ ���� : '||SQLERRM);
END;
/
-- ���ǵ��� ���� ����
DECLARE
    -- EXCEPTION Ÿ���� exp_reference ����
    exp_reference EXCEPTION;
    -- EXCEPTION_INIT�� ���� ���� �̸��� ������ȣ�� �����Ϸ����� �����
    PRAGMA EXCEPTION_INIT (exp_reference, -2292);
BEGIN
    -- ORA-02292 ���� �߻�
    DELETE FROM LPROD WHERE LPROD_GU = 'P101';
    DBMS_OUTPUT.PUT_LINE('�з� ����');
    EXCEPTION
        WHEN exp_reference THEN
            DBMS_OUTPUT.PUT_LINE('���� �Ұ�');
END;
/
SELECT *
FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'FR_BUYER_LGU';
/

-- ����� ���� ����
ACCEPT p_lgu PROMPT '����Ϸ��� �з��ڵ� �Է�: '
DECLARE
    -- exception Ÿ���� ���� ����
    exp_lprod_gu EXCEPTION;
    v_lgu VARCHAR2(10) := UPPER('&p_lgu');
    -- DECLARE���� ������ �������� �ʰ� ���� ACCEPT ������ ���(&��)�� �� �ִ�.
BEGIN
    if v_lgu IN('P101','P102','P201','P202') THEN
        --����ο��� RAISE�������� ��������� EXCEPTION�� �߻���
        RAISE exp_lprod_gu;
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_lgu || '�� ��ϰ���');
    
    EXCEPTION
        WHEN exp_lprod_gu THEN
             DBMS_OUTPUT.PUT_LINE(v_lgu||'�� �̹� ��ϵ� �ڵ��Դϴ�.');
END;
/
select lprod_gu from lprod;
/

--DEPARTMENT ���̺� �а��ڵ带 '�İ�',
--�а����� '��ǻ�Ͱ��а�', ��ȭ��ȣ�� '765-4100'
--���� INSERT �غ���
--���ܸ޽��� : <�ߺ��� �ε��� ���� �߻�!>

DECLARE
    exp_reference EXCEPTION;
    PRAGMA EXCEPTION_INIT (exp_reference, -00001);
BEGIN
    INSERT INTO DEPARTMENT (DEPT_ID, DEPT_NAME, DEPT_TEL)
    VALUES ('�İ�', '��ǻ�Ͱ��а�', '765-4100');
    DBMS_OUTPUT.PUT_LINE('���� ����');
    EXCEPTION
        WHEN exp_reference THEN
        DBMS_OUTPUT.PUT_LINE('<�ߺ��� �ε��� ���� �߻�!>');
    
END;
/

SELECT * FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'DEPARTMENT_PK';
/

/*
COURSE ���̺��� �����ڵ尡 'L1031'�� ���Ͽ�
�߰� ������(COURSE_FEES)�� '�︸��'���� �����غ���
[������ ������Ÿ���� ������ ���� �߻�]
*/

DECLARE
BEGIN
    UPDATE  COURSE
    SET     COURSE_FEES = '�︸��'
    WHERE   COURSE_ID = 'L1031';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('���� ����');
    EXCEPTION
        WHEN invalid_number THEN
            DBMS_OUTPUT.PUT_LINE('[������ ������Ÿ���� ������ ���� �߻�]');
        WHEN OTHERS THEN
            NULL;
END;
/

/*
SG_SCORES ���̺� ����� SCORE �÷��� ������
100���� �ʰ��Ǵ� ���� �ִ��� �����ϴ� ����� �ۼ��غ���
��, 100�� �ʰ� �� OVER_SCORE ���ܸ� �����غ���
[��������� ���ܷ� ó���غ���]
*/

INSERT INTO SG_SCORES(STUDENT_ID, COURSE_ID, SCORE, SCORE_ASSIGNED)
VALUES ('A1701','L0013',107,'2010/12/29');
/
DECLARE -- ����.
    OVER_SCORE EXCEPTION; -- ����� ���� ���� ����
    V_SCORE SG_SCORES.SCORE%TYPE; -- ���ھ� ���� ����
    V_STUDENT sg_scores.student_id%TYPE; -- �л�id ����
    
    CURSOR  CUR IS -- Ŀ�� ����(DECLARE���� ����)
            SELECT  STUDENT_ID,
                    SCORE
            FROM    SG_SCORES;
BEGIN 
    OPEN CUR;-- Ŀ�� ����
        FETCH CUR INTO V_STUDENT, V_SCORE; -- Ĝġ�� ����� Ŀ������
            WHILE(CUR%FOUND) LOOP -- �ݺ��� ����
                IF V_SCORE>100 THEN -- ���ǹ� (������ 100 �̻��� ���)
                    DBMS_OUTPUT.PUT_LINE(V_STUDENT||'�� ����'||V_SCORE); -- �л�id�� ���� ���
                    RAISE OVER_SCORE; -- ���� �߻�
                ELSE -- ������ 100�̻��� �ƴҰ��
                    DBMS_OUTPUT.PUT_LINE(V_STUDENT||'�� ����'||V_SCORE); -- �л�id�� ���� ���
                    FETCH CUR INTO V_STUDENT, V_SCORE; -- ���� ������
                  END IF; -- ���ǹ� ����
             END LOOP; -- �ݺ��� ����
    CLOSE CUR; -- Ŀ�� ����
   EXCEPTION -- ����
        WHEN OVER_SCORE THEN -- ����ó��
            DBMS_OUTPUT.PUT_LINE('������ 100���� �ʰ��մϴ�.'); -- ���� ���
END; -- ����
/


SELECT *
FROM SJR.sg_scores;


commit;
--�޸� ��뷮 ��ȸ ������
SELECT 

to_char(( sum( se1.value)/1024)/1024, '999G999G990D00') || ' MB' "CURRENT_SIZE",

to_char(( sum(se2.value)/1024)/1024, '999G999G990D00') || ' MB' "MAXIMUM_SIZE"

FROM v$sesstat se1, v$sesstat se2, v$session ssn, v$bgprocess bgp, v$process prc,

v$instance ins, v$statname stat1, v$statname stat2

WHERE se1.statistic# = stat1.statistic# and stat1.name = 'session pga memory'

AND se2.statistic# = stat2.statistic# and stat2.name = 'session pga memory max'

AND se1.sid = ssn.sid

AND se2.sid = ssn.sid

AND ssn.paddr = bgp.paddr (+)

AND ssn.paddr = prc.addr (+)

order by CURRENT_SIZE desc 
/
