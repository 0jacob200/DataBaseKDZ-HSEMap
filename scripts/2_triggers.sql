-- ������� �� ������������ �������� ������ � ���������: ����� ������������ �� @edu.hse.ru � ��� �� ����� ��������� ������ ��� 2 �����
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

-- ������� �� ������������ �������� ������ � ��������������: ����� ������������ �� @hse.ru, ��� �� ����� ��������� ������ ��� 2 �����
-- � ���� ������������ ����� � ������������ ��������� �������� 
create or alter trigger Email_Professor_hse_ru on [dbo].[Professor]
	instead of insert
as
begin
	insert into [dbo].[Professor]
	select * from inserted where 
	(Professor_Email like '%__@hse.ru') and
	(Surname like '__%') and (First_Name like '__%') and (Second_Name like '__%') and
	([Rank] in ('������� �������������','������','������','���������',
	'������������ �������������','�������������'))
end