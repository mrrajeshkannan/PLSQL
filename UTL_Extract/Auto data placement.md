# To automate the query result as a CSV file:-

Steps to Implement
Set Up Directory in Oracle:

## Oracle requires the directory to be explicitly defined and granted permissions.
Create a directory object that points to D:\Data and grant access.
Write a PL/SQL Procedure:

## Use the UTL_FILE package to write query results into a CSV file.
Format the query output as CSV.
Schedule the Procedure:

## Use the DBMS_SCHEDULER package to run the procedure daily.

--1. Create Directory Object in Oracle
```
CREATE OR REPLACE DIRECTORY data_dir AS 'D:\Data';
GRANT READ, WRITE ON DIRECTORY data_dir TO hr;

GRANT EXECUTE ON UTL_FILE TO hr;

ALTER SYSTEM SET UTL_FILE_DIR = 'D:\Data' SCOPE=SPFILE;
```

### --data_dir: Logical name for the directory.
--D:\Data: Physical directory path where the file will be saved.
--Replace your_user with the schema user who will execute the procedure


### --2. PL/SQL Procedure to Generate CSV File
```
CREATE OR REPLACE PROCEDURE generate_employee_csv 
	IS
    -- File handle for writing
    file_handle UTL_FILE.FILE_TYPE;

    -- Cursor to fetch query results
    CURSOR emp_cursor IS
        SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 50;

    -- Variables to hold fetched data
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_salary EMPLOYEES.SALARY%TYPE;
    v_department_id EMPLOYEES.DEPARTMENT_ID%TYPE;

BEGIN
    -- Open the file in write mode
    file_handle := UTL_FILE.FOPEN(location => 'DATA_DIR', filename => 'employee_report.csv', open_mode => 'W');

    -- Write the CSV header
    UTL_FILE.PUT_LINE(file_handle, 'FIRST_NAME,SALARY,DEPARTMENT_ID');

    -- Loop through cursor and write data to the CSV file
    FOR emp_rec IN emp_cursor LOOP
        UTL_FILE.PUT_LINE(file_handle,emp_rec.FIRST_NAME || ',' || emp_rec.SALARY || ',' || emp_rec.DEPARTMENT_ID);
    END LOOP;

    -- Close the file
    UTL_FILE.FCLOSE(file_handle);

    DBMS_OUTPUT.PUT_LINE('File generated successfully at D:\Data\employee_report.csv');
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions and ensure file closure
        IF UTL_FILE.IS_OPEN(file_handle) THEN
            UTL_FILE.FCLOSE(file_handle);
        END IF;
        RAISE;
END generate_employee_csv;
/
```
