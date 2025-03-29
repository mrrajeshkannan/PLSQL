SQL 
```
CREATE OR REPLACE PROCEDURE EXTRACT_NORMAL_CSV(P_YEAR NUMBER)
IS
    FILE_HANDLE UTL_FILE.FILE_TYPE;

    -- Declare variables to fetch data from cursor
    M_YEAR NUMBER;
    M_MONTH NUMBER;
    M_SUPPLIER VARCHAR2(250);
    M_ITEM_CODE NUMBER;
    M_ITEM_DESCRIPTION VARCHAR2(700);
    M_ITEM_TYPE VARCHAR2(700);
    M_RETAIL_SALES NUMBER;
    M_RETAIL_TRANSFERS NUMBER;
    M_WAREHOUSE_SALES NUMBER;

    CURSOR C1 IS 
        SELECT YEAR, MONTH, SUPPLIER, ITEM_CODE, ITEM_DESCRIPTION, ITEM_TYPE, RETAIL_SALES, RETAIL_TRANSFERS, WAREHOUSE_SALES 
        FROM SALES 
        WHERE YEAR = P_YEAR;

BEGIN
    -- Open the file in write mode (Ensure DATA_DIR directory is created and accessible)
    FILE_HANDLE := UTL_FILE.FOPEN(location => 'DATA_DIR', filename => 'Sales_report_normal.csv', open_mode => 'W');

    -- Write the CSV header
    UTL_FILE.PUT_LINE(FILE_HANDLE, 'YEAR,MONTH,SUPPLIER,ITEM_CODE,ITEM_DESCRIPTION,ITEM_TYPE,RETAIL_SALES,RETAIL_TRANSFERS,WAREHOUSE_SALES');

    OPEN C1;
    LOOP
        FETCH C1 INTO M_YEAR, M_MONTH, M_SUPPLIER, M_ITEM_CODE, M_ITEM_DESCRIPTION, M_ITEM_TYPE, 
                     M_RETAIL_SALES, M_RETAIL_TRANSFERS, M_WAREHOUSE_SALES;
        
        EXIT WHEN C1%NOTFOUND;
        
        -- Write the data to the file
        UTL_FILE.PUT_LINE(FILE_HANDLE, M_YEAR || ',' ||
                                       M_MONTH || ',' ||
                                       M_SUPPLIER || ',' ||
                                       M_ITEM_CODE || ',' ||
                                       M_ITEM_DESCRIPTION || ',' ||
                                       M_ITEM_TYPE || ',' ||
                                       M_RETAIL_SALES || ',' || 
                                       M_RETAIL_TRANSFERS || ',' ||
                                       M_WAREHOUSE_SALES);
    END LOOP;
    
    -- Close the file
    UTL_FILE.FCLOSE(FILE_HANDLE);

    DBMS_OUTPUT.PUT_LINE('File generated successfully.');

EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions and ensure file closure
        IF UTL_FILE.IS_OPEN(FILE_HANDLE) THEN
            UTL_FILE.FCLOSE(FILE_HANDLE);
        END IF;
        RAISE;
END EXTRACT_NORMAL_CSV;
/

```
