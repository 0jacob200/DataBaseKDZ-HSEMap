--если триггер работает верно то в двух таблицах не должно быть кортежей (данные введены неверно)
insert into [dbo].[Professor]
values ('Профессор', 'Мария', 'Георгиевна', 'Борева', 'ntgqucasvaegm@he.ru'),
('Профессор', 'Остап', 'Куприянович', 'Киреев', 'iyxzdvmahkihse.ru')

select * from [dbo].[Professor] where Professor_Email = 'ntgqucasvaegm@he.ru'
go

--waitfor delay '00:00:05'

delete from [dbo].[Professor]
where Professor_Email= 'ntgqucasvaegm@hse.ru'

select * from [dbo].[Student] where Student_Email= 'ntgqucasvaegm@he.ru'
