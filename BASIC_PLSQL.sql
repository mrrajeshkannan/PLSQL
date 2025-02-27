(PL/SQL)
•	It is procedural language, extension of sql
•	Basically PL/SQL is a block structured program language.
•	When ever we are submitting plsql blocks into the oracle server, all sql statement are executed within sql engine. And also procedural statement are executed within the PLSQL engine.

Topics:-
Stored procedure
Functions
Packages
Triggers
DBMS_JOBS

Fetching method:-
Cursor / for all
Bulk collect
Basics 
Block structured / Anonymous block:-
Declaration block (optional):-

Declare
A NUMBER (10);
B NUMBER (20):=50; 	/*CONSTANT VARIABLE*/

/*  EXECTION BLOCK (MANADTORY) */
BEGIN
.
.
END;

/* EXCEPTION BLOCK (OPTION) */

DBMS_OUTPUT.PUT_LINE(‘MESSAGE’ / VARIABLE)
DBMS_OUTPUT -> It is package name
PUT_LINE -> method name.



Storing into variable:-

Example:-
declare
A number(10):=10;
B varchar(10):='srk';


Begin
Dbms_output.put_line(A||'  '||B);
End;

Select into clause:-
•	This clause is used to retrieve data from table and store into pl/sql variable.
•	Select into clause is used in exection block section of PL/SQL block.
•	Select into clause always return single values (or) record at a time.
•	We can declare NOT NULL constant in declare part.


Declare
VNAME VARCHAR(20);
VSAL VARCHAR(20);

begin
SELECT FIRST_NAME, SALARY INTO VNAME,VSAL FROM EMPLOYEES WHERE SALARY=24000;
DBMS_OUTPUT.PUT_LINE(VNAME||' '||VSAL);
END;



Variable attributes:-

%type:-
•	In this method we are defining attributes for individual columns.
•	Column level attributes are represented by using percontafe (%)type.
•	Copy the first_name data type into vname.


Declare
VNAME employees.first_name%type;
VSAL employees.salary%type;

begin
SELECT FIRST_NAME, SALARY INTO VNAME, VSAL FROM EMPLOYEES WHERE SALARY=24000;
DBMS_OUTPUT.PUT_LINE(VNAME||'getting '||VSAL);
END;


%rowtype:-
•	In this method a all different datatype copy into varialble.

DECLARE
I EMPLOYEES%ROWTYPE;

BEGIN
SELECT * INTO I FROM EMPLOYEES WHERE EMPLOYEE_ID=101;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.SALARY);
END;



CONDITION STATEMENTS:-
•	If the condition satisfied given parameter will run or else statement will run.
DECLARE 
   a number(3) := 100; 
BEGIN 
   -- check the boolean condition using if statement  
   IF( a < 20 ) THEN 
      -- if condition is true then print the following   
      dbms_output.put_line('a is less than 20 ' ); 
   ELSE 
      dbms_output.put_line('a is not less than 20 ' ); 
   END IF; 
   dbms_output.put_line('value of a is : ' || a); 
END; 
/


Control Statement:-
•	A loop statement allows us to execute a statement or group of statements multiple times.
•	Incrementing by arguments is called loop.
DECLARE
N NUMBER(10):=1;
BEGIN
LOOP
DBMS_OUTPUT.PUT_LINE(N);
EXIT WHEN N>=10;
N:=N+1;
END LOOP;
END;



WHILE LOOP :-
EXAMPLE:-



DECLARE
N NUMBER(10):=1;

BEGIN
WHILE (N<=10) LOOP
DBMS_OUTPUT.PUT_LINE(N);
N:=N+1;
END LOOP;
END;




FOR LOOP :-

DECLARE 
   i number(1); 
   j number(1); 
BEGIN 
   << outer_loop >> 
   FOR i IN 1..3 LOOP 
      << inner_loop >> 
      FOR j IN 1..3 LOOP 
         dbms_output.put_line('i is: '|| i || ' and j is: ' || j); 
      END loop inner_loop; 
   END loop outer_loop; 
END; 
/

WITH OUT DECLARE PART ALSO WE CAN PROCEED IN FOR LOOP ONLY.
BEGIN 
   << outer_loop >> 
   FOR i IN 1..3 LOOP 
      << inner_loop >> 
      FOR j IN 1..3 LOOP 
         dbms_output.put_line('i is: '|| i || ' and j is: ' || j); 
      END loop inner_loop; 
   END loop outer_loop; 
END; 
/

Nested Block:-

Qualifiers / leveling :-

•	A pl / sql block written inside another PL / SQL block.
•	Nested blocks are very common when we want to perform the certain process, and at the same time, 
•	the code for these process should be kept in a separate container (block).
Advantages:-
•	To modularize the code in length.
•	To groups the blocks logically with in a single program.
 
Example :-
<<father>>
DECLARE
V_FATHERNAME VARCHAR(20):='SEKAR';        /*GLOBAL VARIABLE*/
V_DOB DATE:='20-APR-1972';


BEGIN
DECLARE
V_CHILDNAME VARCHAR(20):='RAJESH';        /*LOCAL VARIABLE*/
V_DOB DATE:='04-JUN-1990';
BEGIN
DBMS_OUTPUT.PUT_LINE('FATHER NAME:' ||V_FATHERNAME);
DBMS_OUTPUT.PUT_LINE('FATHER DOB :' ||V_DOB);
DBMS_OUTPUT.PUT_LINE('CHILD NAME:' ||V_CHILDNAME);
END;
DBMS_OUTPUT.PUT_LINE('CHILD DOB :' ||V_DOB);
END;

/

•	if a same variable name is given in outer block as well as the same variable in the inner block, then it will not take the outer block.
•	To over come we can use some qualifiers that is we will give some name to the pl sql block.

CURSOR:-

•	It is record by record process.
•	It is a temporary memory area.
•	Before giving the output it is first processed inside the cursor, which is temporary memory area.
•	In PL/SQL, the context area is controlled by Cursor.
•	The major function of a cursor is to retrieve data, one row at a time, from a result set, unlike the SQL commands which operate on all the rows in the result set at one time. Cursors are used when the user needs to update records in a singleton fashion or in a row by row manner, in a database table.
The Data that is stored in the Cursor is called the Active Data Set. Oracle DBMS has another predefined area in the main memory Set, within which the cursors are opened. Hence the size of the cursor is limited by the size of this pre-defined area.


Types of cursor:-
Implicit cursor.
•	It is a default cursor
•	Automatically allocated by ORACLE.

Explicit cursor.
•	It is created by user whenever you need it.

Implisit cursor :-
•	WHEN ever we do DML operation then automatically ORACLE open and close the cursor that is an implicit cursor is created.
Attributs:-
•	SQL%FOUND
•	SQL%NOTFOUND
•	SQL%ROWCOUNT
•	SQL%ISOPEN
IS%OPEN always returns FALSE fro implicit cursors and therefore, DML statements. Because the oracle database opens and close their coursors automatically.
BEGIN
DELETE FROM EMP WHERE DEPARTMENT_ID=100;
IF SQL%FOUND THEN
DBMS_OUTPUT.PUT_LINE(‘UR RECORD IS DELETED’);
ELSE IF SQL%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE(‘UR RECORD IS NOT FOUND’);
ENDIF;
END;

How to use Explicit Cursor?
There are four steps in using an Explicit Cursor.
1.	DECLARE the cursor in the Declaration section.
2.	OPEN the cursor in the Execution Section.
3.	FETCH the data from the cursor into PL/SQL variables or records in the Execution Section.
4.	CLOSE the cursor in the Execution Section before you end the PL/SQL Block.
Syntax:


Explicit cursor:-
•	Programmers are allowed to create named context area to execute their DML operations to get more control over it.
•	user need to use manually declare, open, fetch and close.
Life cycle:-
Declare.
Open.
Fetch.
Close.
Example:-
DECLARE
CURSOR C1 IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=90;
i EMPLOYEES%ROWTYPE;

BEGIN
OPEN C1;
FETCH C1 INTO i;
DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME||' '||i.SALARY);
FETCH C1 INTO i;
DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME||' '||i.SALARY);
CLOSE C1;
END;


 
Output:-
Steven 24000
Neena 17000

Statement processed.


Feature	Implicit Cursor	Explicit Cursor
Definition	Automatically created by Oracle for single SQL statements (e.g., SELECT, INSERT, UPDATE, DELETE).	User-defined and explicitly declared by the programmer for managing queries.
Declaration	No declaration required; Oracle handles it internally.	Must be declared in the DECLARE section of a PL/SQL block, package, or procedure.
Usage Scope	Limited to single-row operations or simple SQL statements.	Used for handling multi-row queries or more complex operations.
Control	Fully managed by Oracle; no manual OPEN, FETCH, or CLOSE required.	Programmer explicitly controls the cursor using OPEN, FETCH, and CLOSE.
Example	SELECT salary INTO var_salary FROM employees WHERE employee_id = 101;	DECLARE CURSOR c1 IS SELECT * FROM employees; BEGIN OPEN c1; FETCH c1 INTO var1, var2; CLOSE c1; END;
Error Handling	Automatically raises exceptions like NO_DATA_FOUND or TOO_MANY_ROWS.	Requires explicit checks for conditions like %NOTFOUND, %FOUND, or %ROWCOUNT.
Flexibility	Limited to single-row operations or direct processing.	Highly flexible, allowing precise control over multi-row operations and data manipulation.
Performance	Best suited for single-row queries and direct database interactions.	Better for complex queries, multi-row processing, or iterative operations.
Memory Management	Oracle automatically manages memory.	Programmer is responsible for managing cursor lifecycle to avoid resource leaks.
% Attributes Availability	%FOUND, %NOTFOUND, %ISOPEN, %ROWCOUNT are available for DML operations only.	%FOUND, %NOTFOUND, %ISOPEN, %ROWCOUNT are available for query result control.
Examples of Use Cases	Directly assigning query results to variables, such as in SELECT INTO.	Iterating over a result set, performing operations on each row.
Learning Curve	Easier to use and suitable for simple queries.	Requires understanding of cursor control and lifecycle for effective use.



