use hse_map_test6
go
select * from Time_span

execute DeleteEqualsTimeSpan

insert into Time_span(Start_time, End_time) select Start_time, End_time from Time_span;

select * from Labor_day

insert into Labor_day(Week_day, ID_Time_span) values ('�����������', 167)

select * from Class

insert into Class values
(276, '��� "�����������"', '2', '2208', '2020-01-04', '���', 'sefremov@hse.ru'),
(277, '��� "�����������"', '2', '2208', '2020-01-04', '���', 'sefremov@hse.ru')