use hsemap_db_edu
go

insert into [dbo].[Campus]
values ('��������', '������� ������', '���������� ������� �.11', '������'),
('��� "�����������"', '������� ������', '����� ��������� �.26-28', '������'),
('���������', '������� ������', '����� ��������� �.20', '������'),
('������� �������', '������� ������', '���������� ������� ��. �.18', '������'),
('����������', '���������', '����� ���������� �.2', '��������'),
('��������','������� ������','����� �������� �.37','�����'),
('��������������','������� ������','�������������� ��. �.3/1, ���. �','�����-���������')
go

insert into [dbo].[Building]
values ('��� "�����������"','1','����� ��������� �.28/11 �.9',NULL),
('��� "�����������"','2','����� ��������� �.28/11 �.2',3),
('��� "�����������"','3','����� ��������� �.26 �.3',4),
('��� "�����������"','4','����� ��������� �.26 �.4',5),
('��� "�����������"','5','����� ��������� �.26 �.5',4),
('��� "�����������"','6','����� ��������� �.28/11 �.3',NULL),
('��� "�����������"','K9','����� ��������� �.26 �.9',1),
('��� "�����������"','K10','����� ��������� �.26 �.2',1),
('��������','A','���������� ������� �.11',3),
('��������','D','���������� ������� �.11',7),
('��������','F','���������� ������� �.11',NULL),
('��������','G','���������� ������� �.11',7),
('��������','K','���������� ������� �.11',5),
('��������','L','���������� ������� �.11',5),
('��������','M','���������� ������� �.11',4),
('��������','N','���������� ������� �.11',5),
('��������','R','���������� ������� �.11',6),
('��������','S','���������� ������� �.11',10),
('��������','T','���������� ������� �.11',10),
('��������','Z','���������� ������� �.11',NULL)
go

insert into [dbo].[Faculty]
values ('���','��������� ������� � �����������'),
('���','��������� ������������ ����'),
('���','��������� ������������� ����'),
('���','��������� ���������� ����'),
('����','������������� �������� ��������� � ��������')
go

insert into [dbo].[Campus_Faculty]
values ('��� "�����������"','���'),
('��������','���'),
('��������','����'),
('��������','���'),
('���������','���')
go

insert into [dbo].[Time_span] (Start_time, End_time)
values ('9:00:00','10:20:00'),
('10:30:00','11:50:00'),
('12:10:00','13:30:00'),
('13:40:00','15:00:00'),
('15:10:00','16:30:00'), --5
('16:40:00','18:00:00'),
('18:10:00','19:30:00'),
('19:40:00','21:00:00'),
('8:00:00', '23:00:00'),
('8:20:00', '21:00:00'), --10
('8:20:00', '17:00:00')
go


insert into  [dbo].[Organisation] (Organisation_Name, [Type])
values ('�������� ����� �2','��������'),
('�������� ����� �4','��������'),
('�� ���','������������ �����'),
('��������� ������-�����������','������������ �����������'),
('������ � ����� .��','������������ �����������'),
('������-�����������','������� ����'),
('���������� ��������','������� ����'),
('��������� � �������� ���������','������� ����'),
('����������','������� ����'),
('��������� ������-�����������','������� ����'),
('������ ������� ���� ���', '������� ����'),
('������� ������� ������','������� ����'),
('����������� ������','������� ����'),
('���������� ���������� � ������ ��������','������� ����'),
('����������','������� ����'),
('�������� �������� � ���������� ������������','������� ����'),
('�����������','������� ����'),
('����','������� ����'),
('��������� ����','������� ����'),
('���������','������� ����'),
('��������� � ����������','������� ����'),
('���������� ��������� �� ��������� ��� ��� � ���','������� ����'),
('���������� ���������','������� ����')
go