Attributes of explicit cursor:-

•	%notfound
•	%Found
•	%Rowcount
•	%isopen
% not found:-

DECLARE
CURSOR C1 IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES;
FNAME EMPLOYEES.FIRST_NAME%TYPE;
VSAL EMPLOYEES.SALARY%TYPE;

BEGIN
OPEN C1;
LOOP
FETCH C1 INTO FNAME,VSAL;
DBMS_OUTPUT.PUT_LINE(FNAME||' '||VSAL);
EXIT WHEN C1%NOTFOUND;
END LOOP;
CLOSE C1;
END;



%FOUND:-
DECLARE
CURSOR C1 IS SELECT * FROM EMPLOYEES;
i EMPLOYEES%ROWTYPE;

BEGIN
OPEN C1;
LOOP
FETCH C1 INTO i;
DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME);
EXIT WHEN C1%FOUND;
END LOOP;
CLOSE C1;
END;


Steven

Statement processed.

% ROWCOUNT:-

DECLARE
CURSOR C1 IS SELECT * FROM EMPLOYEES;
i EMPLOYEES%ROWTYPE;

BEGIN
OPEN C1;
LOOP
FETCH C1 INTO i;
DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME);
EXIT WHEN C1%ROWCOUNT=5;
END LOOP;
CLOSE C1;
END;

Steven
Neena
Lex
Alexander
Bruce

Statement processed.


%ISOPEN :-
DECLARE
CURSOR C1 IS SELECT * FROM EMPLOYEES;
i EMPLOYEES%ROWTYPE;

BEGIN
IF NOT C1%ISOPEN THEN 
OPEN C1;
LOOP
FETCH C1 INTO i;
DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME);
EXIT WHEN C1%ROWCOUNT=3;
END LOOP;
CLOSE C1;
END;



Parameterized cursor:-

declare 
cursor C1(DP number) is select * from employees where DEPARTMENT_ID= DP;
I EMPLOYEES%ROWTYPE;

BEGIN
OPEN C1(100);
DBMS_OUTPUT.PUT_LINE('FIRST_NAME'||'     ' || 'SALARY');
LOOP

FETCH C1 INTO I;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||'          ' || I.SALARY);
EXIT WHEN C1%NOTFOUND;

END LOOP;
CLOSE C1;
END;


FIRST_NAME     SALARY
Nancy          12000
Daniel          9000
Eliminating lifecycle of cursor using for:-

Example 1:-
DECLARE
CURSOR C1 IS SELECT * FROM EMPLOYEES;
BEGIN
FOR I IN C1 LOOP
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||'    '||I.SALARY);
END LOOP;
END;



Example 2:-
BEGIN
FOR I IN (SELECT * FROM EMPLOYEES) LOOP
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME);
END LOOP;
END;




Current of clause :-
•	When we not use current of clause it will update how many duplicate having that times it will update.
•	To overcome we have to use current of curser name;
Sample table 
EMPID	SALARY
B	2000
B	5000
A	1000
C	3000
A	4000
C	6000

DECLARE
CURSOR C1 IS SELECT * FROM T3;
BEGIN
FOR I IN C1 LOOP
UPDATE T3 SET SALARY  = SALARY+100 WHERE EMPID = I.EMPID;
END LOOP;
END;

AFTER RUN UPDATE QUERY THE DATA WILL BE 
EMPID	SALARY
B	2200
B	5200
A	1200
C	3200
A	4200
C	6200


It updated 2 times in duplicate employee id, to overcome this we have to use CURRENT OF C1;

DECLARE
CURSOR C1 IS SELECT * FROM T3;
BEGIN
FOR I IN C1 LOOP
UPDATE T3 SET SALARY  = SALARY+100 WHERE EMPID = CURRENT OF C1;
END LOOP;
END;



Ref cursors:-
A REF CURSOR (short for Reference Cursor) is a pointer to a result set that is returned by a query. It allows you to pass query results between PL/SQL blocks or between PL/SQL and client applications (like Java, .NET, etc.). REF CURSORs provide more flexibility compared to traditional explicit cursors.
	Static cursor is associated with single SQL query. It is not flexible that is why use dynamic cursor called as         ref cursor to use same cursor for different queries.
•	Ref cursors data type allows developers to declare cursor variable.
•	A cursor variable can be used with static or dynamic SQL statements to implement more flexible programs.
•	Generally in static cursor database servers execute only one select statement at a time for a single active set area.
•	Where ref cursor database services execute number of select statement dynamically for a single active set area.
•	That’s why this cursor is also called as dynamic cursors.
•	Generally we are not allowed to pass static cursor as parameter to some programs.
•	To overcome this problem oracle induced ref cursor which is used to pass parameter to some programs because basically ref cursor. Is a user defined type.
•	Generally static cursor don’t return multiple values into the client application where as refer returns multiple values into client application.

Type of Ref Cursor:-
1.	Strong ref cursor.
2.	Weak ref cursor.
EXAMPLE 
TYPE cursor_type IS REF CURSOR; -- Weakly typed
TYPE emp_cursor IS REF CURSOR RETURN EMPLOYEES%ROWTYPE; -- Strongly typed

weak Refcursor:-

Example:-
DECLARE
V1 SYS_REFCURSOR;
I EMPLOYEES%ROWTYPE;
BEGIN
OPEN V1 FOR SELECT * FROM EMPLOYEES;
LOOP
FETCH V1 INTO I;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME);
EXIT WHEN V1%NOTFOUND;
END LOOP;
CLOSE V1;
END;

Strong Refcursor:-
DECLARE
TYPE T1 IS REF CURSOR RETURN EMPLOYEES%ROWTYPE;
V1 T1;
I EMPLOYEES%ROWTYPE;
BEGIN
OPEN V1 FOR SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=90;
LOOP
FETCH V1 INTO I;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME);
EXIT WHEN V1%NOTFOUND;
END LOOP;
CLOSE V1;
END;



Example of Cursor:-
declare    
    cursor c1 is select first_name, salary from hr.employees;
begin    
    for c in c1 
    loop
        dbms_output.put_line('Ename: ' || c.first_name || ', Salary: ' || c.salary);
    end loop;
end;
/

Example of Ref Cursor:-
declare    
    c1 SYS_REFCURSOR;
    ename varchar2(10);
    sal number;
begin
    open c1 for select first_name, salary from hr.employees;
    LOOP 
        FETCH c1 into ename, sal;
            EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line('Ename: ' || first_name || ', Salary: ' || salary);
    END LOOP;
    close c1;    
end;
/

Technically, They are both cursors and can be processed in the same fashion and at the most basic level, they both are same. There are some important differences between regular cursors and ref cursors which are following: 

1) A ref cursor can not be used in CURSOR FOR LOOP, it must be used in simple CURSOR LOOP statement as in example.

2) A ref cursor is defined at runtime and can be opened dynamically but a regular cursor is static and defined at compile time.

3) A ref cursor can be passed to another PL/SQL routine (function or procedure) or returned to a client. A regular cursor cannot be returned to a client application and must be consumed within same routine.

4) A ref cursor incurs a parsing penalty because it cannot cached but regular cursor will be cached by PL/SQL which can lead to a significant reduction in CPU utilization.

5) A regular cursor can be defined outside of a procedure or a function as a global package variable. A ref cursor cannot be; it must be local in scope to a block of PL/SQL code.

6) A regular cursor can more efficiently retrieve data than ref cursor. A regular cursor can implicitly fetch 100 rows at a time if used with CURSOR FOR LOOP. A ref cursor must use explicit array fetching.

My recommendation on ref cursors:
Use of ref cursors should be limited to only when you have a requirement of returning result sets to clients and when there is NO other efficient/effective means of achieving the goal.



Stored Procedures :-
Stored Procedures:-
•	It is named block, used to do particular task use to solve.
•	It may (or) may not return a value.
•	IT require to return an output then it does not do so from a RETURN statement.
•	The RETURN statement is never associated with an expression
•	It is not mandatory in procedure unlike function.
•	RETURN may be used in procedure but without an expression only to end the execution of the procedure and pass the control to the calling program
•	It is onetime complalitation.
It has two parts:-
•	Specification-Declare, create procedures,
•	Pass parameters etc.
•	Body-we will do the task.


