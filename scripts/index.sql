use hsemap_db_edu
go

create UNIQUE NONCLUSTERED index Professor_Index on Professor (Professor_Email)
go
