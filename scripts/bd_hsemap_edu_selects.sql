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



--Запрос с подзапросом в FROM– 2

select * from 
(select * from [dbo].[Organisation] where [Type] = 'Столовая') as org 
join 
(select ld.ID_Labor_day, ID_Organisation, Week_day from [dbo].[Schedule_Organisation] as s
join [dbo].[Labor_day] as ld on s.ID_Labor_day = ld.ID_Labor_day) as s_org 
on org.ID_Organisation = s_org.ID_Organisation

--Запрос с подзапросом в FROM, агрегированием, группировкой и сортировкой – 2 

SELECT * FROM
(SELECT Campus_Name, AVG(Capacity) AS AVG_Room_Capacity FROM Room
GROUP BY Campus_Name ORDER BY AVG_Room_Capacity DESC OFFSET 0 ROWS) AS RoomsCapacity

SELECT * FROM
(SELECT Edu_prog_name, Edu_level, Year_of_enrollment, SUM(Student_count) AS Students_Amount FROM Groups
GROUP BY Edu_prog_name, Edu_level, Year_of_enrollment
ORDER BY Edu_prog_name, Edu_level ASC OFFSET 0 ROWS) AS StudentsAmountOnEachCourse
		
--Запрос с коррелированным подзапросом в WHERE– 2 

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