Properties of procedures:-
•	Not required to declare the RETURN DATA TYPE.
•	It is a standalone executable statement.
When should use procedure:-
•	In all such situations where function may be used but not vice versa.
•	Where no output is required we can use procedure.
•	Multiple output are required we an use procedure.
•	More appropriate when program needs to contain cursor of any form, no of outputs to return.
To see pre procedure program:-
SELECT * FROM user_source;


Basic procedure program:-


CREATE OR REPLACE PROCEDURE P1
AS
I EMPLOYEES%ROWTYPE;
BEGIN
SELECT * INTO I FROM EMPLOYEES WHERE EMPLOYEE_ID=100;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME);
END;

TO EXECUTE THE PROCEDURE CALL THE PROCEDURE NAME:

BEGIN
P1;
END;




DECLARE

CURSOR C1 IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID=90;

P_FIRST varchar2(30);
p_salary number(10);

BEGIN
OPEN C1;
LOOP
FETCH C1 INTO P_FIRST,p_salary;
EXIT WHEN C1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(P_FIRST||' '||p_salary);

END LOOP;
CLOSE C1;
END;
/

Output :- 

Steven 24000
Neena 17000
Lex 17000


DECLARE 

P_FIRST_NAME VARCHAR2(100);  --EMPLOYEES.FIRST_NAME%TYPE;
P_SALARY NUMBER(10);
P_DEPARTMENT_NAME VARCHAR2(30);

CURSOR C1 IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID=90;

CURSOR C2 IS SELECT DEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID=90;

BEGIN

OPEN C1;
LOOP
FETCH C1 INTO P_FIRST_NAME,P_SALARY;
EXIT WHEN C1%NOTFOUND;
OPEN C2;
FETCH C2 INTO P_DEPARTMENT_NAME;
CLOSE C2;

DBMS_OUTPUT.PUT_LINE(P_FIRST_NAME||' '||P_SALARY||' '||P_DEPARTMENT_NAME);
END LOOP;
CLOSE C1;
END;
/

Output :-
Steven 24000 Executive
Neena 17000 Executive
Lex 17000 Executive

Eliminating lifecycle of cursor using for:-

Example 1:-
DECLARE
CURSOR C1 IS SELECT * FROM EMPLOYEES;
BEGIN
FOR I IN C1 LOOP
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||'    '||I.SALARY);
END LOOP;
END;



Example 2:-
BEGIN
FOR I IN (SELECT * FROM EMPLOYEES) LOOP
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME);
END LOOP;
END;




Parameter passing in procedures:-

In PARAMETER :-
CREATE OR REPLACE PROCEDURE P1(VDEPTID IN NUMBER)
AS
CURSOR C1 IS SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=VDEPTID;
I EMPLOYEES%ROWTYPE;

BEGIN
OPEN C1;
LOOP
FETCH C1 INTO I;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||I.SALARY);
EXIT WHEN C1%NOTFOUND;
END Loop;
CLOSE C1;
END;

TO EXECUTE RESULT:
BEGIN
 P1(90);
END;


Out parameter:-
CREATE OR REPLACE PROCEDURE P1(VEMPID IN NUMBER, FNAME OUT VARCHAR)
AS
BEGIN
SELECT FIRST_NAME INTO FNAME FROM EMPLOYEES WHERE EMPLOYEE_ID=VEMPID;
END;
DECLARE 
X VARCHAR(20);
BEGIN
P1(100,X);
DBMS_OUTPUT.PUT_LINE(X);
END;


IN & OUT PARAMETER:-

CREATE OR REPLACE PROCEDURE P1 (V_EMPID NUMBER, X OUT VARCHAR, Y OUT VARCHAR, S OUT NUMBER)
AS
BEGIN
SELECT FIRST_NAME, LAST_NAME, SALARY INTO X,Y,S
FROM EMPLOYEES WHERE EMPLOYEE_ID = V_EMPID;
END;

DECLARE
X VARCHAR (20);
Y VARCHAR (20);
S NUMBER(10);
BEGIN
P1(200,X,Y,S);
DBMS_OUTPUT.PUT_LINE(X||Y|| ' SALARY IS '||S);
END;





Functions :-
•	Named subprogram in PL/SQL, with his compulsorily return at least one value.  
•	Which are used to solve the particular task.
•	There may be a multiple RETURN statement in a function but only one of them must execute to return output. 
•	A function can be used as a part of SQL expression.
•	Use of CURSOR in PL/SQL violets it purity and restricts is use.
•	Function can perform DML operation only with 





Diff b/w procedure and Function:-
Aspect	Procedure	Function
Return Value	Does not return a value directly. (It can use OUT parameters to return values.)	Must return a single value using the RETURN statement.
Parameters	Supports IN, OUT, and IN OUT parameters.	Supports only IN parameters.
Return Type	No mandatory return type.	Must specify a RETURN type (e.g., NUMBER, VARCHAR2).
Usage in SQL Queries	Cannot be called directly in SQL queries like SELECT.	Can be called directly in SQL queries such as SELECT, WHERE, and ORDER BY clauses (if the function is deterministic).
Syntax for Call	EXEC procedure_name or BEGIN procedure_name; END;	SELECT function_name(args) FROM DUAL;
Calling Mechanism	Called as a standalone statement.	Called as part of an expression or query.
Purpose	Used to perform an action or execute a series of steps.	Used to compute and return a value.
Exception Handling	Can handle exceptions internally.	Can handle exceptions internally and propagate errors to calling code.


SELECT * FROM ALL_OBJECTS

To CALCULATOR FUNCTION:-
CREATE OR REPLACE FUNCTION CALC(A NUMBER, B NUMBER, OP VARCHAR) 
RETURN NUMBER
AS 
BEGIN
   IF OP='+' THEN
RETURN(A+B);
  ELSIF OP='-' THEN
RETURN (A-B);
  ELSIF OP='*' THEN
RETURN (A*B);
  ELSE 
 RETURN(A/B);
END IF;
END;

select CALC(102,103, '+') FROM DUAL;




EXAMPLE: CREATE A SUBPROGRAM FOR CALCULATE ANUL SALARY FOR EMPLOYEES
CREATE OR REPLACE FUNCTION EMP_TAX(VTAX EMPLOYEES.SALARY%TYPE) RETURN VARCHAR2
AS

ANUL_TAX NUMBER;
TAX NUMBER;

BEGIN
   ANUL_TAX := (VTAX * 12);
RETURN ANUL_TAX;

END;
Out put for the above function is below.
SELECT FIRST_NAME, EMP_TAX(SALARY)AS ANUL_SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = 60;
FIRST_NAME	ANUL_SALARY
Alexander	108000
Bruce	72000
David	57600
Valli	57600
Diana	50400


Example of calculate tax of all employees:-
CREATE OR REPLACE FUNCTION EMP_TAX(VTAX EMPLOYEES.SALARY%TYPE) RETURN VARCHAR2
AS

ANUL_TAX NUMBER;
TAX NUMBER;

BEGIN
   ANUL_TAX := (VTAX * 12);

IF ANUL_TAX < 50000 THEN 
TAX:= (ANUL_TAX * 5) /100;
RETURN TAX;

ELSIF ANUL_TAX between 50000 AND 100000 THEN 
TAX:= (ANUL_TAX * 10) /100;
RETURN TAX;

ELSIF ANUL_TAX between 100001 AND 150000 THEN 
TAX:= (ANUL_TAX * 20) /100;
RETURN TAX;

END IF;
END;
/


SELECT FIRST_NAME, EMP_TAX(SALARY)AS ANVAL_SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = 60;

FIRST_NAME	MONTH_SALARY	ANUAL_TAX
Alexander	9000	21600
Bruce	6000	7200
David	4800	5760
Valli	4800	5760
Diana	4200	5040

Creating a function to convert decimal number.
CREATE OR REPLACE FUNCTION F1(V_EMPID NUMBER) RETURN VARCHAR2
AS
I VARCHAR(20);
BEGIN
SELECT TO_CHAR(SALARY,'99999999.99') INTO I FROM EMPLOYEES WHERE EMPLOYEE_ID=V_EMPID;
RETURN I;
END;



SELECT F1(102) FROM DUAL;




create or replace FUNCTION TOTAL_SALE(IN_MON INTGER) RETURN NUMBER
IS
TOTAL_SALE := 0;
BEGIN
SELECT SUM(UNIT_PRICE * QUANDITY) INTO TOTAL_SALE 
FROM ORDER WHERE STATUS = 'SHIPPED' 
GROUP BY PARTY_ID WHERE TO_CHAR(DATE,'MON')= IN_MON;

RETURN TOTAL_SAL;
END;

SELECT TOTAL_SALE('JAN') FROM DUAL;

CREATE OR REPLACE FUNCTION FN_MGR_NAME(P_EMP_ID NUMBER) RETURN VARCHAR2

IS

CURSOR C1 IS select FIRST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID=(SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=P_EMP_ID);

M_NAME VARCHAR2(70);

BEGIN

        IF C1%ISOPEN THEN CLOSE C1;
        END IF;
        
        OPEN C1;
        FETCH C1 INTO M_NAME;
        CLOSE C1;
        RETURN(M_NAME);
END  FN_MGR_NAME;





COLLECTIONS:-
•	A collection is an ordered group of elements having the same data type.
•	Each element is identified by a unique subscript that represents its position in the collection.

PL/SQL provides three collection types −
•	Index-by tables or Associative array
•	Nested table
•	Variable-size array or Varray




