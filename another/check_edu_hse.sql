use hsemap_db_edu
go

--если триггер работает верно то в двух таблицах не должно быть кортежей (данные введены неверно)
insert into [dbo].[Professor]
values ('Профессор', 'Мария', 'Георгиевна', 'Борева', 'ntgqucasvaegm@he.ru')
go

select * from [dbo].[Professor] where Professor_Email = 'ntgqucasvaegm@he.ru'
go

delete from [dbo].[Professor]
where Professor_Email= 'ntgqucasvaegm@he.ru'
go

select * from Professor where Professor_Email= 'ntgqucasvaegm@he.ru'
