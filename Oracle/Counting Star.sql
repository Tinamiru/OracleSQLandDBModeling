DECLARE
    v_id NUMBER := 1;
BEGIN
    WHILE v_id < 20 LOOP
        dbms_output.put_line(rpad('*', v_id, '*'));
        v_id := v_id + 2;
    END LOOP;
END;