Oracle documentation provides the following characteristics for each type of collections −
Collection Type	Number of Elements	Subscript Type	Dense or Sparse	Where Created	Can Be Object Type Attribute
Associative array (or index-by table)	Unbounded	String or integer	Either	Only in PL/SQL block	No
Nested table	Unbounded	Integer	Starts dense, can become sparse	Either in PL/SQL block or at schema level	Yes
Variablesize array (Varray)	Bounded	Integer	Always dense	Either in PL/SQL block or at schema level	Yes

Index-by tables or Associative array :-


DECLARE
TYPE V_FIRST_NAME IS TABLE OF VARCHAR2(50);
TYPE V_SALARY IS TABLE OF VARCHAR2(10);
M_FIRST_NAME V_FIRST_NAME;
M_SALARY V_SALARY;
BEGIN
SELECT FIRST_NAME,SALARY 
        BULK COLLECT INTO M_FIRST_NAME, M_SALARY 
        FROM EMP;
FOR I IN 1..M_FIRST_NAME.COUNT LOOP
DBMS_OUTPUT.PUT_LINE(M_FIRST_NAME(I)||' '||M_SALARY(I));
END LOOP;
END;
/

Another Example:-
declare
CURSOR C_EMPLOYEES IS
SELECT FIRST_NAME FROM EMPLOYEES;

TYPE C_LIST IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER;
NAME_LIST C_LIST;

COUNTER INTEGER :=0;

BEGIN
FOR N IN C_EMPLOYEES LOOP
COUNTER :=COUNTER+1;
NAME_LIST (COUNTER):=N.FIRST_NAME;

DBMS_OUTPUT.PUT_LINE (NAME_LIST(COUNTER));
END LOOP;
END;

Nested Table:-
The following examples illustrate the use of nested table –
DECLARE 
   TYPE names_table IS TABLE OF VARCHAR2(10); 
   TYPE grades IS TABLE OF INTEGER;  
   names names_table; 
   marks grades; 
   total integer; 
BEGIN 
   names := names_table('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz'); 
   marks:= grades(98, 97, 78, 87, 92); 
   total := names.count; 
   dbms_output.put_line('Total '|| total || ' Students'); 
   FOR i IN 1 .. total LOOP 
      dbms_output.put_line('Student:'||names(i)||', Marks:' || marks(i)); 
   end loop; 
END; 
/  

Total 5 Students 
Student:Kavita, Marks:98 
Student:Pritam, Marks:97 
Student:Ayan, Marks:78 
Student:Rishav, Marks:87 
Student:Aziz, Marks:92  

PL/SQL procedure successfully completed. 


Select * from customers;  

+----+----------+-----+-----------+----------+ 
| ID | NAME     | AGE | ADDRESS   | SALARY   | 
+----+----------+-----+-----------+----------+ 
|  1 | Ramesh   |  32 | Ahmedabad |  2000.00 | 
|  2 | Khilan   |  25 | Delhi     |  1500.00 | 
|  3 | kaushik  |  23 | Kota      |  2000.00 | 
|  4 | Chaitali |  25 | Mumbai    |  6500.00 | 
|  5 | Hardik   |  27 | Bhopal    |  8500.00 | 
|  6 | Komal    |  22 | MP        |  4500.00 | 

DECLARE 
   CURSOR c_customers is  
      SELECT  name FROM customers;  
   TYPE c_list IS TABLE of customerS.No.ame%type; 
   name_list c_list := c_list(); 
   counter integer :=0; 
BEGIN 
   FOR n IN c_customers LOOP 
      counter := counter +1; 
      name_list.extend; 
      name_list(counter)  := n.name; 
      dbms_output.put_line('Customer('||counter||'):'||name_list(counter)); 
   END LOOP; 
END; 
/ 
Customer(1): Ramesh  
Customer(2): Khilan  
Customer(3): kaushik     
Customer(4): Chaitali  
Customer(5): Hardik  
Customer(6): Komal  




DECLARE
TYPE T1 IS TABLE OF NUMBER(10);
V1 T1; /*IF YOU WRITE T1 WITHOUT ANY SUBSCRIPT THEN IT WILL BE 				CONSIDERED AS NULL*/
V2 T1:=T1(); /*IF YOU WRITE T1:=T1() THAT MEANS THERE IS SOME VALUE AND IT IS NOT NULL*/
BEGIN
IF V1 IS NULL THEN
DBMS_OUTPUT.PUT_LINE('V1 IS NULL');
ELSE
DBMS_OUTPUT.PUT_LINE('V1 IS NOT NULL');
END IF;
IF V2 IS NULL THEN
DBMS_OUTPUT.PUT_LINE('V2 IS NULL');
ELSE
DBMS_OUTPUT.PUT_LINE('V2 IS NOT NULL');
END IF;
END


V array / variable size array:-

Is a limit to variable size that is bounded


DECLARE
TYPE GREENS IS VARRAY(3) OF VARCHAR(30);
I GREENS;

BEGIN
I:=GREENS('S','R','K');
DBMS_OUTPUT.PUT_LINE(I.COUNT);
END;

COLLECTION METHOD:-

There are some collection methods are available those are
COUNT, FIRST, LAST, PRIOR, NEXT, DELETE, EXIST, TRIM, EXTEND, LIMIT
DECLARE
TYPE GREENS IS VARRAY(5) OF VARCHAR(30);
I GREENS;

BEGIN
I:=GREENS('RAJESH','KANNAN','RAJI', 'KUMAR');
DBMS_OUTPUT.PUT_LINE(I.COUNT);

DBMS_OUTPUT.PUT_LINE(I.FIRST);
DBMS_OUTPUT.PUT_LINE(I.LAST);

DBMS_OUTPUT.PUT_LINE(I.PRIOR(3));

END;

Bulk collect:
•	When ever source table having large amount of data and also if we are tranfering data using cursor then automatically performance will decrees, because cursor internally uses record by record process.
•	To overcome this if we want to improve performance of the application introduce bulk collect.
SQL> DECLARE

  2      TYPE TObjectTable$ IS TABLE OF ALL_OBJECTS%ROWTYPE;
  3      ObjectTable$ TObjectTable$;

  4  BEGIN

  5  -- Populate collection
  6    SELECT *
  7    BULK COLLECT INTO ObjectTable$
  8    FROM   ALL_OBJECTS;
  9
 10  -- Insert
 11     FORALL x IN ObjectTable$.FIRST..ObjectTable$.LAST
 12     INSERT INTO t1 VALUES ObjectTable$(x);
 13
 14  -- Delete
 15     FORALL x IN ObjectTable$.FIRST..ObjectTable$.LAST
 16     DELETE FROM t2 WHERE t2.object_id = ObjectTable$(x).object_id;
 17
 18
 19  END;
 20  /



create or replace FUNCTION FN_DEPT_NAME(P_DEPT NUMBER) RETURN VARCHAR2
IS 
TYPE C1 IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;

 M_DEPT_NAME C1;

BEGIN 
select DEPARTMENT_NAME BULK COLLECT INTO M_DEPT_NAME from departments where department_id=P_DEPT;

     FOR I IN M_DEPT_NAME.FIRST..M_DEPT_NAME.LAST  LOOP
            RETURN(M_DEPT_NAME(I));
            END LOOP;
END FN_DEPT_NAME;


Example:-
DECLARE
TYPE GREENS IS TABLE OF VARCHAR(20) INDEX BY BINARY_INTEGER;
CURSOR C1 IS SELECT FIRST_NAME FROM EMPLOYEES;
V1 GREENS;

BEGIN
OPEN C1;
FETCH C1 BULK COLLECT INTO V1 /*LIMIT 50*/;
FOR I IN V1.FIRST..V1.LAST LOOP
DBMS_OUTPUT.PUT_LINE(V1(I));
END LOOP;
CLOSE C1;
END; 

Some extra point
Bulk collect in select method:-

•	Use in bulk collect clause in oracle server select column at a time and store date into saprate space
•	This process automatically improves perfomace of the applicaton.




DECLARE
TYPE GREENS IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
V1 GREENS;

BEGIN
SELECT FIRST_NAME BULK COLLECT INTO V1 FROM EMPLOYEES;
FOR I IN V1.FIRST..V1.LAST LOOP
DBMS_OUTPUT.PUT_LINE(V1(I));
END LOOP;
END;

CREATE OR REPLACE FUNCTION FN_DEPT_NAME(P_DEPT NUMBER) RETURN VARCHAR2
IS 
TYPE C1 IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;

 M_DEPT_NAME C1;

BEGIN 
select DEPARTMENT_NAME BULK COLLECT INTO M_DEPT_NAME from departments where department_id=P_DEPT;

     FOR I IN M_DEPT_NAME.FIRST..M_DEPT_NAME.LAST  LOOP
            RETURN(M_DEPT_NAME(I));
            END LOOP;
END FN_DEPT_NAME;




BULK COLLECT IN DML:-
•	WE can also store dml transaction value into variables using retuning into clauses. That why retring into clause are used only in DML statement.
DECLARE
TYPE GREENS IS TABLE OF NUMBER(20) INDEX BY BINARY_INTEGER;
V1 GREENS;

