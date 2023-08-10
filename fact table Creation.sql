-- fact table logic for conversion from staging table
select 
Vendor_fwd_pk as Vendor_fwd_fk,
extract(year from tpep_pickup_datetime)*10000000000+extract(month from tpep_pickup_datetime)*100000000+
extract(day from tpep_pickup_datetime)*1000000 +hour(tpep_pickup_datetime)*10000+minute(tpep_pickup_datetime)*100
+second(tpep_pickup_datetime) as tpep_pickup_datetime_fk,
extract(year from tpep_dropoff_datetime)*10000000000+extract(month from tpep_dropoff_datetime)*100000000+
extract(day from tpep_dropoff_datetime)*1000000 +hour(tpep_dropoff_datetime)*10000+minute(tpep_dropoff_datetime)*100+
second(tpep_dropoff_datetime)
as tpep_dropoff_datime_fk
,passanger_count,trip_distance,
Rate_Payment_pk as RateCodeID_payment_fk,PulocationID,DolocationID,
fare_amount,extra,mta_tax,tip_amount,tolls_amount,
improvement_surcharge,total_amount,congestion_surcharge,airport_free
from  `uber data`.staging_uber_data sud
left join  `uber data`.RateCodeID_Payment RCP on rcp.RateCodeId_number = sud.RateCodeID and rcp.Payment_type_number = sud.payment_type
left join  `uber data`.Vendor_flag_dimension vfd on vfd.VendoridNumber=sud.VendorId and vfd.flagidnumber=sud.store_and_fwd_flag

-- creating fact table 
drop table if exists `uber data`.fact_uber
create table `uber data`.fact_uber(
	transaction_number int primary key auto_increment,
	Vendor_fwd_fk   int  null,tpep_pickup_datetime_fk bigint not null,tpep_dropoff_datetime_fk bigint not null,
    passanger_count float null,trip_distance float null,RatecodeID_payment_fk int null,
	PULocationID int(64) null,DOLocationID int(64) null,
    fare_amount float null,extra float null,
    mta_tax float null,tip_amount float null,tolls_amount float null,improvement_surcharge float null,
	total_amount float null,congestion_surcharge float null,airport_fee float null
    )

select * from `uber data`.fact_uber