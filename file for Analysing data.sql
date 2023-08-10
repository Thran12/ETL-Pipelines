select count(*) from `uber data`.staging_uber_data
select * from `uber data`.staging_uber_data

select count(*) from `uber data`.uber_data

-- where (tpep_pickup_datetime > '2022-01-01 00:04:06')
/*
select * from `uber data`.uber_data where tpep_pickup_datetime > 
(select tpep_pickup_datetime from `uber data`.tpep_pickup_dimension 
where (date_pk= "20220101000340"))
0000000000000
20220101000340*/

select select tpep_pickup_datetime from tpep_pickup_dimension where (date_pk= '${Incremental_Col}')


select max(tpep_pickup_datetime) from `uber data`.uber_data
select * from `uber data`.uber_data
select count(*) from `uber data`.uber_data order by tpep_pickup_datetime desc
select count(*) from `uber data`.tpep_pickup_dimension
select max(tpep_pickup_datetime_fk) from `uber data`.fact_uber

select * from `uber data`.fact_uber
select count(*) from `uber data`.fact_uber