BEGIN
UPDATE EMP1 SET SALARY =SALARY+100 WHERE DEPARTMENT_ID=90 RETURNING SALARY BULK COLLECT INTO V1;
FOR I IN 1..V1.COUNT LOOP
DBMS_OUTPUT.PUT_LINE(V(I));
END LOOP;
END;


BULK BIND / FOR ALL STATEMENT:-
•	PROCESS ALL DATE IN A COLLECTION AT A TIME USING SQL ENGINE THROUGH for all statements.
•	Once data is available in collection we can process this data at a time using sql engine. In this case we must use forall statement.
DECLARE
TYPE GREENS IS VARRAY(10) OF NUMBER(10);
V1 GREENS:=GREENS(10,20,30,40,50);

BEGIN
FOR ALL I IN V1.FIRST..V1.LAST
UPDATE EMP1 SET SALARY=SALARY+100 WHERE DEPARTMENT_ID=V1(I);
END;



Bulkbind with saved exception:-

•	We are fetching the data from the table into collection using bulk collect.
•	This collection data we are processing when ever we use save exception in the for all statement automatically whatever error occurred is stored.
•	Adding save exception clause oracle server automatically create predefind index by table that is SQL%bulk_exceptions.
•	It has only one collection method that is count.
DECLARE
TYPE T1 IS TABLE OF NUMBER(10);
V1 T1:=T1(10,20,30,40,50);
Z NUMBER (20);
BEGIN
V1 (3):=NULL;
V1 (4):=NULL;
FORALL I IN V1.FIRST..V1.LAST SAVE EXCEPTIONS
INSERT INTO EMP1 VALUES(V1(I));

EXCEPTION
WHEN OTHERS THEN Z:=SQL%BULK_EXCEPTIONS.COUNT;
DBMS_OUTPUT.PUT_LINE(Z);
END;





Trigger:-
•	A trigger is a stored procedure in database which is  automatically FIRE/ invokes when an event occurs in the database.

•	The event can be a DDL/DML/SYSTEM EVENT

•	Triggers should not contain transaction control statements like commit, rollback, save point or set transaction.

•	Because it is fired as part of the execution of the triggering statement.

•	When the trigger fires the current transaction is still not complete.

•	IF commit allowing in trigger statement would break the unit of work..

•	We can create 2 or more trigger for single table.


Ex:if we create 4 trigger in same table the below sequence order only it will run 

1.Statement before insert, 2.row Before insert, 3.row after insert, 4. statement after insert.

Ex: if no row affected in update means only statement trigger will execute 

1.Statement before insert, 2. statement after insert.


Type of Triggers
1.	DML Trigger   (Row level ,  Statement level )
2.	DDL Trigger
3.	SYSTEM Trigger
4.	Instead of Trigger
5.	Compound Trigger
Level Triggers
There are 2 different types of level triggers, they are:
1.	ROW LEVEL TRIGGERS
•	It fires for every record that got affected with the execution of DML statements like INSERT, UPDATE, DELETE etc.
•	It always use a FOR EACH ROW clause in a triggering statement.
2.	STATEMENT LEVEL TRIGGERS
•	It fires once for each statement that is executed.
Event Triggers
There are 3 different types of event triggers, they are:
1.	DDL EVENT TRIGGER
•	It fires with the execution of every DDL statement(CREATE, ALTER, DROP, TRUNCATE).
2.	DML EVENT TRIGGER
•	It fires with the execution of every DML statement(INSERT, UPDATE, DELETE).
3.	DATABASE EVENT TRIGGER
•	It fires with the execution of every database operation which can be LOGON, LOGOFF, SHUTDOWN, SERVERERROR etc.
Timing Triggers
There are 2 different types of timing triggers, they are:
1.	BEFORE TRIGGER
•	It fires before executing DML statement.
•	Triggering statement may or may not executed depending upon the before condition block.
2.	AFTER TRIGGER
•	It fires after executing DML statement.

BEFORE and AFTER of Trigger:
•	BEFORE triggers run the trigger action before the triggering statement is run.
•	AFTER triggers run the trigger action after the triggering statement is run.

To see pre Trigger program:-
SELECT * FROM user_source;

SELECT * FROM user_triggers;


Statement level trigger:-
•	One statement processed trigger will fire.
Example:-
CREATE OR REPLACE TRIGGER T1
AFTER DELETE OR UPDATE ON EMP
BEGIN
DBMS_OUTPUT.PUT_LINE(‘STATEMENT LEVEL’);
END;

Row Level Trigger:-
•	For each row trigger will work.
Example:-
create trigger stud_marks 
before INSERT on Student 
for each row 
set Student.total = Student.subj1 + Student.subj2 + Student.subj3, Student.per = Student.total * 60 / 100;


QUALIFIERS:-

New :- it holds new values of the column.
Old :- it holds old values of the column.

Example : for fire a error (ORA-20213 cant insert less then 5000)

CREATE OR REPLACE TRIGGER T1 
AFTER DELETE OR UPDATE ON EMP1
FOR EACH ROW
BEGIN
INSERT INTO EMP2 (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
            VALUES(:OLD.EMPLOYEE_ID, :OLD.FIRST_NAME, :OLD.LAST_NAME, :OLD.EMAIL, :OLD.PHONE_NUMBER, :OLD.HIRE_DATE, :OLD.JOB_ID, :OLD.SALARY,
            :OLD.COMMISSION_PCT, :OLD.MANAGER_ID, :OLD.DEPARTMENT_ID);
END;

Example for old and new values show:
CREATE OR REPLACE TRIGGER T1
BEFORE INSERT OR UPDATE ON EMP1
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE ('THE OLD VALUE IS' ||:OLD.SALARY);
DBMS_OUTPUT.PUT_LINE ('THE NEW VALUE IS' ||:NEW.SALARY);
END;

Above example show OLD salary & NEW salary also.
Create Trigger to inserting all values in CAPS:-
CREATE OR REPLACE TRIGGER T1
BEFORE INSERT OR UPDATE ON EMP
FOR EACH ROW
BEGIN
:NEW.FIRST_NAME:=UPPER(:NEW.FIRST_NAME);
END;



Logon logoff Triggers:-

CREATE TABLE AUDIT_LOG(USER_NAME VARCHAR(20), LOGON TIMESTAMP, LOGGOFF TIMESTAMP);


create or replace trigger t1
after logon on schema
begin
insert into AUDIT_LOG values(user, sysdate, NULL);
END;

create or replace trigger t2
BEFORE LOGOFF on schema
begin
insert into AUDIT_LOG values(user, sysdate, NULL);
END;

Logging table:-
create table logon_off_audit(
user_id varchar2(30),
session_id number(8),
host varchar2(30),
last_program varchar2(48),
last_action varchar(32),
last_module varchar(32),
logon_date date,
logon_time varchar2(30),
logoff_date date,
logoff_time varchar2(10),
elapsed_minutes number(8));


create or replace trigger
   logon_audit_trigger
after logon on database
begin
insert into logon_off_audit values(
   user,
   sys_context('userenv','sessionid'),
   sys_context('userenv','host'),
   null,
   null,
   null,
   sysdate,
   to_char(sysdate, 'hh24:mi:ss'),
   null,
   null,
   null
);
end;
/


create or replace trigger
   logoff_trigger
before logoff on database
begin
update logon_off_audit set last_action = (select action from v$session where sys_context('userenv','action') = audsid)
where
sys_context('userenv','sessionid') = session_id;
update
logon_off_audit
set
last_program = (select program from v$session where     
sys_context('userenv','program') = audsid)
where
sys_context('userenv','sessionid') = session_id;
update
logon_off_audit
set
last_module = (select module from v$session where     
sys_context('userenv','module') = audsid)
where
sys_context('userenv','sessionid') = session_id;
update
  logon_off_audit
set
   logoff_date = sysdate
where
   sys_context('userenv','sessionid') = session_id;
update
logon_off_audit
set
   logoff_time = to_char(sysdate, 'hh24:mi:ss')
where
   sys_context('userenv','sessionid') = session_id;
update
logon_off_audit
set
elapsed_minutes =     
round((logoff_date - logon_date)*1440)
where
sys_context('userenv','sessionid') = session_id;
end;
/




Mutating Triggers:-

•	In row level trigger when doing DML operation same time it is reading from same table then give an error it is MUTATING ERROR.
CREATE OR REPLACE TRIGGER T1
AFTER DELETE ON EMP1
FOR EACH ROW

DECLARE 
Z NUMBER(20);
BEGIN
SELECT COUNT(*) INTO Z FROM EMP;
DBMS_OUTPUT.PUT_LINE('NO OF ROWS ARE'||Z);
END;

•	It does not occur in statement level trigger because it is auto commit.
•	To get it mutating error in row level trigger we use PRAGMA AUTONOMOUS_TRANSACTION to commit it.
CREATE OR REPLACE TRIGGER T1
AFTER DELETE ON EMP1
FOR EACH ROW

DECLARE 
Z NUMBER(20);
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
SELECT COUNT(*) INTO Z FROM EMP;
DBMS_OUTPUT.PUT_LINE('NO OF ROWS ARE'||Z);
END;


PRAGMA AUTONOMOUS_TRANSACTION, it creates a new transaction that runs independently of the calling transaction.
Compund Triggers:-
•	Compound Triggers allows code for one or more timing points for a specific object to be combined into a single trigger.
•	The compound allows you to specify actions for each of four timing points in the trigger.
•	It can be used only for DML triggers.
•	It will work on after 11G.

Before statement 	– level
Before row 		- level
After row 		- level	
After statement 	- level

IT provides the facility to combine the actions for differet timings into the same trigger.

create table T1 (A NUMBER);
create table T2 (A NUMBER);


create or replace trigger trg_t1
for insert on t1
compound trigger

before statement is 
begin
insert into t2 values(1);
end before statement;

before each row is 
begin 
insert into t2 values(5);
end before each row;

after each row is 
begin
insert into t2 values(3);
end after each row;

after statement is
begin
insert into t2 values(4);
end after statement;
end targ_t1;

Insert into t1 values(10);




Trigger’s follow’s Clause:-
•	When ever we are using same table (or) same level when we can’t control execution out of the triggers.(which trigger will execute first we can’t find.)
•	To overcome this problem From 11G introduces follows clause.
•	This clause is used in trigger specification.

CREATE OR REPLACE TRIGGER T1
AFTER UPDATE ON EMPLOYEES
BEGIN
DBMS_OUTPUT.PUT_LINE('TRIGGER 1');
END;


CREATE OR REPLACE TRIGGER T2
Follows T1
AFTER UPDATE ON EMPLOYEES
BEGIN
DBMS_OUTPUT.PUT_LINE('TRIGGER 2');
END;

UPDATE EMPLOYEES SET SALARY=SALARY+100 WHERE DEP_NO=90;



Exceptions:-
•	An exception occurs when the PL/SQL engine encounters an instruction which it cannot execute due to an error that occurs at run-time.
•	These errors will not be captured at the time of compilation and hence these needed to handle only at the run-time.
Types of Exceptions:-
•	System-defined / pre-defined exceptions.
•	User-defined exceptions.

Pre-Defined Exception:-
•	Oracle has predefined some common exception. These exceptions have a unique exception name and error number. 
•	These exceptions are already defined in the 'STANDARD' package in Oracle. 
•	In code, we can directly use these predefined exception name to handle them.

Below are the few predefined exceptions:-
Exception	Error Code	Exception Reason
ACCESS_INTO_NULL	ORA-06530	Assign a value to the attributes of uninitialized objects
CASE_NOT_FOUND	ORA-06592	None of the 'WHEN' clause in CASE statement satisfied and no 'ELSE' clause is specified
COLLECTION_IS_NULL	ORA-06531	Using collection methods (except EXISTS) or accessing collection attributes on a uninitialized collections
CURSOR_ALREADY_OPEN	ORA-06511	Trying to open a cursor which is already opened
DUP_VAL_ON_INDEX	ORA-00001	Storing a duplicate value in a database column that is a constrained by unique index
INVALID_CURSOR	ORA-01001	Illegal cursor operations like closing an unopened cursor
INVALID_NUMBER	ORA-01722	Conversion of character to a number failed due to invalid number character
NO_DATA_FOUND	ORA-01403	When 'SELECT' statement that contains INTO clause fetches no rows.
ROW_MISMATCH	ORA-06504	When cursor variable data type is incompatible with the actual cursor return type
SUBSCRIPT_BEYOND_COUNT	ORA-06533	Referring collection by an index number that is larger than the collection size
SUBSCRIPT_OUTSIDE_LIMIT	ORA-06532	Referring collection by an index number that is outside the legal range (eg: -1)
TOO_MANY_ROWS	ORA-01422	When a 'SELECT' statement with INTO clause returns more than one row
VALUE_ERROR	ORA-06502	Arithmetic or size constraint error (eg: assigning a value to a variable that is larger than the variable size)
ZERO_DIVIDE	ORA-01476	Dividing a number by '0'


Example:- NO_DATA_FOUND
DECLARE
I EMPLOYEES%ROWTYPE;

BEGIN
SELECT * INTO I FROM EMPLOYEES WHERE EMPLOYEE_ID=90;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME);
/*EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('THE REQURE RECORD HAS NOT BEEN FOUND');
*/
END;

