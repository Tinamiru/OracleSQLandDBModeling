/* 2022-0516-01)

** 트리거 의사 레코드 - 행단위 트리거에서만 사용 가능 (=FOR EACH ROW이 기술된)
 :NEW   INSERT와 UPDATE에서 사용
        데이터가 삽입(갱신)될때 '새로 입력되는 값'을 지칭
        DELETE 시 모두 NULL.
 :OLD   DELETE와 UPDATE에서 사용
        데이터가 삭제(갱신)될때 '이미 저장되어 있던 값'을 지칭
        INSERT 시 모두 NULL.
        
** 트리거 함수
    INSERTING 이벤트가 INSERT 이면 true
    UPDATING 이벤트가 UPDATE 이면 true
    DELETING 이벤트가 DELETE 이면 true
*/

-- 사용예) 장바구니테이블에 오늘날짜의 자료가 입력(삽입/수정/삭제)되었을 때
--         재고수불테이블의 출고, 현재고 등의 컬럼을 변경하시오.

    CREATE OR REPLACE TRIGGER TG_CART_CHANGE 
        AFTER INSERT OR DELETE OR UPDATE ON CART
        FOR EACH ROW
    DECLARE
        V_QTY NUMBER:=0;
        V_PID PROD.PROD_ID%TYPE;
        V_DATE DATE;
    BEGIN
        IF INSERTING THEN
            V_PID:=(:NEW.CART_PROD);
            V_QTY:=(:NEW.CART_QTY);
            V_DATE:=TO_DATE(SUBSTR((:NEW.CART_NO),1,8));
        ELSIF UPDATING THEN
            V_PID:=(:NEW.CART_PROD);
            V_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
            V_DATE:=TO_DATE(SUBSTR((:NEW.CART_NO),1,8));
        ELSIF DELETING THEN
            V_PID:=(:OLD.CART_PROD);
            V_QTY:=(:OLD.CART_QTY);
            V_DATE:=TO_DATE(SUBSTR((:OLD.CART_NO),1,8));
        END IF;
        
        UPDATE  REMAIN A
        SET     a.remain_o=a.remain_o+V_QTY,
                A.REMAIN_J_99=A.REMAIN_J_99-V_QTY,
                A.REMAIN_DATE=V_DATE
        WHERE   A.REMAIN_YEAR='2020'
        AND     A.PROD_ID=V_PID;
    END;
/

INSERT INTO CART
    VALUES('f001','2022051600001', 'P201000018', 10);
    
    
-- 'f001'회원이 'P201000018'의 상품 구매수량을 3개로 변경
UPDATE  CART
SET     CART_QTY=3
WHERE   CART_NO='2022051600001'
AND     CART_PROD='P201000018';





