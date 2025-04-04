Automating Performance Comparison with SQL Trace & TKPROF 🚀
We'll build a PL/SQL script that:

Enables tracing for both the old and optimized procedures.

Generates trace files.

Processes those files using TKPROF.

Outputs comparison metrics in a clean report.

🔥 Step 1: Setup Directory & Permissions
Create a Directory for Trace Files (if not already created).

sql
Copy
Edit
CREATE OR REPLACE DIRECTORY TRACE_DIR AS 'D:\trace_files';
GRANT READ, WRITE ON DIRECTORY TRACE_DIR TO HR;
🔥 Step 2: Create Procedure to Automate Performance Tracing
sql
Copy
Edit
CREATE OR REPLACE PROCEDURE compare_procedure_performance(
    p_old_proc_name   VARCHAR2,
    p_new_proc_name   VARCHAR2,
    p_params          VARCHAR2
)
IS
    old_trace_file    VARCHAR2(200);
    new_trace_file    VARCHAR2(200);
    tkprof_command    VARCHAR2(500);
BEGIN
    -- Enable SQL Trace for Old Procedure
    EXECUTE IMMEDIATE 'ALTER SESSION SET sql_trace = TRUE';
    EXECUTE IMMEDIATE 'BEGIN ' || p_old_proc_name || '(' || p_params || '); END;';
    EXECUTE IMMEDIATE 'ALTER SESSION SET sql_trace = FALSE';

    -- Find Old Procedure Trace File
    SELECT VALUE INTO old_trace_file
    FROM V$DIAG_INFO
    WHERE NAME = 'Default Trace File';

    -- Rename Old Trace File
    EXECUTE IMMEDIATE 'ALTER SESSION SET TRACEFILE_IDENTIFIER = ''OLD_PROC''';

    -- Enable SQL Trace for New Procedure
    EXECUTE IMMEDIATE 'ALTER SESSION SET sql_trace = TRUE';
    EXECUTE IMMEDIATE 'BEGIN ' || p_new_proc_name || '(' || p_params || '); END;';
    EXECUTE IMMEDIATE 'ALTER SESSION SET sql_trace = FALSE';

    -- Find New Procedure Trace File
    SELECT VALUE INTO new_trace_file
    FROM V$DIAG_INFO
    WHERE NAME = 'Default Trace File';

    -- Rename New Trace File
    EXECUTE IMMEDIATE 'ALTER SESSION SET TRACEFILE_IDENTIFIER = ''NEW_PROC''';

    -- Process Trace Files with TKPROF
    tkprof_command := 'tkprof ' || old_trace_file || ' ' || 'TRACE_DIR/old_proc_report.txt sort=exeela,fchela,prscnt';
    EXECUTE IMMEDIATE 'HOST ' || tkprof_command;

    tkprof_command := 'tkprof ' || new_trace_file || ' ' || 'TRACE_DIR/new_proc_report.txt sort=exeela,fchela,prscnt';
    EXECUTE IMMEDIATE 'HOST ' || tkprof_command;

    DBMS_OUTPUT.PUT_LINE('Performance comparison reports generated successfully in TRACE_DIR.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/
🔥 Step 3: Execute the Comparison Procedure
sql
Copy
Edit
BEGIN
    compare_procedure_performance(
        p_old_proc_name => 'OLD_PROC_NAME',   -- Replace with your old procedure name
        p_new_proc_name => 'NEW_PROC_NAME',   -- Replace with your new procedure name
        p_params        => '100000'           -- Procedure parameters (e.g., for bulk fetching)
    );
END;
/
🔥 Step 4: Review the Output Files
Check your TRACE_DIR for the generated reports:

old_proc_report.txt

new_proc_report.txt

Compare Key Metrics:
Metric	Old Procedure	New Procedure
Elapsed Time	High	Reduced
CPU Time	High	Reduced
Execute Calls	More	Less (Optimized by FORALL)
Disk Reads	More	Less (Efficient Fetching)
📌 Explanation
The procedure compare_procedure_performance automates tracing for both procedures.

The TKPROF tool generates reports sorted by Elapsed Time, CPU Time, and Execute Count.

Compare the output files to check performance improvement.

