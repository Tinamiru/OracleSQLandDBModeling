2022-0421-01)
SELECT LEVEL, -- 의사컬럼(Pseudo Column)
       DEPARTMENT_ID AS 부서코드,
       LPAD(' ',4*(LEVEL-1))||DEPARTMENT_NAME AS 부서명,
       PARENT_ID AS 상위부서코드,
       CONNECT_BY_ISLEAF
  FROM DEPTS
 START WITH PARENT_ID IS NULL -- 루트설정
 CONNECT BY /*NOCYCLE*/ PRIOR DEPARTMENT_ID=PARENT_ID;
 
 