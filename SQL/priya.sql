drop table Booking
create table Booking(booking_id int primary key,
u_id int FOREIGN KEY(u_id) REFERENCES TBL_USER(USER_ID),
train_id int FOREIGN KEY(train_id) REFERENCES TRAIN_DETAILS(TRAIN_ID),
passenger_count int not null,
totalamount int not null,
seat_count int not null,
pnr_no varchar(20) not null,
booking_status int FOREIGN KEY(booking_status) REFERENCES booking_status(status_id),
booking_date datetime not null default getdate(),
CreatedBy varchar(20) not null,
CreatedDate datetime not null default getdate(),
modifiedBy varchar(20) not null,
modifiedDate datetime not null default getdate(),
RecordStatus Bit default 1,
RowGuid varchar(Max) default newid())

select * from Booking
drop table Booking

create table booking_status(status_id INT PRIMARY KEY,status_ VARCHAR(20),
CreatedBy varchar(20) not null,
CreatedDate datetime not null default getdate(),
modifiedBy varchar(20) not null,
modifiedDate datetime not null default getdate(),
RecordStatus Bit default 1,
RowGuid varchar(Max) default newid())





--SP

--booking table storedprocedure --- priyadharshini

create procedure sp_bookingSTATUS_insert 
@STATUS_id int,
@STATUS VARCHAR(20),
@CreatedBy varchar(20),
@modifiedBy varchar(20),
@statement varchar(20)
AS
BEGIN
IF @statement='INSERT'
	BEGIN
	INSERT INTO booking_status(status_id,status_,CreatedBy,modifiedBy) VALUES(@STATUS_id,@STATUS,@CreatedBy,@modifiedBy)
	END
END

exec sp_bookingSTATUS_insert 5,'booked','priya','priya','INSERT'

select * from booking_status

create procedure sp_bookingSTATUS_UPDATE 
@STATUS_id int,
@STATUS VARCHAR(20),
@modifiedBy varchar(20),
@statement varchar(20)
AS
BEGIN
IF @statement='UPDATE'
	BEGIN
	UPDATE booking_status set status_=@STATUS,modifiedby=@modifiedBy where status_id=@STATUS_id
	END
END
exec sp_bookingSTATUS_update 1,'booked','priya','UPDATE'
select * from booking_status

create procedure sp_booking_insert 
@booking_id int,
@u_id int,
@train_id int,
@passenger_count int,
@totalamount int,
@seat_count int,
@pnr_no int,
@booking_status int,
@CreatedBy varchar(20),
@modifiedBy varchar(20),
@statement varchar(20)
AS
BEGIN
IF @statement='INSERT'
	BEGIN
	insert into Booking(booking_id,u_id,train_id,passenger_count,totalamount,seat_count,pnr_no,booking_status,CreatedBy,modifiedBy) 
values(@booking_id,@u_id,@train_id,@passenger_count,@totalamount,@seat_count,@pnr_no,@booking_status,@CreatedBy,@modifiedBy)
	END;
END


exec sp_booking_insert 5,5,100,3,45,55,66,1,'priya','priya','INSERT'

alter procedure sp_booking_update 
@booking_id int,
@passenger_count int,
@totalamount int,
@booking_status int,
@seat_count int,
@modifiedBy varchar(20),
@statement varchar(20)
AS
BEGIN
IF @statement='UPDATE'
	BEGIN
	UPDATE Booking SET passenger_count =@passenger_count,booking_status=@booking_status,totalamount=@totalamount,seat_count=@seat_count,modifiedBy=@modifiedBy WHERE booking_id = @booking_id;
	END;

END

exec sp_booking_update 1,5,45,1,5,'hello','UPDATE'
create procedure sp_booking_delete 
@booking_id int,
@RecordStatus int,
@modifiedBy varchar(20),
@statement varchar(20)
AS
BEGIN
IF @statement='DELETE'
	BEGIN
	UPDATE Booking SET RecordStatus=@RecordStatus,modifiedBy=@modifiedBy WHERE booking_id = @booking_id;

	END;

END

exec sp_booking_delete 1,0,'priya','DELETE'

select * from booking

create procedure sp_booking_Read
@booking_id int,
@statement varchar(20)
AS
BEGIN
IF @statement='SELECT'
	BEGIN
	SELECT * FROM Booking WHERE booking_id=@booking_id
	END;

END

exec sp_booking_Read 1,'SELECT'

create procedure sp_booking_list
@booking_id int,
@u_id int,
@statement varchar(20)
AS
BEGIN
IF @statement='SELECT'
	BEGIN
	SELECT * FROM Booking WHERE u_id=@u_id
	END;

END

exec sp_booking_list 1,5,'SELECT'



