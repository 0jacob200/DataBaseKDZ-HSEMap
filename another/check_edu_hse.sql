--���� ������� �������� ����� �� � ���� �������� �� ������ ���� �������� (������ ������� �������)
insert into [dbo].[Professor]
values ('������� ��������������','g1hs', '3asa', 'ssssla', 'adsf@hse.ru')

select * from [dbo].[Professor] where Professor_Email = 'adsf@hse.ru'
go

--waitfor delay '00:00:05'

delete from [dbo].[Professor]
where Professor_Email= 'adsf@hse.ru'
select * from [dbo].[Student] where Student_Email= 'adsf@hse.ru'

