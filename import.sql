Creating file pointer

DROP DIRECTORY MYCSV1;

create directory MYCSV1 as 'C:\SQL_Path\homework3';

COMMIT;


-- Importing data
DECLARE
      F UTL_FILE.FILE_TYPE;
      V_LINE VARCHAR2 (20000);
      V_SID number;
      V_CID NUMBER;
      V_review varchar2(20000);
      V_value NUMBER;
    BEGIN
      F := UTL_FILE.FOPEN ('MYCSV1', 'seedWords.csv', 'R', 20000);
      IF UTL_FILE.IS_OPEN(F) THEN
        LOOP
          BEGIN
--            DBMS_OUTPUT.PUT_LINE('Start');
            UTL_FILE.GET_LINE(F, V_LINE);
--            DBMS_OUTPUT.PUT_LINE(V_LINE);
            IF V_LINE IS NULL THEN
              EXIT;
            END IF;
             V_SID := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1);
             V_CID  := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
             v_review   := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
             V_value   := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
            
            INSERT INTO SEED VALUES(V_SID, V_CID, V_review, V_value);
            
            COMMIT;
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
            EXIT;
          END;
        END LOOP;
      END IF;
      UTL_FILE.FCLOSE(F);
  END;

--checking to make sure all data was inserted into table
SELECT * FROM SEED;