insert into Education_program (Edu_level, Edu_prog_name, Short_Faculty_Name, ID_Organisation)
values ('��������','������-�����������','���', 6),
('��������','���������� ��������','���',7),
('��������','��������� � �������� ���������','���',8),
('��������','���������� ���������� � ������ ��������','���',14),
('��������','����������','���',15),
('��������','�������� �������� � ���������� ������������','���',16),
('�������','������� ������� ������','���',12),
('�������','����������� ������','���',13),
('��������','����������','���',9),
('�������','������-�����������','���',10),
('��������','����������� ���������','���',11),
('��������','���������� ������ ������','���',11),
('��������','���������� ���������� � �����������','���',11),
('��������','�����������','���',17),
('��������','����','����',18),
('�������','����','����',19),
('��������','���������','���',20),
('��������','��������� � ����������','���',21),
('��������','���������� ��������� �� ��������� ��� ��� � ���','���',22),
('�������','���������� ���������','���',23)
go

Insert into [dbo].[Student]
Values('����', '����������', '�������', 'yaeshumilov@edu.hse.ru'),
('����', '�����������', '�������', 'ogzelyanin@edu.hse.ru'),
('���������', '����������', '�����', 'vddutov@edu.hse.ru'),
('����', '��������', '�����������', 'ipsinozhenski@edu.hse.ru'),
('�����', '��������', '���������', 'moveberling@edu.hse.ru'),
('���������', '����������', '��������', 'anannenkov@edu.hse.ru'),
('�����', '���������', '��������', 'msandreeva@edu.hse.ru'),
('�����', '���������', '��������', 'sasorokina@edu.hse.ru'),
('���������', '����������', '�����������', 'vmmaslennikov@edu.hse.ru'),
('�������', '�������������', '�����', 'eamorev@edu.hse.ru'),
('�����', '���������', '����������', 'mfnasibullin@edu.hse.ru'),
('������', '����������', '�����', 'mmlevin@edu.hse.ru'),
('�����', '��������', '���������', 'eigrinkevich@edu.hse.ru'),
('����', '���������', '��������', 'gabasistov@edu.hse.ru'),
('������', '���������', '�������', 'dskudelko@edu.hse.ru'),
('������', '����������', '�����', 'aalyakhin@edu.hse.ru'),
('������', '������������', '�������', 'avgubanov@edu.hse.ru'),
('�����', '�������������', '������', 'aamyagkov@edu.hse.ru'),
('�����', '����������', '�������������', 'detriandofilidi@edu.hse.ru'),
('�������', '����������', '�����', 'dakharin@edu.hse.ru')
go

Insert into [dbo].[Professor]
values ('������', '������', '�����������', '�������', 'sefremov@hse.ru'),
('������', '�������', '��������������', '�������', 'avdeeva@hse.ru'),
('������', '�������', '���������', '�����', 'aavchyan@hse.ru'),
('������� �������������', '�����', '����������', '���������', 'magamirova@hse.ru'),
('������� �������������', '����', '����������', '�������', 'aanosova@hse.ru'),
('������', '�����', '���������', '��������', 'abeklaryan@hse.ru'),
('������������ �������������', '����', '����������', '������', 'anbelova@hse.ru'),
('���������', '������', '����������', '��������', 'abronevich@hse.ru'),
('������', '������', '��������', '�������', 'sbruskin@hse.ru'),
('������', '�������', '��������', '��������', 'brushkova@yandex.ru'),
('������', '������', '�������������', '������', 'rbudnik@hse.ru'),
('�����', '�����', '�������������', '���������', 'abudnikova@hse.ru'),
('������� �������������', '�������', '��������', '���������', 'tkashkarova@hse.ru'),
('���������', '���������', '��������', '��������', 'ki@hse.ru'),
('�������������', '����', '�������������', '�����', 'ikuzin@hse.ru'),
('�������������', '�������', '�������', '����������', 'alipatnikov@hse.ru'),
('�������������', '�������', '�������������', '���������', 'tlomonosov@hse.ru'),
('������', '�������', '���������', '�����', 'amaron@hse.ru'),
('������', '������', '��������������', '��������', 'kmartynov@hse.ru'),
('������', '������', '������������', '���������������', 'spetropavlovskij@hse.ru')
go

