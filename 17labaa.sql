drop table table1;
drop table table2;

create table table1
(
aa number,
bb varchar(15)
);

insert into table1 values(11,'yyy');
insert into table1 values(0,'aaa');

delete from table2;

create table table2
(
aa number,
bb varchar(15)
);

create or replace procedure do_job is
begin
insert into table2 select aa,bb from table1;
delete from table1;
commit;
end do_job;

begin
do_job;
end;

select * from table1;
select * from table2;


create table results
(
message nvarchar2(10),
joddate date
);

select * from results;

create or replace procedure job_call as
JobNo user_jobs.job%type;
begin
dbms_job.submit(JobNo,'begin do_job(); end;',sysdate,'sysdate+7');
sys.dbms_output.put_line(JobNo);
insert into results(message,joddate) values('done', sysdate);
commit;
exception when others then
insert into results(message,joddate) values('wrong', sysdate);
commit;
end;


begin job_call; end;

select * from dba_jobs;
select * from results;

select * from table1;
select * from table2;

commit;


exec dbms_job.run(22);
exec dbms_job.remove(22);
exec dbms_job.next_date(21,sysdate+20);
exec dbms_job.broken(22,true);



-----------------------------
create procedure scheldulerr is
BEGIN
DBMS_SCHEDULER.CREATE_JOB
(
JOB_NAME=>'SCHEDULER',
JOB_TYPE=>'PLSQL_BLOCK',
REPEAT_INTERVAL=>'freq=weekly;',
JOB_ACTION=>'begin do_job(); end;',
start_date => systimestamp,-rassh vrem daty
end_date=> null,
ENABLED=>TRUE);--to cto on budet rabotat'
insert into results(message,joddate) values('doneSch', sysdate);
commit;
exception when others then
insert into results(message,joddate) values('wrongSch', sysdate);
commit;
END;

begin
scheldulerr;
end;

select * from user_scheduler_jobs;

select * from results;
