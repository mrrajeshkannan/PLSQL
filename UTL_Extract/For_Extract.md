```
CREATE OR REPLACE PROCEDURE EXTRACT_FOR_CSV(P_YEAR NUMBER)
IS
    FILE_HANDLE UTL_FILE.FILE_TYPE;
   

BEGIN
    -- Open the file in write mode (Ensure DATA_DIR directory is created and accessible)
    FILE_HANDLE := UTL_FILE.FOPEN(location => 'DATA_DIR', filename => 'Sales_report_CSV.csv', open_mode => 'W');

    -- Write the CSV header
    UTL_FILE.PUT_LINE(FILE_HANDLE, 'YEAR,MONTH,SUPPLIER,ITEM_CODE,ITEM_DESCRIPTION,ITEM_TYPE,RETAIL_SALES,RETAIL_TRANSFERS,WAREHOUSE_SALES');

   FOR I IN (SELECT YEAR, MONTH, SUPPLIER, ITEM_CODE, ITEM_DESCRIPTION, ITEM_TYPE, RETAIL_SALES, RETAIL_TRANSFERS, WAREHOUSE_SALES 
        FROM SALES 
        WHERE YEAR = P_YEAR) 
    lOOP
        UTL_FILE.PUT_LINE(FILE_HANDLE, I.YEAR || ',' ||
                                       I.MONTH || ',' ||
                                       I.SUPPLIER || ',' ||
                                       I.ITEM_CODE || ',' ||
                                       I.ITEM_DESCRIPTION || ',' ||
                                       I.ITEM_TYPE || ',' ||
                                       I.RETAIL_SALES || ',' || 
                                       I.RETAIL_TRANSFERS || ',' ||
                                       I.WAREHOUSE_SALES);
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
END EXTRACT_FOR_CSV;
/

```