Insert into [dbo].[Room]
VALUES ('��������', 'D', 'D210', 31, '������������ �����'),
('��������', 'D', 'D106', 15, '���������'),
('��������', 'D', 'D509', 32, '���������'),
('��������', 'G', 'G001', 24, '���������'),
('��������', 'G', 'G117', 0, '����������� ���������'),
('��������', 'G', 'G405', 22, '���������'),
('��������', 'G', 'G603', 30, '���������'),
('��������', 'M', 'M202', 34, '���������'),
('��������', 'N', 'N506', 22, '���������'),
('��������', 'R', 'R201', 240, '���������� ���������'),
('��������', 'S', 'S325', 16, '���������'),
('��������', 'T', 'T524', 0, '����������� ���������'),
('��� "�����������"', '2', '2109', 30, '���������'),
('��� "�����������"', '3', '3231', 48, '���������'),
('��� "�����������"', '4', '4205', 0, '����������� ���������'),
('��� "�����������"', 'K9', 'K9', 232, '���������� ���������'),
('��� "�����������"', '5', '5410', 28, '���������'),
('��� "�����������"', 'K10', 'K10', 232, '���������� ���������'),
('��� "�����������"', '4', '4224', 0, '����������� ���������'),
('��� "�����������"', '2', '2208', 18, '������������ �����')
go


Insert into [dbo].[Labor_day]
VALUES('�����������', 9),
('�������', 9),
('�����', 9),
('�������', 9),
('�������', 9), --5
('�������', 9)
('�����������',10),
('�������', 10),
('�����', 10),
('�������', 10), --10
('�������', 10),
('�������', 11
('�����������', 11)

INSERT INTO Groups
VALUES('BBI1806', 18, 2018, '��������', '������-�����������'),
('BBI1807', 27, 2018, '��������', '������-�����������'),
('BSC1901', 21, 2019, '��������', '����������'),
('BPMI1802', 25, 2018, '��������', '���������� ���������� � �����������'),
('MBI1602', 15, 2016, '�������', '������-�����������'),
('BBI1805', 30, 2018, '��������', '������-�����������'),
('BBI1803', 23, 2018, '��������', '������-�����������')
GO

INSERT INTO Groups_Student
VALUES('BBI1806', 'ogzelyanin@edu.hse.ru'),
('BBI1807', 'eigrinkevich@edu.hse.ru'),
('BBI1806', 'yaeshumilov@edu.hse.ru')
GO

INSERT INTO Class
VALUES(2, '��� "�����������"', '2', '2208', '2019-12-27', '����������������', 'sefremov@hse.ru'),
(3, '��� "�����������"', '3', '3231', '2019-12-25', '�������������� ��������, ���� � �����', 'ki@hse.ru'),
(5, '��������', 'D', 'D210', '2019-12-27', '���������� �������', 'abeklaryan@hse.ru'),
(4, '��� "�����������"', '5', '5410', '2019-12-27', '���������� ����', 'tkashkarova@hse.ru')
GO

INSERT INTO Groups_Class
VALUES('BBI1806', 2, '��� "�����������"', '2', '2208', '2019-12-27'),
('BBI1806', 3, '��� "�����������"', '3', '3231', '2019-12-25'),
('BPMI1802', 5, '��������', 'D', 'D210', '2019-12-27'),
('BBI1806', 4, '��� "�����������"', '5', '5410', '2019-12-27')
GO

INSERT INTO Student_Addition_Class
VALUES('ogzelyanin@edu.hse.ru', 4, '��� "�����������"', '5', '5410', '2019-12-27', '�����������')
GO

INSERT INTO Schedule_Organisation
VALUES
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
GO

INSERT INTO Room_Organisation
VALUES
('��� "�����������"', '4', '4205', 6),
('��� "�����������"', '4', '4224', 7),
('��� "�����������"', '5', '5410', 8)