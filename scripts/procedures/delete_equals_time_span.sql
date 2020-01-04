Create or alter procedure DeleteEqualsTimeSpan as
begin try
	begin tran;
	save tran savepoint;
	declare @repeats as table(first_id int not null, second_id int not null);
	insert into @repeats
	select ts2.ID_Time_span, min(ts1.ID_Time_span) 
	from Time_span as ts1, Time_span as ts2 
	where ts1.Start_time = ts2.Start_time 
	and ts1.End_time = ts2.End_time 
	and ts1.ID_Time_span < ts2.ID_Time_span 
	group by ts2.ID_Time_span;

	update Labor_day
	set	ID_Time_span = (select top(1) second_id from @repeats
	where first_id = ID_Time_span) where ID_Time_span in (select first_id from @repeats);
	save tran savepoint;

	update Class set ID_Time_span = (select top(1) second_id from @repeats
	where first_id = ID_Time_span) where ID_Time_span in (select first_id from @repeats);
	save tran savepoint;
	delete from Time_span where ID_Time_span in (select first_id from @repeats);
	commit tran;
end try
begin catch
	rollback tran savepoint;
end catch;