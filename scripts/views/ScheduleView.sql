use hsemap_db_edu
go

CREATE VIEW Schedule
AS SELECT Start_Time, End_Time, Campus_Name, Room_Number, Date_Class, DATENAME(dw, Date_Class) AS Week_Day, Name_of_subject,
 CONCAT(Surname, ' ', First_Name,' ', Second_Name) AS FSS
FROM Class, Time_span, Professor
WHERE
Class.ID_Time_span = Time_span.ID_Time_span
and
Professor.Professor_Email = Class.Professor_Email

