use hsemap_db_edu
go

--Простой запрос с условием и формулами в SELECT – 2

select Full_Group_Number, Student_count from [dbo].[Groups]
where Full_Group_Number like 'BBI18__'
go

select [Building_Name], [Room_Number], [Capacity], [Type] from [dbo].[Room]
where [Campus_Name] = 'Покровка' and 
[Capacity] between 14 and 36
and [Building_Name] not in ('A', 'F', 'L', 'S')
and [Type] = 'Аудитория'

--Запрос с коррелированным подзапросом в SELECT – 2



--Запрос с подзапросом в FROM– 2

/*
select * from 
(select * from [dbo].[Organisation] where [Type] = 'Столовая') as org 
join 
(select ld.ID_Labor_day, ID_Organisation, Week_day from [dbo].[Schedule_Organisation] as s
join [dbo].[Labor_day] as ld on s.ID_Labor_day = ld.ID_Labor_day) as s_org 
on org.ID_Organisation = s_org.ID_Organisation
*/

--Запрос с подзапросом в FROM, агрегированием, группировкой и сортировкой – 2 

SELECT * FROM
(SELECT Campus_Name, AVG(Capacity) AS AVG_Room_Capacity FROM Room
GROUP BY Campus_Name ORDER BY AVG_Room_Capacity DESC OFFSET 0 ROWS) AS RoomsCapacity

SELECT * FROM
(SELECT Edu_prog_name, Edu_level, Year_of_enrollment, SUM(Student_count) AS Students_Amount FROM Groups
GROUP BY Edu_prog_name, Edu_level, Year_of_enrollment
ORDER BY Edu_prog_name, Edu_level ASC OFFSET 0 ROWS) AS StudentsAmountOnEachCourse
		
--Запрос с коррелированным подзапросом в WHERE– 2 

select Room_Number from [dbo].[Room_Organisation]
where [Campus_Name]='АУК "Шаболовская"' and [ID_Organisation] in
(select ID_Organisation from [dbo].[Organisation] where [Type] = 'Учебный офис')
go

select Short_Faculty_Name from [dbo].[Campus_Faculty]
where Campus_Name = (select Campus_Name from [dbo].[Campus]
where [Main_Address]='Покровский бульвар д.11')


--Запрос, использующий оконную функцию LAG или LEAD для выполнения сравнения данных в разных периодах – 1

SELECT Campus_Name, Building_name, Room_Number, Start_time, End_time,
LAG(Start_Time) OVER(ORDER BY Start_time) AS PreviousClass_StartTime,
LAG(End_Time) OVER(ORDER By End_time) AS PreviousClass_EndTime
FROM SearchForClasses('ogzelyanin@edu.hse.ru', '2019-12-27')
JOIN Time_span ON SearchForClasses.ID_Time_span = Time_span.ID_Time_span


--Запрос с агрегированием и выражением JOIN, включающим не менее 2 таблиц – 3 

SELECT Building.Campus_Name, Building.Building_Name, Address, MaxFloor, Room_Number FROM Building
JOIN Room ON Building.Campus_Name = Room.Campus_Name
AND Building.Building_Name = Room.Building_Name
JOIN (SELECT Campus_Name, MAX(Floor_count) AS MaxFloor FROM Building GROUP BY Campus_Name) AS Campus_Floor
ON Building.Campus_Name = Campus_Floor.Campus_Name 
AND
Building.Floor_count = Campus_Floor.MaxFloor

SELECT Main_Address, Campus.Campus_Name, Organisation_Amount FROM Campus
JOIN (SELECT Campus_Name, COUNT(ID_Organisation) AS Organisation_Amount FROM Room_Organisation GROUP BY Campus_Name) AS CampusOrg
ON Campus.Campus_Name = CampusOrg.Campus_Name


--Запрос с EXISTS – 1

