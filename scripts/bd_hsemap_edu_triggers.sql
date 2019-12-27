use [hsemap_db_edu]
go

create trigger Email_Student_Edu_hse_ru on [dbo].[Student]
	instead of insert
as
begin
	--declare @email varchar(64);
	--declare @firstN varchar(64);
	--declare @secondN varchar(64);
	--declare @surname varchar(128);

	--set @email = (select Student_Email from inserted)
	--set @firstN = (select First_Name from inserted)
	--set @secondN = (select Second_Name from inserted)
	--set @surname = (select Surname from inserted)
	insert into Student
	select * from inserted where 
	(Student_Email like '%__@edu.hse.ru') and
	(Surname like '__%') and (First_Name like '__%') and (Second_Name like '__%')
end
go

create trigger Email_Professor_hse_ru on [dbo].[Professor]
	instead of insert
as
begin
	insert into [dbo].[Professor]
	select * from inserted where 
	(Professor_Email like '%__@hse.ru') and
	(Surname like '__%') and (First_Name like '__%') and (Second_Name like '__%') and
	([Rank] in ('Старший преподаватель','Тьютр','Доцент','Профессор',
	'Приглашенный преподаватель','Преподаватель'))
end