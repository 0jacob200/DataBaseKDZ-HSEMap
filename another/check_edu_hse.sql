use hsemap_db_edu
go

--���� ������� �������� ����� �� � ���� �������� �� ������ ���� �������� (������ ������� �������)
insert into [dbo].[Professor]
values ('���������', '�����', '����������', '������', 'ntgqucasvaegm@he.ru')
go

select * from [dbo].[Professor] where Professor_Email = 'ntgqucasvaegm@he.ru'
go

delete from [dbo].[Professor]
where Professor_Email= 'ntgqucasvaegm@he.ru'
go

select * from Professor where Professor_Email= 'ntgqucasvaegm@he.ru'
