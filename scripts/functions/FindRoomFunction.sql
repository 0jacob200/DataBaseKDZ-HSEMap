use hse_map_test4
go

CREATE FUNCTION FindRoom (@StartRoomNumber varchar(16))
RETURNS TABLE
AS
RETURN
(
	SELECT Building_Name, Room_Number FROM Room
	WHERE Room_Number LIKE (@StartRoomNumber + '%')
);