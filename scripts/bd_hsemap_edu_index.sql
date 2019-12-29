use hsemap_db_edu
go

create NONCLUSTERED index Student_Index on Student (Surname, First_Name, Second_Name)
go
