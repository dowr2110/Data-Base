

--1--
BEGIN
null;
end;

--2--
BEGIN
DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
END;

--3--
DECLARE 
  x number(3):=3;
  y number(3):=0;
  z number(10,2);
BEGIN
  DBMS_OUTPUT.PUT_LINE('x:= '||x||' , y:=' ||y);
  z:=x/y;
  DBMS_OUTPUT.put_line('z:= '||z);
EXCEPTION
  when others
  then dbms_output.put_line('error= '||sqlerrm||' , code '||sqlcode);
END;

--4--
DECLARE 
  x number(3):=3;
  y number(3):=0;
  z number(10,2);
BEGIN
  DBMS_OUTPUT.PUT_LINE('x:= '||x||' , y:=' ||y);
  begin
    z:=x/y;
  EXCEPTION
    when others
    then dbms_output.put_line('error= '||sqlerrm||' , code '||sqlcode);
  end;
  DBMS_OUTPUT.put_line('z:= '||z);
END;

--5--
show parameter plsql_warnings;

select name,value from v$parameter where name='plsql_warnings';

--6--
SELECT keyword FROM v$reserved_words where length=1 and keyword!='A';

--7--
SELECT keyword FROM v$reserved_words where length>2 and keyword!='A' order by keyword;

--8--
show parameter plsql

--9--

DECLARE
  x number(3):=15;--10--
  y number(3):=6;
  z number(10,2);
  r number(5,2):=123.12;--12--
  u number(5,-2):=-123.12; --13--
  i binary_float:=456789.123456782345678;--14--
  ii binary_double:=456789.123456782345678;--15--
  uu number(10,2):=5e3;--16--
  b BOOLEAN :=false; --17-- 
BEGIN 
  z:=x/y;
  DBMS_OUTPUT.put_line('z:= '||z);
  DBMS_OUTPUT.put_line('r:= '||r);
  DBMS_OUTPUT.put_line('u:= '||u);
  DBMS_OUTPUT.put_line('i:= '||i);
  DBMS_OUTPUT.put_line('ii:= '||ii);
  DBMS_OUTPUT.put_line('uu:= '||uu);
  
  if b
  then DBMS_OUTPUT.put_line('b:= true');
  else   DBMS_OUTPUT.put_line('b:= false');
  end if;
END;

--18--
DECLARE
  n1 constant number(5):=5;
  c1 constant char(15):='Hello';
  v1 constant varchar2(15):='Dowran';
BEGIN
  v1:='Hello';
EXCEPTION
  when others
    then DBMS_OUTPUT.put_line('error'||v1);
END;
  
--19,20--
DECLARE
  subject1 subject.subject%type;
  pulpit1 pulpit.pulpit%type;
  faculty_rec faculty%rowtype;
BEGIN
  subject1:='Pis';
  pulpit1:='Isit';
  faculty_rec.faculty:='Idip';
  faculty_rec.faculty_name:='Fakultet izdatelskogo dela i poligrafii';
  DBMS_OUTPUT.put_line(subject1);
  DBMS_OUTPUT.put_line(pulpit1);
  DBMS_OUTPUT.put_line(rtrim(faculty_rec.faculty)||':'||faculty_rec.faculty_name);
EXCEPTION
  when others
    then DBMS_OUTPUT.put_line('error= ' ||sqlerrm);
END;

--21,22--
DECLARE 
  x int:=17;
BEGIN
  if 8>x
  then DBMS_OUTPUT.put_line('8>'||x);
  elsif 8=x
   then DBMS_OUTPUT.put_line('8='||x);
  elsif 17>x
    then DBMS_OUTPUT.put_line('17>'||x);
  elsif 17=x
    then DBMS_OUTPUT.put_line('17='||x); 
  else
     DBMS_OUTPUT.put_line('17!='||x);
  end if;
END;  

--23--
DECLARE
  x int:=17;
BEGIN
  CASE
  when 12>x 
    then DBMS_OUTPUT.put_line('12>'||x);
  when x between 13 and 20
    then DBMS_OUTPUT.put_line('13=<'||x||'<=20');
  else
    DBMS_OUTPUT.put_line('not of all');
  END CASE;
END; 


--24,25,26--sikly
DECLARE 
  x int:=0;
BEGIN
  --24--
  loop
    x:=x+1;
    DBMS_OUTPUT.put_line(x);
  exit when x>10;
  end loop;
  --25--
  for k in 1..10
  loop
    DBMS_OUTPUT.put_line(k);
  end loop;
  --26--
  while(x>0)
  loop
    x:=x-1;
    DBMS_OUTPUT.put_line(x);
  end loop;
END;

ALTER DATABASE OPEN