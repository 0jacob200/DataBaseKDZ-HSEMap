--���� ������� �������� ����� �� � ���� �������� �� ������ ���� �������� (������ ������� �������)
insert into [dbo].[Professor]
values ('���������', '�����', '����������', '������', 'ntgqucasvaegm@hse.ru')

select * from [dbo].[Professor] where Professor_Email = 'ntgqucasvaegm@hse.ru'
go

--waitfor delay '00:00:05'

delete from [dbo].[Professor]
where Professor_Email= 'ntgqucasvaegm@hse.ru'

select * from [dbo].[Student] where Student_Email= 'ntgqucasvaegm@hse.ru'

