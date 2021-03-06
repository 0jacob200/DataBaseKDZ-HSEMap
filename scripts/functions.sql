-- ��� ������� ��������� �� ���� ����� �������� � ����. ���������� ��� ���������� � ���� ����
CREATE FUNCTION SearchForClasses (@Email varchar(64), @Date date)
RETURNS TABLE
AS
RETURN
(
	SELECT ID_Time_span, Campus_Name, Building_Name, Room_Number FROM Groups_Class WHERE (Full_Group_Number
	in (SELECT Full_Group_Number FROM Groups_Student WHERE Student_Email = @Email))
	and Date_Class = @Date

	UNION

	SELECT ID_Time_span, Campus_Name, Building_Name, Room_Number FROM Student_Addition_Class WHERE Student_Email = @Email
	and Date_Class = @Date
);
go

-- ��� ������� ��������� ������ ����� ��������� � ���������� ��� ���������, ������� ���������� � ��� �� ����\����
CREATE FUNCTION FindRoom (@StartRoomNumber varchar(16))
RETURNS TABLE
AS
RETURN
(
	SELECT Building_Name, Room_Number FROM Room
	WHERE Room_Number LIKE (@StartRoomNumber + '%')
);