This error will occur before exception :    ORA-01403: no data found.

This will occur After Exception  :  THE REQURE RECORD HAS NOT BEEN FOUND



Example:- TOO_MANY_ROWS
DECLARE
I EMPLOYEES%ROWTYPE;

BEGIN
SELECT * INTO I FROM EMPLOYEES;
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME);
/* EXCEPTION
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('YOU CAN NOT FETCH MULTIPLE ROWS WITHOUT CURSOR ');
*/
END;

This error will occur before exception : ORA-01422: exact fetch returns more than requested number of rows.

This will occur After Exception  :  YOU CAN NOT FETCH MULTIPLE ROWS WITHOUT CURSOR.


User Defind Exception:-

•	In oracle we also create our own exception and also raise whenever necessary these type of exception are called USER DEFIND EXCEPTION.
•	They can be created at a subprogram level in the declaration part. 
•	These exceptions are visible only in that subprogram. 
•	The exception that is defined in the package specification is public exception, and it is visible wherever the package is accessible.
STEP 1 -> DECLARE
STEP 2 -> RAISE
STEP 3 -> HANDLING EXCEPTION
DECLARE
VSAL NUMBER(20);
A EXCEPTION;

BEGIN
SELECT SALARY INTO VSAL FROM EMP1 WHERE EMPLOYEE_ID=109;
IF VSAL >1000 THEN
RAISE A;
ELSE 
UPDATE EMP1 SET SALARY=SALARY+0.5 WHERE EMPLOYEE_ID=109;
END IF;

EXCEPTION
WHEN A THEN
DBMS_OUTPUT.PUT_LINE('THE SALARY IS HIGH');
END;





Unnamed Exception: (pragma exception)
•	If we want to handle other then 20 preferred exception errors then we are using un named method.
•	We are creating own exception name and associates this exception name with appropriate error number exception inIT()

Example for delete the value primary key mapped to forgein key
DECLARE 
A EXCEPTION;
PRAGMA EXCEPTION_INIT(A, -2292);
BEGIN
DELETE FROM DEPARTMENT WHERE DEPARTMENT_ID=90;

EXCEPTION
WHEN A THEN
DBMS_OUTPUT.PUT_LINE('WE CANoT DELETE MASTER DATA');
END;

 
Error Taping Function:

•	In oracle if we want to catch error number, error numbers with error message then we are using error taping function.
1-> SQLCODE
2-> SQLERRM



Example for showing error code & explanation:-
BEGIN
DBMS_OUTPUT.PUT_LINE(5/0);
EXCEPTION 
WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE(SQLCODE||''||SQLERRM);
END;
-1476ORA-01476: divisor is equal to zero

Statement processed.

Example for storing error code & reason storing into table:-
CREATE TABLE ERROR_STORE(ERROR_NO NUMBER(20), ERROR_NAME VARCHAR2(200) );
DECLARE
V_SAL NUMBER(20);
E_ERRCODE NUMBER(20);
E_ERRNAME VARCHAR(200);

BEGIN
SELECT SALARY INTO V_SAL FROM EMPLOYEES;

EXCEPTION
WHEN OTHERS THEN
E_ERRCODE := SQLCODE;
E_ERRNAME := SQLERRM;
INSERT INTO ERROR_STORE VALUES(E_ERRCODE, E_ERRNAME);
 END;

SELECT * FROM ERROR_STORE;




RAISE_APPLICATION_ERROR :-
•	Want undefined exceptions messages in more descriptive from then only we are using Raise_Application_Error.
•	We can use Execution block / Exception block of PL / SQL.
•	Oracle server Automatically display user Defind exception messages in oracle error display format.
•	This accepts 2 parameters.

SYNTAX :-
RAISE_APPLICATION_ERROR(ERROR NUMBER, MESSAGE)
ERROR NUMBER :- 20000 TO -20999
ERROR MESSAGE :- UPTO 512 CHARACTERS. 

Example:-
DECLARE 
A EXCEPTION;
BEGIN
IF TO_CHAR(SYSDATE, 'DAY')='WEDNESDAY' THEN RAISE A;
END IF;

EXCEPTION
WHEN A THEN
RAISE_APPLICATION_ERROR (-20123, 'IT CANNOT BE RAISED ON WEDNESDAY');
END;







PACKAGES :-

•	Packages is a named PL/SQL block with contains group of Logically Related sub programs.
•	Typically, a package has a specification and a body.
•	A package specification is mandatory while the package body can be required or optional, depending on the package specification.

The following picture illustrates PL/SQL packages:
 


Package specification:-
•	The package specification declares the public objects that are accessible from outside the package.
•	If a package specification whose public objects include cursors and subprograms, then it must have a body which defines queries for the cursors and code for the subprograms.
Package body:-
•	A package body contains the implementation of the cursors or subprograms declared in the package specification. In the package body, you can declare or define private variables, cursors, etc., used only by package body itself.
•	A package body can have an initialization part whose statements initialize variables or perform other one-time setups for the whole package.
•	A package body can also have an exception-handling part used to handle exceptions.



Why using PL/SQL packages :-

•	The package is a powerful feature of PL/SQL that you should use it in any project. The following are the advantages of the package:
•	code reusability.
	Improve application performance :-
