2022-0420-01)

6. NULL ó�� �Լ�
  - ����Ŭ�� ��� �÷��� ���� ������� ������ �⺻������ NULL�� �ʱ�ȭ��
  - ���꿡�� NULL �ڷᰡ �����ͷ� ���Ǹ� ��� ����� NULL�� ��
  - Ư�� �÷��̳� ������ ����� NULL���� ���θ� �Ǵ��ϱ����� �����ڴ�
    IS [NOT] NULL
  - NVL, NVL2, NULLIF ���� ����
  
 1) IS [NOT] NULL
    . Ư�� �÷��̳� ������ ����� NULL���� ���θ� �Ǵ�('='�δ� NULL�� üũ���� ����)
��뿹)������̺��� ���������� NULL�� �ƴϸ� ������(80�� �μ�)�� ������ �ʴ�
      ����� ��ȸ�Ͻÿ�.
      Alias�� �����ȣ,�����,�μ��ڵ�,��������(commission_pct
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ��ڵ�,
         COMMISSION_PCT AS ��������
    FROM HR.employees
   WHERE COMMISSION_PCT IS NOT NULL
      -- COMMISSION_PCT != NULL -- IS [NOT]�� ����Ͽ�����
     AND DEPARTMENT_ID IS NULL;
    
  