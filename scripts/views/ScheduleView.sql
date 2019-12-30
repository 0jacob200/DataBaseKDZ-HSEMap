CREATE VIEW Schedule
AS SELECT Start_Time, End_Time, Class.Campus_Name, Class.Room_Number, 
Class.Date_Class, DATENAME(dw, Class.Date_Class) AS Week_Day, Full_Group_Number, Name_of_subject,
 CONCAT(Surname, ' ', First_Name,' ', Second_Name) AS FSS
FROM Class, Time_span, Professor, Groups_Class
WHERE
Class.ID_Time_span = Time_span.ID_Time_span
and
Professor.Professor_Email = Class.Professor_Email
and
Groups_Class.ID_Time_span = Class.ID_Time_span

