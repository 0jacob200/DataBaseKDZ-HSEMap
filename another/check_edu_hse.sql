--���� ������� �������� ����� �� � ���� �������� �� ������ ���� �������� (������ ������� �������)
insert into [dbo].[Professor]
values ('���������', '�����', '����������', '������', 'ntgqucasvaegm@he.ru'),
('���������', '�����', '�����������', '������', 'iyxzdvmahkihse.ru')

select * from [dbo].[Professor] where Professor_Email = 'ntgqucasvaegm@he.ru'
go

--waitfor delay '00:00:05'

delete from [dbo].[Professor]
where Professor_Email= 'ntgqucasvaegm@hse.ru'

select * from [dbo].[Student] where Student_Email= 'ntgqucasvaegm@he.ru'
