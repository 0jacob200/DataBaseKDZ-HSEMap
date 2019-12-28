use hsemap_db_edu
go

--������� ������ � �������� � ��������� � SELECT � 2

/*
select Full_Group_Number, Student_count from [dbo].[Groups]
where Full_Group_Number like 'BBI18__'
go

select [Building_Name], [Room_Number], [Capacity], [Type] from [dbo].[Room]
where [Campus_Name] = '��������' and 
[Capacity] between 14 and 36
and [Building_Name] not in ('A', 'F', 'L', 'S')
and [Type] = '���������'
go
*/

--������ � ��������������� ����������� � SELECT � 2

/*
select Room_Number from [dbo].[Room_Organisation]
where [Campus_Name]='��� "�����������"' and [ID_Organisation] in
(select ID_Organisation from [dbo].[Organisation] where [Type] = '������� ����')
go

select Short_Faculty_Name from [dbo].[Campus_Faculty]
where Campus_Name = (select Campus_Name from [dbo].[Campus]
where [Main_Address]='���������� ������� �.11')
go
*/

--������ � ����������� � FROM� 2

select * from 
(select * from [dbo].[Organisation] where [Type] = '��������') as org 
join 
(select ld.ID_Labor_day, ID_Organisation, Week_day from [dbo].[Schedule_Organisation] as s
join [dbo].[Labor_day] as ld on s.ID_Labor_day = ld.ID_Labor_day) as s_org 
on org.ID_Organisation = s_org.ID_Organisation

--������ � ����������� � FROM, ��������������, ������������ � ����������� � 2 



--������ � ��������������� ����������� � WHERE� 2 



--������, ������������ ������� ������� LAG ��� LEAD ��� ���������� ��������� ������ � ������ �������� � 1



--������ � �������������� � ���������� JOIN, ���������� �� ����� 2 ������ � 3 



--������ � EXISTS � 1



--������, ������������ ����������� � ����������� - 1 



--������ � ������� ����������� � ��������� �� ������� NULL � 1 



--������ � �������������� � ���������� JOIN, ���������� �� ����� 3 ������/��������� � 1



--������ � CASE (IIF) � �������������� � 1 



--������ � HAVING � �������������� � 1 



--������ SELECT INTO ��� ���������� �������� � 1 



--������ � PIVOT ��� ���������� ������� ������ � 1 


