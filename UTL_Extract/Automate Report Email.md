
# Steps to Create the Procedure for Email :- 
## Enable UTL_MAIL/UTL_SMTP:

Ensure the UTL_MAIL or UTL_SMTP package is enabled in your database. If not, ask your DBA to enable it:

```
sql
EXEC UTL_MAIL.INITIALIZE;
```
### Grant Required Privileges:

The user must have the following privileges:
```
sql
GRANT EXECUTE ON UTL_MAIL TO HR;
GRANT EXECUTE ON UTL_SMTP TO HR;
GRANT CREATE JOB TO your_user; -- For scheduling via DBMS_SCHEDULER
```

### Define the Procedure:

The procedure will:
Query the EMPLOYEES table.
Format the results into a string.
Send the email using the UTL_MAIL package.

### procedure Code TO SEND MAIL:- 

```
SQL
CREATE OR REPLACE PROCEDURE send_employee_report (p_dept_id number)IS
    v_email_body CLOB;
    CURSOR emp_cursor IS
        SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = p_dept_id;
BEGIN
    -- Initialize email body
    v_email_body := 'Daily Employee Report (Department):' || CHR(10) || CHR(10);

    -- Fetch rows from the cursor and append to email body
    FOR emp_rec IN emp_cursor LOOP
        v_email_body := v_email_body || 
                        'Name: ' || emp_rec.FIRST_NAME || ', ' ||
                        'Salary: ' || emp_rec.SALARY || ', ' ||
                        'Department: ' || emp_rec.DEPARTMENT_ID || CHR(10);
    END LOOP;

    -- Send the email using UTL_MAIL
    UTL_MAIL.SEND(
        sender     => 'your_email@yourdomain.com', -- Replace with your email
        recipients => 'mr.rajeshkannan@gmail.com', -- Target email
        subject    => 'Daily Employee Report',
        message    => v_email_body
    );

    DBMS_OUTPUT.PUT_LINE('Email sent successfully!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END send_employee_report;
/
```

### Schedule the Procedure to Run Daily

Use DBMS_SCHEDULER to automate this procedure to run daily.


```
Schedule Job Code:
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'DAILY_EMPLOYEE_REPORT',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN send_employee_report; END;',
        start_date      => SYSDATE,
        repeat_interval => 'FREQ=DAILY; INTERVAL=1', -- Run daily
        enabled         => TRUE
    );
END;
/
```


### Testing the Procedure


Run the procedure manually to test:

```
BEGIN
    send_employee_report;
END;
/
```
