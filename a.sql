#1 Display and update
BEGIN
 FOR rec IN (  SELECT *  FROM BRANCH_DETAIL)
 LOOP
 dbms_output.put_line ('CODE :  '  || rec.code || '  NAME :  '|| rec.name ||
' A
SSETS :  '|| rec.assets);
 END LOOP ;
 FOR rec IN (  SELECT *  FROM CUSTOMER_DETAIL)
 LOOP
 dbms_output.put_line ('SSN :  '  || rec.ssn || '  NAME :  '|| rec.name ||
' P
LACE :  '|| rec.place);
 END LOOP ;
 FOR rec IN (  SELECT *  FROM ACCOUNT_DETAIL)
 LOOP
 dbms_output.put_line ('ACCNo :  '  || rec.accno || '  SSN :  '|| rec.ssn
|| '
 CODE :  '|| rec.code || '  BALANCE :  '|| rec.balance);
 END LOOP;
UPDATE ACCOUNT_DETAIL
SET BALANCE=120000
WHERE SSN=1;
dbms_output.put_line (‘SOME ROWS ARE UPDATED’ );
END ;
/

#2 10% increase
BEGIN
UPDATE EMPLOYEE_DETAIL
SET SALARY = CASE
   WHEN DEPTNO = 10  THEN salary+(salary*0.15)
   ELSE salary  
   END
WHERE DEPTNO IN (10);
dbms_output.put_line ( T
O_Char ( SQL%ROWCOUN T)||'rows affected.');
END;
/

#3DECLARE
 n  number ;
i number;
flag number;
BEGIN
i:=2;
 flag:=1;
 n:=12;
 FOR i  in 2..n/2
 LOOP
IF MOD(n,i)=0 THEN
 flag:=0;
 exit;
 END IF;
 END LOOP ;
IF flag=1 THEN
 dbms_output.put_line ('PRIME');
ELSE
dbms_output.put_line ('NOT PRIME');
END IF ;
END;
/

#4Cpoy
DECLARE
 c_id
 employee_detail.ssn %type ;
 c_name employee_detail.Name %type ;
 c_salary employee_detail.salary %type ;
 c_deptno employee_detail.deptno %typ e;
 CURSOR c1
IS SELECT SSN ,NAME,SALARY,DEPTNO
 FROM EMPLOYEE_DETAIL;
BEGIN
 OPEN c1;
 LOOP
 FETCH c1 INTO c_id, c_name, c_salary,c_deptno;
 EXIT WHEN c1 %notfound ;
INSERT INTO EMPLOYEE_DETAIL_COPY VALUES (c_id,c_name,c_salary,c_deptno);
END LOOP ;
 CLOSE c1;
dbms_output.put_line (‘SUCCESSFULLY COPIED TO NEW TABLE');
END ;
/

#5 8 Fibonaci numbers
DECLARE
    first       number  :=0;
    Second      numbe r:=1;
    third       number ;
    n            number :=8;
    i            number ;
 BEGIN
    dbms_output.put_line ('Fibonacci  series  is:');
    dbms_output.put_line (first);
    dbms_output.put_line (second);
    FOR  i   iN   2..n
   LOOP
        third  :=  first  +   second  ;
        first:=  second  ;
        second:=  third;
        dbms_output.put_line (third);
    END  LOOP ;
END ;
/

#6
CREATE  OR REPLACE  P
ROCEDURE findFactorial
AS
 n number ;
 fac number :=1;
 i  number ;
 BEGIN
 n:=&n;
 FOR i  IN 1..n
 LOOP
 fac:=fac *  i  ;
END LOOP ;
 dbms_output.put_line ('Factorial='||fac);
END ;
/
EXECUTE findFactorial;
SHOW ERROR PROCEDURE findFactorial;

#7
DECLARE
str1 varchar (50):='&n';
str2 varchar (50);
 len number ;
 i  number ;
 BEGIN
 len: =  length (str1);
 FOR i  IN REVERSE 1..len
 LOOP
 str2:=str2 || substr(str1,i,1);
END LOOP;
 IF str1=str2  THEN
dbms_output.put_line('IT’S PALINDROME');
ELSE
 dbms_output.put_line('IT’S NOT PALINDROME');
 END IF ;
END ;
/

#8
CREATE  OR REPLACE TRIGGER  tri_employee
BEFORE  insert or  update
ON EMPLOYEE_DETAIL
FOR  EACH  ROW
DECLARE
rec  varchar2(10) ;
BEGIN
SELECT  to_char(sysdate ,'Dy') INTO  rec FROM  dual;
IF  rec  =   'Thu'  OR  rec='Wed'  THEN
 dbms_output.put_line( rec);
  raise_application_error  (-20343,  'NOT  ALLOWED TO  ENTER');
END  IF  ;
END  ;
/
show  error
INSERT  INTO  EMPLOYEE_DETAIL  VALUES  (499,'RAM',10000,10);
