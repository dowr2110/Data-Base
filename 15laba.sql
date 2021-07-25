create table test(i int primary key);
drop table test;

declare 
k int :=0;
begin
while k<10
loop
insert into test(i)
values (k);
k:= k+1;
end loop;
end;

select * from test;
---------------------3-6-------------
create or replace trigger Input_trig
before insert on test
begin
dbms_output.put_line('insert trigger');
end;

create or replace trigger Delete_trig
before delete on test
begin
dbms_output.put_line('delete trigger');
end;

create or replace trigger Update_trig
before update on test
begin
dbms_output.put_line('update trigger');
end;


insert into test(i) values(10);
update test set i = 100 where i=10;
delete test where i=100;



create or replace trigger before_row_first
before  insert or update or delete on test
for each row
begin
if inserting then 
dbms_output.put_line('inserting trigger');
elsif updating then 
dbms_output.put_line('updating trigger');
elsif deleting then 
dbms_output.put_line('deleting trigger');
end if;
end;
-------------------7-8---------

create table testforAfter(i int primary key);
drop table testforAfter;

declare 
k int :=0;
begin
while k<10
loop
insert into testforAfter(i)
values (k);
k:= k+1;
end loop;
end;

select * from testforAfter;

create or replace trigger Input_trig_after
after insert on testforAfter
begin
dbms_output.put_line('insert trigger after');
end;

create or replace trigger Delete_trig_after
after delete on testforAfter
begin
dbms_output.put_line('delete trigger after');
end;

create or replace trigger Update_trig_after
after update on testforAfter
begin
dbms_output.put_line('update trigger after');
end;


insert into testforAfter(i) values(10);
update testforAfter set i = 100 where i=10;
delete testforAfter where i=100;



create or replace trigger after_row_first
after  insert or update or delete on testforAfter
for each row
begin
if inserting then 
dbms_output.put_line('inserting trigger after');
elsif updating then 
dbms_output.put_line('updating trigger after');
elsif deleting then 
dbms_output.put_line('deleting trigger after');
end if;
end;


------------------------------9-10------------------

create table AUDITS(OperationDate date,OperationType nvarchar2(50), TriggerName nvarchar2(50),Data nvarchar2(50));


create or replace trigger new_trigg1
before insert or update  or delete on test
begin
if inserting then
dbms_output.put_line('insert_to_audit');
insert into AUDITS(OperationDate,OperationType , TriggerName )
values (sysdate,'insert', 'new_trigg1','');
elsif updating then
dbms_output.put_line('update_to_audit');
insert into AUDITS(OperationDate,OperationType , TriggerName )
values (sysdate,'update', 'new_trigg1','');
elsif deleting then
dbms_output.put_line('delete_to_audit');
insert into AUDITS(OperationDate,OperationType , TriggerName )
values (sysdate,'delete', 'new_trigg1', '');
end if;
end;

insert into test(i) values(10);
update test set i = 100 where i=10;
delete test where i=100;

select * from audits;

-------------------------12------------

create or replace trigger drop_trigger
before drop on DATABASE
begin
raise_application_error(-20000,'cant drop');
dbms_output.put_line('ERROR');
end;

drop table test;

DROP TRIGGER drop_trigger;
------------------------13--------

SELECT * FROM user_triggers;

------------------------14-15------------

create view testview as select i from test;

select * from testview;

create or replace trigger test_trigg
instead of insert on testview
for each row
begin 
dbms_output.put_line('INSTEADOF_insert');
insert into test values(:new.i);
end test_trigg;

insert into testview (i) values(123);
delete test where i=123;
select * from test;

drop trigger test_trigg;
drop view testview;



