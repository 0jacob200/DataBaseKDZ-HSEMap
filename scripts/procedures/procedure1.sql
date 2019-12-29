use hsemap_db_edu
go

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
go