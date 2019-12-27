use hsemap_db_edu
go

CREATE FUNCTION FindRoom (@StartRoomNumber varchar(16))
RETURNS TABLE
AS
RETURN
(
	SELECT Building_Name, Room_Number FROM Room
	WHERE Room_Number LIKE (@StartRoomNumber + '%')
);