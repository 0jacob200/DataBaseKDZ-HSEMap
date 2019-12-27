use hse_map_test3
go

CREATE FUNCTION FindRoom (@StartRoomNumber varchar(16))
RETURNS TABLE
AS
RETURN
(
	SELECT Building, Room_Number FROM Room
	WHERE Room_Number LIKE (@StartRoomNumber + '%')
);

go
select * from FindRoom('2')