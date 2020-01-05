-- триггер на правильность введения данных о студентах: почта оканчивается на @edu.hse.ru и ФИО не может содержать меньше чем 2 буквы
create or alter trigger Email_Student_Edu_hse_ru on [dbo].[Student]
	instead of insert
as
begin
	insert into Student
	select * from inserted where 
	(Student_Email like '%__@edu.hse.ru') and
	(Surname like '__%') and (First_Name like '__%') and (Second_Name like '__%')
end
go

-- триггер на правильность введения данных о преподавателей: почта оканчивается на @hse.ru, ФИО не может содержать меньше чем 2 буквы
-- и ранг преподавания лежит в ограниченном множестве значений 
create or alter trigger Email_Professor_hse_ru on [dbo].[Professor]
	instead of insert
as
begin
	insert into [dbo].[Professor]
	select * from inserted where 
	(Professor_Email like '%__@hse.ru') and
	(Surname like '__%') and (First_Name like '__%') and (Second_Name like '__%') and
	([Rank] in ('Старший преподаватель','Тьютор','Доцент','Профессор',
	'Приглашенный преподаватель','Преподаватель'))
end