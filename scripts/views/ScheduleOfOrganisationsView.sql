use hsemap_db_edu
go

CREATE VIEW ScheduleOfOrganisations
AS SELECT Organisation_Name, [Type], Campus_Name, Room_Number, Start_Time, End_Time, Week_day
FROM Labor_day, Time_span, Organisation, Room_Organisation, Schedule_Organisation
WHERE
Labor_day.ID_Time_span = Time_span.ID_Time_span
and
Organisation.ID_Organisation = Room_Organisation.ID_Organisation
and 
Organisation.ID_Organisation = Schedule_Organisation.ID_Organisation
and
Labor_day.ID_Labor_day = Schedule_Organisation.ID_Labor_day