•	code more modular.
•	hiding the implementation details.
•	easy to use the pre-compiled code.
•	Provides us with the power to declare variables, functions etc. globally thus making them accessible from anywhere in our queries.
•	

Make code more modular:-
•	Packages allow you to encapsulate logically related types, variables, constants, subprograms, cursors, and exceptions in named PL/SQL modules. By doing this, you make each package more reusable, manageable, readable and reliable.
Hide implementation details :-
•	Packages allow you to expose the functionality via their specifications and hide the detailed implementation in the package body.
•	It means that you can enhance the code in the body of the package without affecting other dependent packages or applications.
Improve application performance :-
•	Oracle loads the package into memory at the first time you invoke a package subprogram. The subsequent calls of other subprograms in the same package do not require disk I/O. This mechanism helps improve performance.
Minimize unnecessary recompiling code :-
•	Packages help avoid the unnecessary recompiling process. For instance, if you change the body of a package function, Oracle does not recompile the subprograms that use the function, because the subprograms are only dependent on the package specification, not the package body.
Manage authorization easily :-
•	By encapsulate objects in a package, you grant role on the package, instead of granting roles on each object in the package.
•	PL/SQL package concept is simple but powerful. They allow you to encapsulate the code and make your application easier to develop and maintain.

Example 1:-
/*---PACKAGE SPECIFICATION---*/
CREATE OR REPLACE PACKAGE PKG
AS
PROCEDURE P1 (A IN NUMBER, B IN NUMBER);
PROCEDURE P2 (C IN NUMBER, D IN NUMBER, E IN NUMBER);
PROCEDURE P3 (A IN NUMBER, B IN NUMBER, C IN NUMBER);
FUNCTION  F1 (X IN NUMBER, Y IN NUMBER)RETURN NUMBER;
END;

/*---PACKAGE BODY---*/
CREATE OR REPLACE PACKAGE BODY PKG
AS


PROCEDURE P1 (A IN NUMBER, B IN NUMBER)
IS 
BEGIN
DBMS_OUTPUT.PUT_LINE(A+B);
END P1;


PROCEDURE P2 (C IN NUMBER, D IN NUMBER, E IN NUMBER)
IS 
BEGIN
DBMS_OUTPUT.PUT_LINE(C+D-E);
END P2;


PROCEDURE P3 (A IN NUMBER, B IN NUMBER, C IN NUMBER)
IS 
BEGIN
DBMS_OUTPUT.PUT_LINE(A*B*C);
END P3;


FUNCTION  F1 (X IN NUMBER, Y IN NUMBER)RETURN NUMBER
AS
BEGIN
RETURN X-Y;
END F1;
END;
Output:-
begin
pkg.p1(100,20);
pkg.p2(100,20,30);
pkg.p3(100,20,30);
end;

120
90
60000

Statement processed.
select pkg.f1(100,30) from dual;
PKG.F1(100,30)
70


Forward Declaration:-
•	If we don’t declare in the specification part then we can declare it in the body part also. It is called forward declaration.

Example:-
CREATE OR REPLACE PACKAGE PKG
AS
PROCEDURE P1;
END;

/*---PACKAGE BODY---*/
CREATE OR REPLACE PACKAGE BODY PKG
IS
PROCEDURE P2;

PROCEDURE P1
AS
BEGIN 
P2;
DBMS_OUTPUT.PUT_LINE('PRINT 1');
END P1;

PROCEDURE P2
AS
BEGIN
DBMS_OUTPUT.PUT_LINE('PRINT 2');
END P2;

END;

OUTPUT:-

BEGIN
PKG.P1;
END;

PRINT 2
PRINT 1

Statement processed.

Package Overloading :-
•	Package Overloading refers to same name can be used for different purpose.
•	In oracle we can also Implement overloading procedure using package.
•	These packages having same name with difference types & difference number of parameters.


/*---PACKAGE SPECIFICATION---*/
CREATE OR REPLACE PACKAGE PF2
IS
FUNCTION F1(A NUMBER, B NUMBER) RETURN NUMBER;
FUNCTION F1(A NUMBER, B NUMBER, C NUMBER) RETURN NUMBER;
END;

/*---PACKAGE BODY---*/
CREATE OR REPLACE PACKAGE BODY PF2
IS
FUNCTION F1(A NUMBER, B NUMBER)RETURN NUMBER
IS 
BEGIN
RETURN(A+B);
END F1;

FUNCTION F1(A NUMBER, B NUMBER, C NUMBER)RETURN NUMBER
IS 
BEGIN
RETURN(A*B*C);
END F1;

END;

OUTPUT :-
select pf2.f1(2,5) from dual;
PF2.F1(2,5)
7

select pf2.f1(2,5,7) from dual;

Note: if we pass 2 arguments it will take 1st if we pass 3 arguments it will take 3 arguments.


Example 2:-
/*---PACKAGE SPECIFICATION---*/
CREATE OR REPLACE PACKAGE PF2
IS
PROCEDURE P1(A NUMBER, B NUMBER);
PROCEDURE P1(X NUMBER, Y NUMBER);
END;

/*---PACKAGE BODY---*/
CREATE OR REPLACE PACKAGE BODY PF2
AS

PROCEDURE P1(A NUMBER, B NUMBER)
AS
C NUMBER(10);
BEGIN
C:=A+B;
DBMS_OUTPUT.PUT_LINE(C);
END P1;

PROCEDURE P1(X NUMBER, Y NUMBER)
AS
Z NUMBER(10);
BEGIN
Z:=X-Y;
DBMS_OUTPUT.PUT_LINE(Z);
END P1;

END;
Output:-
BEGIN
PF2.P1(A=>9, B=>10);
END;

BEGIN
PF2.P1(X=>7, Y=>10);
END;

What is Dynamic SQL?

run the SQL code at run time in Oracle.
It use EXECUTE IMMEDIATE for dynamic SQL
Note: You can execute DDL queries with help of Dynamic SQL in PL/SQL.

ALTER SYSTEM KILL SESSION '4753,1534' IMMEDIATE;
UTL
******

	This package is use to write data into an os file & read data from OS file.
	if we want to write data into os file then we are using PUTF() method from UTL_FILE 
	package and also if we want to read data from OS file then we are using GET_Line() method from UTL_FILE package.

--Writing data into an external File:-

STEP 1:- Before we are opening the file we must Declare a file pointer variable in declaration section of the PLSQL block, using file_type
from UTL_FILE package.

STEP 2:- Before writing data into file we must open the file using FOPEN() from UTL_file package.


-> This function accepts a parameter and returns file_type Data Type.

-> f open is used in Executable section of the PLSQL Block.

 syn: UTL_FILE.FOPEN('ALIAS DIRED ORYNAME', 'filename', 'mode');

DECLARE
FP UTL_FILE.FILE_TYPE;
I VARCHAR2(30);
BEGIN
FP:=UTL_FILE.FOPEN('NEW', 'EMP123.TXT', 'W',32767);
FOR X IN (SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE ROWNUM <=10) LOOP
I:=X.FIRST_NAME||' ' ||X.SALARY;
UTL_FILE.PUT_LINE(FP,I);
UTL_FILE.NEW_LINE(FP);
END LOOP;
UTL_FILE.FCLOSE(FP);
END;          

Note:-

whenever we are using UTL_FILE package to write column data into file then database server automatically write data horizantally in a file;

DECLARE 
FP UTL_FILE.FILE_TYPE;
CURSOR C1 IS SELECT FIRST_NAME FROM EMP;
BEGIN
FP:=UTL_FILE.FOPEN('NEW', 'FILE12.TXT', 'W');
FOR I IN C1 LOOP
UTL_FILE.PUTF(FP,I.FIRST_NAME);
END LOOP;
UTL_FILE.FCLOSE(FP);
END;


--Reading data from file:-

*using Get_line() from UTL_FILE package, we can read data from the file;

DECLARE
FP UTL_FILE.FILE_TYPE;
X VARCHAR2(500);
BEGIN
FP:=UTL_FILE.FOPEN('NEW', 'EMP987.TXT', 'R');
UTL_FILE.GET_LINE(FP,X);
DBMS_OUTPUT_LIVE('DATA FROM FILE'||' ' ||X);
UTL_FILE.FCLOSE(FP);
END;

---NOTE--
IN ORACLE WHEN WE ARE reading multiple values from a file using UTL_FILE package,

then oracle server Returns an error NO_DATA_FOUND when control reach end of the file.


DECLARE
FP UTL_FILE.FILE_TYPE;
X VARCHAR2(200);
BEGIN
FP:=UTL_FILE.FOPEN('NEW', 'EMP9875.TXT', 'R');
LOOP
UTL_FILE.GET_LINE(FP,X);
DBMS_OUTPUT.PUT_LINE(X);
END LOOP;
UTL_FILE.FCLOSE(FP);
EXCEPTION
WHEN NO_DATA_FOUND THEN
NULL;
END;





XML 
**********

TO Generate xml:-

SELECT DBMS_XMLGEN.GETXML ('SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE ROWNUM<5') FROM DUAL;

TO Write into File:-

DECLARE
UTL_FILE.FILE_TYPE;
MYCLOB CLOB;
BEGIN
SELECT DBMS_XMLGEN.GETXML('SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE ROWNUM<10') INTO  MYCLOB FROM DUAL;

