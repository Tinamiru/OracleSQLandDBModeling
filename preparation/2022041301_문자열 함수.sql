2022-04-13)����
���ڿ� �Լ�
1. CONCAT(c1,c2)

2. �빮�ڿ� �ҹ��� ��ȯ �Լ�
    1) LOWER(c1)
     - c1�� ����� �ڷḦ ��� �ҹ��ڷ� ��ȯ
     (��뿹) EMPLOYEES���� 100���� 130������ ������� EMAIL�� ��� �ҹ��ڷ� ��ȯ�ϰ�
             �����ȣ�� �������� ��ȸ�Ͻÿ�.
             Alias�� �����ȣ,�����,�̸���,��ȣ
      SELECT EMPLOYEE_ID AS �����ȣ,
             EMP_NAME AS �����,
             LOWER(EMAIL) AS �̸���,
             PHONE_NUMBER AS ��ȣ
        FROM HR.employees
       WHERE EMPLOYEE_ID BETWEEN '100' AND '130'
       ORDER BY 1 DESC;
     
    2) UPPER(c1)
     - c1�� ����� �ڷḦ ��� �빮�ڷ� ��ȯ
     (��뿹) EMPLOYEES���� 100���� 180������ ������� �̸��� ��� �빮�ڷ� ��ȯ�ϰ�
             �����ȣ�� �������� ��ȸ�Ͻÿ�.
             Alias�� �����ȣ,�����,�̸���,��ȣ
      SELECT EMPLOYEE_ID AS �����ȣ,
             UPPER(EMP_NAME) AS �����,
             EMAIL AS �̸���,
             PHONE_NUMBER AS ��ȣ
        FROM HR.employees
       WHERE EMPLOYEE_ID BETWEEN '100' AND '180'
       ORDER BY 1 DESC;             

     
    3) INITCAP(c1)
     - C1�� ����� �ڷ��� �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ
     (��뿹) EMPLOYEES���� 100���� 130������ ������� EMAIL�� �չ��ڸ� �����ϰ� �ҹ��ڷ� ��ȯ,
             �����ȣ�� �������� ��ȸ�Ͻÿ�.
             Alias�� �����ȣ,�����,�̸���,��ȣ
      SELECT EMPLOYEE_ID AS �����ȣ,
             EMP_NAME AS �����,
             INITCAP(EMAIL) AS �̸���,
             PHONE_NUMBER AS ��ȣ
        FROM HR.employees
       WHERE EMPLOYEE_ID BETWEEN '100' AND '130'
       ORDER BY 1 DESC;
    
3. LPAD, RPAD
    1) 