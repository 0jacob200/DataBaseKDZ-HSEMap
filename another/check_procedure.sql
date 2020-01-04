Insert into Time_span (Start_time, End_time)
values ('9:00:00', '10:20:00')
go

declare @idtimespan int;
set @idtimespan = (select top(1) ID_Time_span from Time_span
order by ID_Time_span Desc)

insert into Class
values (@idtimespan, 'АУК "Шаболовская"', 5, 5410, '2019-12-17', 'Английский язык', 'tkashkarova@hse.ru')
go

DECLARE	@return_value int

EXEC	@return_value = [dbo].[DeleteEqualsTimeSpan]

SELECT	'Return Value' = @return_value

GO

select * from Class

select * from Time_span