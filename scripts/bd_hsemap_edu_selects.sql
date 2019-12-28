use hsemap_db_edu
go

--Простой запрос с условием и формулами в SELECT – 2

/*
select Full_Group_Number, Student_count from [dbo].[Groups]
where Full_Group_Number like 'BBI18__'
go

select [Building_Name], [Room_Number], [Capacity], [Type] from [dbo].[Room]
where [Campus_Name] = 'Покровка' and 
[Capacity] between 14 and 36
and [Building_Name] not in ('A', 'F', 'L', 'S')
and [Type] = 'Аудитория'
go
*/

--Запрос с коррелированным подзапросом в SELECT – 2

/*
select Room_Number from [dbo].[Room_Organisation]
where [Campus_Name]='АУК "Шаболовская"' and [ID_Organisation] in
(select ID_Organisation from [dbo].[Organisation] where [Type] = 'Учебный офис')
go

select Short_Faculty_Name from [dbo].[Campus_Faculty]
where Campus_Name = (select Campus_Name from [dbo].[Campus]
where [Main_Address]='Покровский бульвар д.11')
go
*/

--Запрос с подзапросом в FROM– 2



--Запрос с подзапросом в FROM, агрегированием, группировкой и сортировкой – 2 



--Запрос с коррелированным подзапросом в WHERE– 2 



--Запрос, использующий оконную функцию LAG или LEAD для выполнения сравнения данных в разных периодах – 1



--Запрос с агрегированием и выражением JOIN, включающим не менее 2 таблиц – 3 



--Запрос с EXISTS – 1



--Запрос, использующий манипуляции с множествами - 1 



--Запрос с внешним соединением и проверкой на наличие NULL – 1 



--Запрос с агрегированием и выражением JOIN, включающим не менее 3 таблиц/выражений – 1



--Запрос с CASE (IIF) и агрегированием – 1 



--Запрос с HAVING и агрегированием – 1 



--Запрос SELECT INTO для подготовки выгрузки – 1 



--Запрос с PIVOT для проведения анализа данных – 1 


