2022-0406-01)����� ����
 - ����Ŭ ����� ����
 (�������)
 CREATE USER ������ INDENTIFIED BY ��ȣ;
 create user sjr identified by java;

 - ���Ѽ���
 (�������)
GRANT ���Ѹ�[,���Ѹ�,... TO ������;
GRANT CONNECT,RESOURCE,DBA TO SJR;

** HR���� Ȱ��ȭ
ALTER USER HR ACCOUNT UNLOCK;

ALTER USER HR IDENTIFIED BY java;