SELECT Campus_Name, Room_Number, Capacity, Type FROM Room
WHERE Capacity >= 30 AND EXISTS (SELECT End_time FROM Time_span
WHERE Start_time >= CONVERT(varchar(20), GETDATE(), 108))

--Запрос, использующий манипуляции с множествами - 1 

select * from 
(
select FSS, Short_Faculty_Name from (select FSS, Edu_prog_name from
(select FSS, Full_Group_Number from Schedule) as PS 
join Groups as g on g.Full_Group_Number = PS.Full_Group_Number) as PSProg 
join [dbo].[Education_program] as EProg on PSProg.Edu_prog_name = EProg.Edu_prog_name 
where Short_Faculty_Name = 'ФБМ'
) as P
union 
(
select FSS, Short_Faculty_Name from 
(select FSS, Edu_prog_name from 
(select CONCAT(Surname, ' ', First_Name,' ', Second_Name) as FSS, Full_Group_Number
from Student as S join Groups_Student as GS on S.Student_Email = GS.Student_Email) as SG join 
Groups as G on SG.Full_Group_Number = G.Full_Group_Number) as SEP join Education_program as EP
on EP.Edu_prog_name = SEP.Edu_prog_name
where Short_Faculty_Name = 'ФБМ'
)

--Запрос с внешним соединением и проверкой на наличие NULL – 1 

SELECT CONCAT(Surname, ' ', First_Name,' ', Second_Name) AS FSS, 
ISNULL(Name_of_subject, 'Не ведёт ни один предмет') AS Name_of_subject,
ISNULL(Room_Number, 'Не найден') AS Room_Number, Date_Class
FROM Professor LEFT OUTER JOIN
Class ON Professor.Professor_Email = Class.Professor_Email

--Запрос с агрегированием и выражением JOIN, включающим не менее 3 таблиц/выражений – 1

select Short_Faculty_Name as Faculty, avg(Num_Labor_Weekday) as Avg_Num_Labor_Weekday
from (select UO.ID_Organisation, Organisation_Name, count(ID_Labor_day) as Num_Labor_Weekday from 
(select * from Organisation where [Type] = 'Учебный офис') as UO 
join Schedule_Organisation as SO on UO.ID_Organisation = SO.ID_Organisation
Group by Organisation_Name, UO.ID_Organisation) as UOS 
join Education_program as EDU on EDU.ID_Organisation = UOS.ID_Organisation
group by Short_Faculty_Name
go


--Запрос с CASE (IIF) и агрегированием – 1 

SELECT CONCAT(Surname, ' ', First_Name,' ', Second_Name) AS FSS,
Student_count, Class.Room_number, Capacity,
CASE
	WHEN Capacity <= Student_count THEN 'В аудитории не хватает места'
	ELSE 'Подходящая аудитория'
END Message
FROM Professor
JOIN Class ON Professor.Professor_Email = Class.Professor_Email
JOIN Groups_Class ON Groups_Class.Room_Number = Class.Room_Number
JOIN Groups ON Groups_Class.Full_Group_Number = Groups.Full_Group_Number
JOIN Room ON Room.Room_Number = Class.Room_Number

--Запрос с HAVING и агрегированием – 1 

select Edu_level, Edu_prog_name, [Year_of_enrollment], sum(Student_count) as Number_of_Student from Groups
group by Edu_level, Edu_prog_name, Year_of_enrollment
having sum(Student_count) <= 90

--Запрос SELECT INTO для подготовки выгрузки – 1 

--select * into Education_Office from 
--(select concat(Type, ' ', Organisation_Name) as Education_Office, count(ID_Labor_day) as Num_of_Labor_day, Room_Number from Organisation as Org
--join Schedule_Organisation as So on Org.ID_Organisation = So.ID_Organisation
--join Room_Organisation as RO on RO.ID_Organisation = Org.ID_Organisation
--where [Type] = 'Учебный офис'
--Group by Organisation_Name, [Type], Room_Number) as P

--Запрос с PIVOT для проведения анализа данных – 1 


