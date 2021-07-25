create table T_Range( id number)
partition by range(id)
(
Partition p1 values less than (100),
Partition p2 values less than (200),
Partition p3 values less than (300),
Partition pmax values less than (maxvalue)
);

select * from t_range;

insert into T_range(id)
values(505);
insert into T_range(id)
values(50);
insert into T_range(id)
values(150);
insert into T_range(id)
values(250);


select * from t_range partition(p1);
select * from t_range partition(p2);
select * from t_range partition(p3);
select * from t_range partition(pmax);

---------------------Interval-----------
create table T_Interval( time_id date)
partition by range(time_id)
interval (numtoyminterval(10,'year'))
(
partition p0 values less than  (to_date ('1-1-2000', 'dd-mm-yyyy')),
partition p1 values less than  (to_date ('1-1-2010', 'dd-mm-yyyy')),
partition p2 values less than  (to_date ('1-1-2020', 'dd-mm-yyyy'))
);

insert into T_Interval(time_id)
values(to_date ('01-01-2005', 'dd-mm-yyyy'));

select * from t_interval partition (p0);
select * from t_interval partition (p1);
select * from t_interval partition (p2);

-------------------Hash----------------
create table T_hash (str varchar2 (50))
partition by hash (str)
partitions 4;

insert into T_hash (str)
values('dowran');
insert into T_hash (str)
values('atayew');
insert into T_hash (str)
values('jemshit');

SELECT * FROM t_hash partition for('dowran');
SELECT * FROM t_hash partition for('atayew');
SELECT * FROM t_hash partition for('jemshit');



------------------List---------------
create table T_list(obj char(3))
partition by list (obj)
(
partition p1 values ('aaa'),
partition p2 values ('bbb'),
partition p3 values ('ccc')
);
--default yoklary ozune alya

insert into T_list (obj)
values('aaa');
insert into T_list (obj)
values('bbb');
insert into T_list (obj)
values('ccc');

select * from T_list;
SELECT * FROM T_list partition(p1);
SELECT * FROM T_list partition(p2);
SELECT * FROM T_list partition(p3);

---------------------------------------------
drop table T_range;
drop table T_hash;
drop table T_list;
drop table t_interval;
---------------------------------------------

select * from t_range partition(p1);
select * from t_range partition(p2);
select * from t_range partition(p3);
select * from t_range partition(pmax);

-----------6---------------
alter table t_range enable row movement;
update t_range
set id=180 where id=250;

--------------7--------------
alter table t_range merge partitions
p1,p2 into partition p2;

-----------8------------------------
--snacala dobav eshe odnu stroku--130
alter table t_range split partition p2 
at (140) into (partition p4, partition p5);

insert into T_range(id)
values(130);

select * from t_range partition(p2);
select * from t_range partition(p4);
select * from t_range partition(p5);

-------------9----------------
create table t_range1(obj number);

alter table t_range exchange partition  p4
with table t_range1
without validation ;

select * from t_range1;

drop table t_range1;