F I=UTL_FILE.FOPEN('NEW','EMP_DEPT.XML','W', 32767);
UTL_FILE.PUT(F,MYCLOB);
UTL_FILE.FCLOSE(F);
END;
/



DBMS_JOBS
******************************

	IT is used to automate job or Task;

DECLARE 
V_job_number NUMBER;

BEGIN
DBMS_JOB.SUBMIT (
				JOB => v_job_number,
				WHAT=>'P1;',
				NEXT_DATE=> SYSDATE,
				INTERVAL=>'SYSDATE+1/1440';
				);
COMMIT;
DBMS_OUTPUT.PUT_LINE(V_job_number);
END;
/

      
DECLARE
  V_JOB_NO NUMBER;
BEGIN
  DBMS_JOB.SUBMIT(
    JOB       => V_JOB_NO,
    WHAT      => 'PGIPK_TAC_HEALTH_CLAIM_BIMA_SATARK_2023.PROC_EXTRACT_TAC_F15C_BIMA_SATARK(''10000'',
																	''60000'',
																    TO_DATE(SYSDATE, ''DD-MON-YYYY'')-280, 
																	TO_DATE(SYSDATE, ''DD-MON-YYYY'')-280,
																	''3'',
																	TO_NUMBER(153||TO_CHAR(SYSDATE-280,''RRRR'')||TO_CHAR(SYSDATE-280,''MM'')||TO_CHAR(SYSDATE-280,''DD'')));                  END;',
		NEXT_DATE => TRUNC(SYSDATE+1) + 5/24,	-----Run at 5AM everyday
		INTERVAL  => 'TRUNC(SYSDATE+1) + 5/24'
  );
  COMMIT;
END;
/
•	Parameter in Jobs 

JOB              – Uniquely identifies the job or job name. 
WHAT          – PL/SQL code to execute as a job. 
NEXT_DATE   – Next execution date of the job. 
INTERVAL       – Specifics in which interval it should run. 
            Once ran this job automatically generated job id .

Force Run a Job:
BEGIN
DBMS_JOB.RUN(22); 	/*22 IS run id*/
END;
/


To Stop Temporarily:-
BEGIN
DBMS_JOB.BROKEN(22,TRUE); 	/*RUN ID & STATUS*/
END;
/


To Start stoped job:-
BEGIN
DBMS_JOB.BROKEN(22,FALSE);
END;
/


ALL JOBS:-
select * from dba_jobs;
Select * from dba_scheduler_jobs;

PERMANENTLY REMOVE JOB:-
BEGIN
DBMS_JOB.REMOVE(22);
END;
/


ALTER SESSION SET NIS_DATE_FORMAT='DD:MON:YYYYHH24:MI:SS';









PROCEDURE CREATION SAMPLES:-

CREATE OR REPLACE PROCEDURE P1(P_DEPT_ID NUMBER)
IS
    CURSOR C1 IS 
        SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID 
        FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = P_DEPT_ID;

    M_EMPLOYEE_ID   EMPLOYEES.EMPLOYEE_ID%TYPE;
    M_FIRST_NAME    EMPLOYEES.FIRST_NAME%TYPE; 
    M_SALARY        EMPLOYEES.SALARY%TYPE;    
    M_DEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE;

    -- Declare a custom exception for no employees found
    no_employees_found EXCEPTION;

    -- Variable to track if any rows were fetched
    employee_found BOOLEAN := FALSE;

BEGIN 
    OPEN C1;
    LOOP
        FETCH C1 INTO M_EMPLOYEE_ID, M_FIRST_NAME, M_SALARY, M_DEPARTMENT_ID;
        
        -- Check if the cursor fetches any rows
        EXIT WHEN C1%NOTFOUND;

        -- Set employee_found to TRUE if at least one record is fetched
        employee_found := TRUE;

        DBMS_OUTPUT.PUT_LINE(M_EMPLOYEE_ID || ' ' || M_FIRST_NAME || ' ' || M_SALARY || ' ' || M_DEPARTMENT_ID);
    END LOOP;
    CLOSE C1;

    -- If no rows were fetched, raise the no_employees_found exception
    IF NOT employee_found THEN
        RAISE no_employees_found;
    END IF;

EXCEPTION
    WHEN no_employees_found THEN
        DBMS_OUTPUT.PUT_LINE('DEPT ID NOT EXIST');
END;
SET SERVEROUTPUT ON;
BEGIN
ORDER_STATUS(11700);
END;


For loop:-
CREATE OR REPLACE PROCEDURE P1(P_DEPT_ID NUMBER)
IS
BEGIN 
    -- Using FOR loop with implicit cursor
    FOR employee_rec IN (
        SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID 
        FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = P_DEPT_ID
    ) LOOP
        -- Print employee details
        DBMS_OUTPUT.PUT_LINE(employee_rec.EMPLOYEE_ID || ' ' || 
                             employee_rec.FIRST_NAME || ' ' || 
                             employee_rec.SALARY || ' ' || 
                             employee_rec.DEPARTMENT_ID);
    END LOOP;

END;


BULK COLLECT :-
DECLARE
TYPE T1 IS TABLE OF EMPLOYEES%ROWTYPE INDEX BY 
BINARY_INTEGER;
V1 T1;
BEGIN
SELECT * BULK COLLECT INTO V1 FROM EMPLOYEES;
FOR X IN V1.FIRST..V1.LAST LOOP
DBMS_OUTPUT.PUT_LINE(V1(X).FIRST_NAME||V1(X).SALARY);
END LOOP;
END;

BEGIN
P1;
END;
PASSING PARAMETER WITH EXCEPTION:-
CREATE OR REPLACE PROCEDURE P1(V_DEPT number)
AS
TYPE T1 IS TABLE OF EMPLOYEES%ROWTYPE INDEX BY BINARY_INTEGER;
V1 T1;
I number(5);
ERROR EXCEPTION;
BEGIN

SELECT count(*) INTO I FROM EMPLOYEES WHERE DEPARTMENT_ID = V_DEPT;
IF I>0 THEN
SELECT * BULK COLLECT INTO V1 FROM EMPLOYEES WHERE DEPARTMENT_ID = V_DEPT;
FOR X IN V1.FIRST..V1.LAST LOOP
DBMS_OUTPUT.PUT_LINE(V1(X).FIRST_NAME||V1(X).SALARY);
END LOOP;
else 
raise ERROR;
END IF;
EXCEPTION
WHEN ERROR THEN
DBMS_OUTPUT.PUT_LINE('DEPT NOT EXITST');
END;
/

BEGIN
P1(50);
END;



Nested table;-
DECLARE 
TYPE T1 IS TABLE OF EMPLOYEES%ROWTYPE;
V1 T1;
BEGIN
SELECT * BULK COLLECT INTO V1 FROM EMPLOYEES;
FOR I IN V1.FIRST..V1.LAST LOOP
DBMS_OUTPUT.PUT_LINE(V1(I).FIRST_NAME||V1(I).HIRE_DATE);
END LOOP;
END;



Delete the data using bulk collect:-

DECLARE
TYPE T1 IS TABLE OF EMP%ROWTYPE INDEX BY BINARY_INTEGER;
V1 T1;
BEGIN
SELECT * BULK COLLECT INTO V1 FROM EMP;
FOR X IN V1.FIRST..V1.LAST LOOP
DELETE FROM EMP;
DBMS_OUTPUT.PUT_LINE(V1(X).FIRST_NAME||V1(X).SALARY);
END LOOP;
END;


DECLARE
TYPE T1 IS TABLE OF PGIW_TAC_FIRE%ROWTYPE INDEX BY BINARY_INTEGER;
V1 T1;
BEGIN
SELECT * BULK COLLECT INTO V1 FROM PGIW_TAC_FIRE WHERE FIRE_REP_KEY_NO IN(62201904,62201905,62201906,62201907,62201908,62201909,62201910,62201911,62201912,62202001,62202002,62202003)
AND FIRE_REP_ID = 'F6B';
FOR X IN V1.FIRST..V1.LAST LOOP
DELETE FROM PGIW_TAC_FIRE WHERE FIRE_REP_KEY_NO IN(62201904,62201905,62201906,62201907,62201908,62201909,62201910,62201911,62201912,62202001,62202002,62202003) AND FIRE_REP_ID = 'F6B';
END LOOP;
END;


Bulk collect from chat GPT:-

CREATE OR REPLACE PROCEDURE P1(P_DEPT_ID NUMBER)
IS
    TYPE EmployeeTableType IS TABLE OF EMPLOYEES%ROWTYPE;
    employee_table EmployeeTableType;

BEGIN
    -- Use BULK COLLECT to fetch all rows at once
    SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID 
    BULK COLLECT INTO employee_table
    FROM EMPLOYEES 
    WHERE DEPARTMENT_ID = P_DEPT_ID;

    -- Check if any records were found
    IF employee_table.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('DEPT ID NOT EXIST');
    ELSE
        -- Loop through the collection and print each record
        FOR i IN 1 .. employee_table.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(employee_table(i).EMPLOYEE_ID || ' ' || 
                                 employee_table(i).FIRST_NAME || ' ' || 
                                 employee_table(i).SALARY || ' ' || 
                                 employee_table(i).DEPARTMENT_ID);
        END LOOP;
    END IF;

END;
