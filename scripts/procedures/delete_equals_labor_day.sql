Create or alter procedure DeleteEqualsLaborDay as
begin try
	begin tran;
	save tran savepoint;
	declare @repeats as table(first_id int not null, second_id int not null);
	insert into @repeats
	select ld2.ID_Labor_day, min(ld1.ID_Labor_day) 
	from Labor_day as ld1, Labor_day as ld2 
	where ld1.Week_day = ld2.Week_day
	and ld1.ID_Time_span = ld2.ID_Time_span
	and ld1.ID_Labor_day < ld2.ID_Labor_day
	group by ld2.ID_Labor_day;

	update Schedule_Campus
	set	ID_Labor_day = (select top(1) second_id from @repeats
	where first_id = ID_Labor_day) where ID_Labor_day in (select first_id from @repeats);
	save tran savepoint;

	update Schedule_Organisation 
	set ID_Labor_day = (select top(1) second_id from @repeats
	where first_id = ID_Labor_day) where ID_Labor_day in (select first_id from @repeats);
	save tran savepoint;

	delete from Labor_day where ID_Labor_day in (select first_id from @repeats);
	commit tran;
end try
begin catch
	rollback tran savepoint;
	commit tran;
end catch;