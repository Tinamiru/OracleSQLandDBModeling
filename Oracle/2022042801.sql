2022-0428-01)SUBQUERY�� DML���
1. INSERT ������ �������� ���
 - INSERT INTO ���� ���������� ����ϸ� VALUES���� ������
 - ���Ǵ� ���������� '( )'�� �����ϰ� �����

(�������)
   INSERT INTO ���̺��[(�÷���[,�÷���,...])]
     ��������;
   . '���̺��'�� ����� �÷��� ����, ����, Ÿ�԰� �������� SELECT����
     SELECT���� �÷��� ����, ����, Ÿ���� �ݵ�� ��ġ�ؾ��Ѵ�.

��뿹)��� ���� ���̺��� �⵵���� '2020'��, ��ǰ�ڵ忡��
       ��ǰ���̺��� ��� ��ǰ�ڵ带 �Է��Ͻÿ�

    INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID)
      SELECT '2020', PROD_ID
        FROM PROD;
        
        
    SELECT * FROM REMAIN;
    
2. UPDATE ������ �������� ���
  (�������)
  UPDATE ���̺� [��Ī]
     SET (�÷���[,�÷���,...])=(��������)
   [WHERE ����];
   
   ��뿹)���������̺�(REMAIN)�� ������� �����Ͻÿ�.
          �������� ��ǰ���̺�� ����������� �ϸ� ��¥�� 2020�� 1�� 1�Ϸ� ����
    
    UPDATE REMAIN A
       SET (A.REMAIN_J_00,A.REMAIN_J_99,A.REMAIN_DATE)=
           (SELECT A.REMAIN_J_00+B.PROD_PROPERSTOCK,
                   A.REMAIN_J_99+B.PROD_PROPERSTOCK,
                   TO_DATE('20200101')
              FROM PROD B
             WHERE A.PROD_ID=B.PROD_ID)
    WHERE A.REMAIN_YEAR='2020';
    
    SELECT*
    FROM REMAIN;