create or alter procedure RemoveStudent(@email varchar(32)) as
begin
	declare @st_count int;
	set @st_count = (select count(Student_Email) from Student where Student_Email = @email);
	if @st_count < 1
	begin
		print('Такого студента не существует.');
		return;
	end;
	-- Delete it's classes
	delete from Student_Addition_Class where Student_Email = @email;

	-- Delete it's group relations
	delete from Groups_Student where Student_Email = @email;

	-- Delete student
	delete from Student where Student_Email = @email;
	print('Студент с email: ' + @email + ' успешно удалён')
end;