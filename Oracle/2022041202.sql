2022-0412-02)
4)��Ÿ������
 (1) IN ������
   - �ҿ������̰ų� ��Ģ���� ���� �ڷḦ ���Ҷ� ���
   - OR ������, =ANY, =SOME �����ڷ� ��ȯ����
   - IN �����ڿ��� '=' ����� ������
  (�������)
   expr IN(��1, ��2,...��n) -- OR�� ���̻���ؾ��Ҷ� ������.
     - 'expr'(����)�� ���� ����� '��1' ~ '��n' �� ��� �ϳ���
       ��ġ�ϸ� ����� ��(true)�� ��ȯ
     
  (��뿹) ������̺��� 20��,70��,90��,110�� �μ��� �ٹ��ϴ�
          ����� ��ȸ�Ͻÿ�
          Alias�� �����ȣ,�����,�μ���ȣ,�޿��̴�.
    (OR ������ ��뿹)
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ,
           SALARY AS �޿�
      FROM HR.employees
     WHERE DEPARTMENT_ID=20
        OR DEPARTMENT_ID=70
        OR DEPARTMENT_ID=90
        OR DEPARTMENT_ID=110;
        
    (IN ������ ��뿹)
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ,
           SALARY AS �޿�
      FROM HR.employees
     WHERE DEPARTMENT_ID IN(20,70,90,110);
     
     (=ANY(=SOME ������ ��뿹) -- IN�� ��Ī�� �ٸ��� ����� ���̰� ����.
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           DEPARTMENT_ID AS �μ���ȣ,
           SALARY AS �޿�
      FROM HR.employees
     WHERE -- DEPARTMENT_ID=ANY(20,70,90,110);
           DEPARTMENT_ID=SOME(20,70,90,110);

 (2) ANY,SOME ������
   - ��ȣ(=)�� ����� ���Ե��� ���� IN �����ڿ� ���� ��� ����
 (�������)
   expr ���迬���� ANY(SOME)(��1,...��n)
   
 (��뿹)ȸ�����̺��� ������ �������� ȸ������ ���ϸ������� ���� ���ϸ�����
        ������ ȸ������ ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����,����,���ϸ���
   1)������ �������� ���ϸ���.
      SELECT MEM_MILEAGE
        FROM MEMBER
       WHERE MEM_JOB='������';
    
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE <ANY(1700,900,2200,3200)
   ORDER BY 4;
   
   -- �������� ��뿹 --
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE <ANY(SELECT MEM_MILEAGE
                            FROM MEMBER
                           WHERE MEM_JOB='������')
   ORDER BY 4;
   
 (3) ALL ������
   - ALL ������ ����� ���� ��θ� ������ų���� ������ ��(true)�� ��ȯ
   (�������)
  expr ���迬���� ALL(��1,...��n)
  
   (��뿹)ȸ�����̺��� ������ �������� ȸ�� �� ���� ���� ���ϸ����� ������ ȸ������
          �� ���� ���ϸ����� ������ ȸ������ ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����,����,���ϸ���
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE >ALL(SELECT MEM_MILEAGE
                            FROM MEMBER
                           WHERE MEM_JOB='������')
   ORDER BY 4;
   
 (4)BETWEEN ������ -- LIKE�� ���ڿ� �����ڸ�.
    - ���õ� �ڷ��� ������ �����Ҷ� ���
    - AND �����ڿ� ���� ���
    - ��� ������ Ÿ�Կ� ��밡��
  (�������)
   expr BETWEEN ���Ѱ� AND ���Ѱ�
   . '���Ѱ�'�� '���Ѱ�'�� Ÿ���� �����ؾ� ��
  (��뿹)��ǰ���̺��� ���԰����� 100000�� ~ 200000�� ������ ��ǰ�� ��ȸ�Ͻÿ�
         Alias�� ��ǰ�ڵ�,��ǰ��,���԰�,���Ⱑ�̸�, ���԰������� ���
         
  /*SELECT PROD_ID AS ��ǰ�ڵ�,
         PROD_NAME AS ��ǰ��,
         PROD_COST AS ���԰�,
         PROD_PRICE AS ���Ⱑ
    FROM PROD
   WHERE PROD_COST>=100000 AND PROD_COST<=200000
   ORDER BY 3;*/
   
   (BETWEEN ������ ���)
  SELECT PROD_ID AS ��ǰ�ڵ�,
         PROD_NAME AS ��ǰ��,
         PROD_COST AS ���԰�,
         PROD_PRICE AS ���Ⱑ
    FROM PROD
   WHERE PROD_COST BETWEEN 100000 AND 200000 -- BETWEEN �����ڴ� AND�� ��ġ�����ϴ�.
   ORDER BY 3;
  
         
  (��뿹)������̺��� 2006��~2007�� ���̿� �Ի��� ������� ��ȸ�Ͻÿ�.
         Alias�� �����ȣ,�����,�Ի���,�μ��ڵ��̸� �Ի��� ������ ���

  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME �����,
         HIRE_DATE �Ի���,
         DEPARTMENT_ID �μ��ڵ�
    FROM HR.employees
   WHERE HIRE_DATE BETWEEN TO_DATE('20060101') AND TO_DATE('20071231')
   ORDER BY 3;

  (��뿹)��ǰ�� �з��ڵ尡 'P100'����('P100'-'P199')�� ��ǰ�� �ŷ��ϴ�
         �ŷ�ó������ ��ȸ�Ͻÿ�.
         Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,�ּ�,�з��ڵ�
 SELECT BUYER_ID AS �ŷ�ó�ڵ�,
        BUYER_NAME AS �ŷ�ó��,
        BUYER_ADD1 || ' ' || BUYER_ADD1 AS �ּ�,
        BUYER_LGU AS �з��ڵ�
   FROM BUYER
  WHERE BUYER_LGU BETWEEN 'P100' AND 'P199'
  ORDER BY 4;
  
  (5)LIKE ������
   - ������ ���ϴ� ������
   - ���ϵ�ī��(���Ϻ񱳹��ڿ�) : '%'�� '_'�� ���Ǿ� ������ ������
  (�������)
   expr LIKE '���Ϲ��ڿ�'
   1) '%' : '%'�� ���� ��ġ���� ������ ��� ���ڿ��� ���
   ex) SNAME LIKE '��%' => SNAME�� ���� '��'���� �����ϴ� ��簪�� ������
       SNAME LIKE '%��%' => SNAME�� �� �߿� '��'�� �ִ� ��簪�� ������
       SNAME LIKE '%��' => SNAME�� ���� '��'���� ������ ��簪�� ������
       
   2) '_' : '_'�� ���� ��ġ���� �ϳ��� ���ڿ� ����
   ex) SNAME LIKE '��_' => SNAME�� ���� 2�����̸� '��'���� �����ϴ� ���ڿ��� ������
       SNAME LIKE '_��_' => SNAME�� �� �߿� 3���ڷ� ������ ���� �߰��� ���ڰ�
                            '��'�� �����Ϳ� ������
       SNAME LIKE '_��' => SNAME�� ���� 2�����̸� '��'���� ������ ���ڿ��� ������
 
 (��뿹)��ٱ������̺�(CART)���� 2020�� 6���� �Ǹŵ� �ڷḦ ��ȸ�Ͻÿ�
        Alias�� �Ǹ�����,��ǰ�ڵ�,�Ǹż����̸� �Ǹ��� ������ ����Ͻÿ�
        SELECT SUBSTR(CART_NO,1,8) AS �Ǹ�����,
               CART_PROD AS ��ǰ�ڵ�,
               CART_QTY AS �Ǹż���
          FROM CART
         WHERE CART_NO LIKE '202006%'
         ORDER BY 1;
        
        ��뿹)�������̺�(BUYPROD)���� 2020�� 6���� ������ �ڷḦ ��ȸ�Ͻÿ�
        Alias�� ��������,��ǰ�ڵ�,���ż���,���űݾ��̸� ������ ������ ����Ͻÿ�
        SELECT BUY_DATE AS ��������,
               BUY_PROD AS ��ǰ�ڵ�,
               BUY_QTY AS ���ż���,
               BUY_QTY*BUY_COST AS ���űݾ�
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
         -- ��¥ ������Ÿ�Կ��� LIKE�� ����Ҽ� ����. �����Ұ�� ����ȯ�� �ʿ��ϳ�
         -- BETWEEN �����ڸ� ����ϴ°��� ȿ����.
         ORDER BY 1;
 
 (��뿹)ȸ�����̺��� �泲�� �����ϴ� ȸ���� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ,ȸ����,�ּ�,���ϸ���
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
               MEM_MILEAGE AS ���ϸ���
          FROM MEMBER
         WHERE MEM_ADD1 LIKE '�泲%'
         ORDER BY 1;