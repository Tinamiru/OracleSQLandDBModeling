2022-0406-01)사용자 생성
 - 오라클 사용자 생성
 (사용형식)
 CREATE USER 유저명 INDENTIFIED BY 암호;
 create user sjr identified by java;

 - 권한설정
 (사용형식)
GRANT 권한명[,권한명,... TO 유저명;
GRANT CONNECT,RESOURCE,DBA TO SJR;

** HR계정 활성화
ALTER USER HR ACCOUNT UNLOCK;

ALTER USER HR IDENTIFIED BY java;