select * from teacher;
alter table teacher  add(Birthday date, salary int);
update teacher set salary = 800;
alter table teacher  add(Faculty varchar(50));
update teacher set Faculty = '???';
update teacher set Faculty = '????' 
where Teacher_name='???????? ?????? ??????????';
commit;

select
 substr(teacher_name,1,instr(teacher_name,' '))|| 
 substr(teacher_name,instr(teacher_name,' ')+1,1)||'.'||
 substr(teacher_name,instr(teacher_name,' ',1,2)+1,1)||'.'
 as famIO
 from teacher;
 
 select teacher_name,to_char(birthday,'Day') from teacher 
 WHERE to_char(birthday,'Day')='???????????';
 
 create view month_date as
 select teacher_name, birthday from teacher
 where extract(month from birthday)=extract(month from sysdate)+1;

select* from month_date;

select count(*) from teacher
where extract(month from birthday)=extract(month from sysdate);


 select teacher_name,to_char(birthday,'Month') from teacher ;
 

 DECLARE
i int:= 1;
count_month number;
 begin 
  for k in 1 .. 12
  loop
  select count(*) into count_month from teacher
where extract(month from birthday)=i;
dbms_output.put_line(count_month);
i:=i+1;
end loop;
end;

declare
cursor curs_teachers is select teacher,
teacher_name, pulpit, birthday, salary 
from teacher
where  (extract(Year from sysdate)+1-
extract(Year from birthday) =50);
birt_row teacher%rowtype;
begin
open curs_teachers;
fetch curs_teachers into birt_row;
while curs_teachers%found
loop
dbms_output.put_line(birt_row.teacher_name||' '|| birt_row.birthday);
fetch curs_teachers into birt_row;
end loop;
close curs_teachers;
exception
when others 
then dbms_output.put_line(sqlerrm);
end;

DECLARE
avg1 teacher.salary%type;
avg2 teacher.salary%type;
avg3 teacher.salary%type;
 begin
  select avg(salary) into avg1 from teacher where Pulpit ='????';
select avg(salary)into avg2 from teacher where Pulpit ='??';
select avg(salary)into avg3 from teacher where Pulpit ='??';
dbms_output.put_line('??????? ???????? ?? ??????? ???? = '||avg1);
dbms_output.put_line('??????? ???????? ?? ??????? OB = '||avg2);
dbms_output.put_line('??????? ???????? ?? ??????? ?? = '||avg3);
end;


declare
new_row teacher%rowtype;
begin
new_row.teacher :='????';
new_row.teacher_name:='???????? ??????? ';
new_row.pulpit:='????';
new_row.birthday:=to_date('30.10.1998', 'DD/MM/YYYY');
new_row.salary:=1900;
DBMS_OUTPUT.PUT_LINE(new_row.teacher ||' '||new_row.teacher_name||' '||
new_row.pulpit||' '||new_row.birthday||' '||new_row.salary);
end;



  
 
