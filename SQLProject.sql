select * from sqlproject.dbo.data1;

select * from sqlproject.dbo.data2;

-- number of rows into our dataset

 select count(*) from sqlproject..data1
 select count(*) from sqlproject..data2

 -- dataset for orissa and punjab

 select * from sqlproject..data2 where state in ('orissa' , 'punjab')


-- Population of India

select sum(population) as Population from sqlproject..data2

-- Avg growth

select avg(growth)*100 avg_growth from sqlproject..data1

-- Avg growth by statewise

select state,avg(growth)*100 avg_growth from sqlproject..data1 group by state;

-- Avg sex ratio

select state,round(avg(sex_ratio),0) avg_sexratio from sqlproject..data1 group by state;
select state,round(avg(sex_ratio),0) avg_sexratio from sqlproject..data1 group by state order by avg_sexratio desc;

--Avg literacy rate

select state,round(avg(literacy),0) avg_literacyratio from sqlproject..data1 group by state order by avg_literacyratio asc;
select state,round(avg(literacy),0) avg_literacyratio from sqlproject..data1 group by state having round(avg(literacy),0)>80 order by avg_literacyratio desc;

-- Top 5 showing highest growth ratio

select top 5 state,avg(growth)*100 avg_growth from sqlproject..data1 group by state order by avg_growth desc ;

--Bottom 5 state showing lowest sex ratio

select top 5 state,round(avg(sex_ratio),0) avg_sexratio from sqlproject..data1 group by state order by avg_sexratio asc ;

--Top and bottom 3 states in Literacy Rate

drop table if exists topstates
create table topstates
(
state nvarchar(255),
topstate float,
)

insert into topstates
select state,round(avg(literacy),0) avg_literacyratio from sqlproject..data1 group by state order by avg_literacyratio desc;

select top 3 * from topstates order by topstates.topstate desc;

drop table if exists bottomstates
create table bottomstates
(
state nvarchar(255),
bottomstate float,
)
insert into bottomstates
select state,round(avg(literacy),0) avg_literacyratio from sqlproject..data1 group by state order by avg_literacyratio desc;

select top 3 * from bottomstates order by bottomstates.bottomstate asc;

-- Union Operator
select * from (
select top 3* from topstates order by topstates.topstate desc) a
union
select * from (
select top 3* from bottomstates order by bottomstates.bottomstate asc)b;

--States starting with letter A
 
select distinct state from sqlproject..data1 where lower(state) like 'a%' or lower(state) like 'h%'
 
 --Joining both tables

 select a.district,a.state,a.sex_ratio,b.population from sqlproject..data1 a inner join sqlproject..data2 b on a.district=b.district

 --Total males AND females

 select d.state,sum(d.males) total_males,sum(d.females) total_females from
(select c.district,c.state state,round(c.population/(c.sex_ratio+1),0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from sqlproject..data1 a inner join sqlproject..data2 b on a.district=b.district ) c) d
group by d.state



