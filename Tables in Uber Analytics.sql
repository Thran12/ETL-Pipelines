# creating a empty database using parquet

create database `Uber Data`

create table `Uber Data`.Uber_data(
	VendorID   int  null,tpep_pickup_datetime timestamp null,tpep_dropoff_datetime timestamp null,
    passanger_count float null,trip_distance float null,RatecodeID float null,
    store_and_fwd_flag char(2)  null,PULocationID int(64) null,DOLocationID int(64) null,
    Payment_type int(64) null,fare_amount float null,extra float null,
    mta_tax float null,tip_amount float null,tolls_amount float null,improvement_surcharge float null,
	total_amount float null,congestion_surcharge float null,airport_free float null
)

# read parquet data as source for sql

select column_name, data_type from information_schema.columns where table_name = 'uber_data'

-- select * from `uber data`.uber_data
-- select @@hostname
-- GRANT all privileges on dbx.`uber data` to 'ALI'@'localhost' IDENTIFIED BY '1234' WITH GRANT OPTION;

drop table if exists  `Uber Data`.Uber_data
select * from `Uber Data`.Uber_data 

-- creating pickup date dimension
create table `uber data`.tpep_pickup_dimension(
date_pk int primary key,
tpep_pickup_datetime timestamp not null,
tpep_day int not null,tpep_month int not null ,
tpep_year int not null
)
alter table `uber data`.tpep_pickup_dimension modify date_pk BIGINT
drop table if exists `uber data`.tpep_pickup_dimension
select * from `uber data`.tpep_pickup_dimension

-- create ratecode and payment dimension
create table `uber data`.RateCodeID_Payment(
Rate_Payment_Pk int primary key auto_increment,
RateCodeID text not null,
RateCodeId_number int not null,
payment_type text not null,
Payment_type_number int not null
)
drop table if exists `uber data`.RateCodeID_Payment
select * from `uber data`.RateCodeID_Payment

-- create staging layer 
create table `uber data`.Staging_uber_data(
   ride_id int primary key auto_increment,
	VendorID   int  null,
    tpep_pickup_datetime timestamp null,tpep_dropoff_datetime timestamp null,
    passanger_count float null,trip_distance float null,
    RatecodeID float null,store_and_fwd_flag char(2)  null,
    PULocationID int(64) null,DOLocationID int(64) null,Payment_type int(64) null,
    fare_amount float null,extra float null,mta_tax float null,
    tip_amount float null,tolls_amount float null,improvement_surcharge float null,
    total_amount float null,congestion_surcharge float null,airport_free float null
)
drop table if exists `uber data`.Staging_uber_data
select * from `uber data`.Staging_uber_data
-- create dropoff date dimension
create table `uber data`.tpep_dropoff_dimension(
datedrop_pk int primary key,
tpep_dropoff_datetime timestamp not null,
tdrop_day int not null,tdrop_month int not null ,
tdrop_year int not null
)
alter table `uber data`.tpep_dropoff_dimension modify datedrop_pk BIGINT
drop table if exists `uber data`.tpep_dropoff_dimension
select * from `uber data`.tpep_dropoff_dimension

-- create vendor flag dimension
create table `uber data`.Vendor_flag_dimension(
Vendor_Fwd_pk int primary key auto_increment,
VendorName text not null,
VendorIDnumber int not null,
FlagName text not null,
flagidnumber text not null
)
drop table if exists `uber data`.Vendor_flag_dimension
select * from `uber data`.Vendor_flag_dimension
