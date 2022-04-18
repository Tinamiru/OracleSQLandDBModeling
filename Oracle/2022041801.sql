2022-0418-01)
  6) WIDTH_BUCKET(n,min,max,b)
    - min���� max���� ������ b���� �������� ������ �־��� �� n�� ���� ������
      �ε��� ���� ��ȯ.
    - max ���� ������ ���Ե��� ������, min���� ���� n����
      0���� max���� ū ���� b+1���� �ε����� ��ȯ.
��뿹)
  SELECT WIDTH_BUCKET(60,20,80,4)AS COL1,
         WIDTH_BUCKET(80,20,80,4)AS COL2,
         WIDTH_BUCKET(20,20,80,4)AS COL3,
         WIDTH_BUCKET(10,20,80,4)AS COL4,
         WIDTH_BUCKET(100,20,80,4)AS COL
    FROM DUAL;
    
��뿹)ȸ�����̺��� 1000~6000 ���ϸ����� 6���� �������� ���������� �� ȸ������
      ���ϸ����� ���� ����� ���Ͽ� ����Ͻÿ�
      Alias�� ȸ����ȣ, ȸ����,���ϸ���,���
      ��, ����� ���ϸ����� 6000�ʰ��� ȸ������ 1��޿��� ������ ������� �з��Ͻÿ�.
      SELECT MEM_ID AS ȸ����ȣ,
             MEM_NAME AS ȸ����,
             MEM_MILEAGE AS ���ϸ���,
             8-WIDTH_BUCKET(MEM_MILEAGE,1000,6000,6) AS ���1,
             WIDTH_BUCKET(MEM_MILEAGE,6000,999,6)+1 AS ���2
        FROM MEMBER
       ORDER BY 3 DESC;
       
       
3. ��¥�� �Լ�
 1) SYSDATE
   . �ý��ۿ��� �����ϴ� ��¥�� �ð����� ��ȯ
   . -�� +�� ������ ������
��뿹) SELECT SYSDATE+3650 FROM DUAL;

 2) ADD_MONTHS(d, n)
   . �־��� ��¥ d�� n ������ ���� ��¥ ��ȯ
��뿹) SELECT ADD_MONTHS(SYSDATE, 120) FROM DUAL;

 3) NEXT_DAY(d, c)
   . �־��� ��¥ ������ ó�� ������ c������ ��¥�� ��ȯ. -- ���ƿ��� ����.
   . c�� '������','��'~'�Ͽ���', '��'�� �ϳ��� ���� ����
   
��뿹)
  SELECT NEXT_DAY(SYSDATE,'������'),
         NEXT_DAY(SYSDATE,'�Ͽ���'),
         NEXT_DAY(SYSDATE,'�����')
    FROM DUAL;
    
 4) LAST_DAY(d)
   . �־��� ��¥�ڷ� d�� ���Ե� ���� ������ ��¥�� ��ȯ
   . �ַ� 2���� ����������(����/���)�� ����Ҷ� ����.
   
��뿹)������̺��� 2���� �Ի��� ��������� ��ȸ�Ͻÿ�. 
      Alias�� �����ȣ,�����,�μ���,����,�Ի����̴�.
      
  SELECT A.EMP_ID AS �����ȣ,
         A.EMP_NAME AS �����,
         B.DEPARTMENT_NAME AS �μ���,
         C.JOB_TITLE AS ����,
         A.HIRE_DATE AS �Ի���
    FROM HR.employees A, HR.departments B HR.jobs C
   WHERE A.DEPARTMENT_ID=B.DEPERTMENT_ID
         AND A.JOB_ID=C.JOB_ID
         AND EXTRACT(MONTH FROM A.HIRE_DATE)=2;

��뿹)�������̺�(BUYPROD)���� 2020�� 2�� ���ں� �������踦 ���Ͻÿ�.
      Alias�� ��¥, �ż����հ�, ���Աݾ��հ��̸� ��¥������ ����Ͻÿ�
      
  SELECT BUY_DATE AS ��¥,
         SUM(BUY_QTY)AS �ż����հ�,
         SUM(BUY_QTY*BUY_COST)���Աݾ��հ�
    FROM BUYPROD
   WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND
         LAST_DAY(TO_DATE('20200201'))
   GROUP BY BUY_DATE
   ORDER BY 1;

5) EXTRACT(fmt FROM d) -- �����ϴ�, �̾Ƴ���,
   - �־��� ��¥�ڷ� d���� fmt(Format string:���Ĺ��ڿ�)�� ���õ� ���� ��ȯ
   - fmt�� YEAR, MONTH, DAY, HOUR, MINUTE, SECOND �� "�ϳ�" -- �� �̻� ��� �Ұ�.
   - ����� �����ڷ��̴�.

��뿹)ȸ�����̺��� �̹��޿� ������ �ִ� ȸ���� ��ȸ�Ͻÿ�.
      Alias�� SELECT BUY_DATE AS ��¥,

  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_BIR AS �������,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE EXTRACT(MONTH FROM SYSDATE+30)=EXTRACT(MONTH FROM MEM_BIR);
      
��뿹)������ 2020�� 4�� 18���̶�� �����Ҷ�
      ������̺��� �ټӳ���� 15�� �̻��� ����� ��ȸ�Ͻÿ�
      Alias�� �����ȣ,�����,�Ի���,�ټӳ��,�޿�
      
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         HIRE_DATE AS �Ի���,
         LPAD((EXTRACT(YEAR FROM TO_DATE('20200418'))-
           EXTRACT(YEAR FROM HIRE_DATE)||'��'),9,' ') AS �ټӳ��,
         SALARY AS �޿�
    FROM HR.employees
   WHERE EXTRACT(YEAR FROM TO_DATE('20200418'))-EXTRACT(YEAR FROM HIRE_DATE)>=15
   ORDER BY 4 DESC;