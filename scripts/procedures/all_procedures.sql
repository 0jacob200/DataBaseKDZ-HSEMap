Create or alter procedure InsertNewStudentWithGroup
(@email varchar(64),
@firstName nvarchar(64),
@secondName nvarchar(64),
@surname nvarchar(128),
@fullGroupNumber nvarchar(16)) as
begin
	if @email not in (select Student_Email from Student) 
	and @fullGroupNumber in (select Full_Group_Number from Groups)
	begin
		insert into Student values (@firstName, @secondName, @surname, @email);
		insert into Groups_Student values (@fullGroupNumber, @email);
	end;
	else
		print('Не получилось добавить студента')
end;

Create or alter procedure AddClassForGroup
(@startTime time(0),
@endTime time(0),
@CampusName nvarchar(64),
@buildingName nvarchar(32),
@roomNumber nvarchar(16),
@classDate date,
@nameOfSubject nvarchar(128),
@professorEmail varchar(64),
@fullGroupNumber nvarchar(16)) as
begin
	if @classDate is null
	begin
		print('Дата не задана');
		return;
	end;
	if (select count(*) from Groups where Full_Group_Number = @fullGroupNumber) = 0
	begin
		print('Группы не существует');
		return;
	end;
	if (@professorEmail is not null) and (select count(*) from Professor where Professor_Email = @professorEmail) = 0
	begin
		print('Профессора не существует');
		return;
	end;

	declare @timeSpanId integer;
	if (select count(ID_Time_span) from Time_span where Start_time = @startTime and End_time = @endTime) = 0
	begin
		insert into Time_span (Start_time, End_time) values(@startTime, @endTime);
	end;
	set @timeSpanId = (select top(1) ID_Time_span from Time_span where Start_time = @startTime and End_time = @endTime);
	begin try
		insert into Class values
		(@timeSpanId, @CampusName, @buildingName, @roomNumber, @classDate, @nameOfSubject, @professorEmail);
		insert into Groups_Class values (@fullGroupNumber, @timeSpanId, @CampusName, @buildingName, @roomNumber, @classDate);
	end try
	begin catch
		print('Не удалось добавить пару');
	end catch;
end;