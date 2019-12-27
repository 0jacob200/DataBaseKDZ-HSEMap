-- Тригер по проверке, что почты @edu.hse.ru и перед собакой есть две буквы
use [hsemap_db_edu]
go

create trigger Email_Student_Edu_hse_ru on [dbo].[Student]
	instead of insert
as
begin
	declare @email varchar(64);
	declare @firstN varchar(64);
	declare @secondN varchar(64);
	declare @surname varchar(128);

	set @email = (select Student_Email from inserted)
	set @firstN = (select First_Name from inserted)
	set @secondN = (select Second_Name from inserted)
	set @surname = (select Surname from inserted)

	if (@email like '%__@edu.hse.ru') and
	(@surname like '__%') and (@firstN like '__%') and (@secondN like '__%')
		begin
			insert into [dbo].[Student]
			values (@firstN, @secondN, @surname, @email)
		end
end