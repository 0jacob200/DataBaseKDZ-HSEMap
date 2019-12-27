
CREATE TABLE [Student]
( 
	[First_Name]         nvarchar(32)  NULL ,
	[Second_Name]        nvarchar(32)  NULL ,
	[Surname]            nvarchar(32)  NULL ,
	[Email]              varchar(64)  NOT NULL ,
	CONSTRAINT [XPKStudent] PRIMARY KEY  CLUSTERED ([Email] ASC)
)
go

CREATE TABLE [Time_span]
( 
	[ID_Time_span]       integer  IDENTITY  NOT NULL ,
	[Start_time]         time(0)  NOT NULL ,
	[End_time]           time(0)  NOT NULL ,
	CONSTRAINT [XPKTime_span] PRIMARY KEY  CLUSTERED ([ID_Time_span] ASC)
)
go

CREATE TABLE [Professor]
( 
	[Rank]               nvarchar(50)  NULL ,
	[First_Name]         nvarchar(60)  NOT NULL ,
	[Second_Name]        nvarchar(60)  NULL ,
	[Surname]            nvarchar(60)  NOT NULL ,
	[Professor_s_Email]  varchar(40)  NOT NULL ,
	CONSTRAINT [XPKProfessor] PRIMARY KEY  CLUSTERED ([Professor_s_Email] ASC)
)
go

CREATE TABLE [Campus]
( 
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Type]               nvarchar(50)  NULL ,
	[Main_Address]       nvarchar(80)  NOT NULL ,
	[City]               nvarchar(32)  NOT NULL ,
	CONSTRAINT [XPKCampus] PRIMARY KEY  CLUSTERED ([Campus_Name] ASC)
)
go

CREATE TABLE [Building]
( 
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Adress]             nvarchar(64)  NOT NULL ,
	[Floor_number]       integer  NULL ,
	CONSTRAINT [XPKBuilding] PRIMARY KEY  CLUSTERED ([Campus_Name] ASC,[Name_Number_of_Building] ASC),
	CONSTRAINT [R_5] FOREIGN KEY ([Campus_Name]) REFERENCES [Campus]([Campus_Name])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Room]
( 
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Room_Number]        integer  NOT NULL ,
	[Capacity]           integer  NULL ,
	[Type]               nvarchar(25)  NULL ,
	CONSTRAINT [XPKRoom] PRIMARY KEY  CLUSTERED ([Campus_Name] ASC,[Name_Number_of_Building] ASC,[Room_Number] ASC),
	CONSTRAINT [R_6] FOREIGN KEY ([Campus_Name],[Name_Number_of_Building]) REFERENCES [Building]([Campus_Name],[Name_Number_of_Building])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Class]
( 
	[ID_Time_span]       integer  NOT NULL ,
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Number_Room]        integer  NOT NULL ,
	[Date_Class]         date  NOT NULL ,
	[Name_of_subject]    nvarchar(100)  NOT NULL ,
	[Professor_s_Email]  varchar(40)  NULL ,
	CONSTRAINT [XPKClass] PRIMARY KEY  CLUSTERED ([ID_Time_span] ASC,[Campus_Name] ASC,[Name_Number_of_Building] ASC,[Number_Room] ASC,[Date_Class] ASC),
	CONSTRAINT [R_14] FOREIGN KEY ([ID_Time_span]) REFERENCES [Time_span]([ID_Time_span])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_17] FOREIGN KEY ([Professor_s_Email]) REFERENCES [Professor]([Professor_s_Email])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_18] FOREIGN KEY ([Campus_Name],[Name_Number_of_Building],[Number_Room]) REFERENCES [Room]([Campus_Name],[Name_Number_of_Building],[Room_Number])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Student_Addition_Class]
( 
	[Email]              varchar(64)  NOT NULL ,
	[ID_Time_span]       integer  NOT NULL ,
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Number_Room]        integer  NOT NULL ,
	[Date_Class]         date  NOT NULL ,
	[Type]               nvarchar(20)  NULL ,
	CONSTRAINT [XPKStudent_Class] PRIMARY KEY  CLUSTERED ([Email] ASC,[ID_Time_span] ASC,[Campus_Name] ASC,[Name_Number_of_Building] ASC,[Number_Room] ASC,[Date_Class] ASC),
	CONSTRAINT [R_48] FOREIGN KEY ([Email]) REFERENCES [Student]([Email])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_49] FOREIGN KEY ([ID_Time_span],[Campus_Name],[Name_Number_of_Building],[Number_Room],[Date_Class]) REFERENCES [Class]([ID_Time_span],[Campus_Name],[Name_Number_of_Building],[Number_Room],[Date_Class])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Labor_day]
( 
	[ID_Labor_day]       integer  IDENTITY  NOT NULL ,
	[Day_of_the_week]    nvarchar(12)  NOT NULL ,
	[ID_Time_span]       integer  NOT NULL ,
	CONSTRAINT [XPKLabor_day] PRIMARY KEY  CLUSTERED ([ID_Labor_day] ASC),
	CONSTRAINT [R_9] FOREIGN KEY ([ID_Time_span]) REFERENCES [Time_span]([ID_Time_span])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Organisation]
( 
	[ID_Organisation]    integer  IDENTITY  NOT NULL ,
	[Name_of_Organisation] nvarchar(50)  NOT NULL ,
	[Type]               nvarchar(30)  NULL ,
	CONSTRAINT [XPKOrganisation] PRIMARY KEY  CLUSTERED ([ID_Organisation] ASC)
)
go

CREATE TABLE [Schedule_Organisation]
( 
	[ID_Labor_day]       integer  NOT NULL ,
	[ID_Organisation]    integer  NOT NULL ,
	CONSTRAINT [XPKLabor_day_Organisation] PRIMARY KEY  CLUSTERED ([ID_Labor_day] ASC,[ID_Organisation] ASC),
	CONSTRAINT [R_36] FOREIGN KEY ([ID_Labor_day]) REFERENCES [Labor_day]([ID_Labor_day])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_37] FOREIGN KEY ([ID_Organisation]) REFERENCES [Organisation]([ID_Organisation])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Schedule_Campus]
( 
	[ID_Labor_day]       integer  NOT NULL ,
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	CONSTRAINT [XPKLabor_day_Campus] PRIMARY KEY  CLUSTERED ([ID_Labor_day] ASC,[Campus_Name] ASC),
	CONSTRAINT [R_27] FOREIGN KEY ([ID_Labor_day]) REFERENCES [Labor_day]([ID_Labor_day])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_28] FOREIGN KEY ([Campus_Name]) REFERENCES [Campus]([Campus_Name])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Room_Organisation]
( 
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Room_Number]        integer  NOT NULL ,
	[ID_Organisation]    integer  NOT NULL ,
	CONSTRAINT [XPKRoom_Organisation] PRIMARY KEY  CLUSTERED ([Campus_Name] ASC,[Name_Number_of_Building] ASC,[Room_Number] ASC,[ID_Organisation] ASC),
	CONSTRAINT [R_30] FOREIGN KEY ([Campus_Name],[Name_Number_of_Building],[Room_Number]) REFERENCES [Room]([Campus_Name],[Name_Number_of_Building],[Room_Number])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_31] FOREIGN KEY ([ID_Organisation]) REFERENCES [Organisation]([ID_Organisation])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Faculty]
( 
	[Short_Faculty_Name] nvarchar(15)  NOT NULL ,
	[Full_Faculty_Name]  nvarchar(100)  NOT NULL ,
	CONSTRAINT [XPKFaculty] PRIMARY KEY  CLUSTERED ([Short_Faculty_Name] ASC)
)
go

CREATE TABLE [Education_program]
( 
	[Edu_level]          nvarchar(16)  NOT NULL ,
	[Edu_prog_name]      nvarchar(128)  NOT NULL ,
	[Short_Faculty_Name] nvarchar(15)  NOT NULL ,
	[ID_Organisation]    integer  NULL ,
	CONSTRAINT [XPKEducation_program] PRIMARY KEY  CLUSTERED ([Edu_level] ASC,[Edu_prog_name] ASC),
	CONSTRAINT [R_43] FOREIGN KEY ([Short_Faculty_Name]) REFERENCES [Faculty]([Short_Faculty_Name])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_46] FOREIGN KEY ([ID_Organisation]) REFERENCES [Organisation]([ID_Organisation])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Groups]
( 
	[Full_Group_Number]  nvarchar(15)  NOT NULL ,
	[Number_Student]     integer  NULL ,
	[Year_of_enrollment] integer  NOT NULL ,
	[Edu_level]          nvarchar(16)  NOT NULL ,
	[Edu_prog_name]      nvarchar(128)  NOT NULL ,
	CONSTRAINT [XPKGroups] PRIMARY KEY  CLUSTERED ([Full_Group_Number] ASC),
	CONSTRAINT [R_41] FOREIGN KEY ([Edu_level],[Edu_prog_name]) REFERENCES [Education_program]([Edu_level],[Edu_prog_name])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Groups_Student]
( 
	[Full_Group_Number]  nvarchar(15)  NOT NULL ,
	[Email]              varchar(64)  NOT NULL ,
	CONSTRAINT [XPKGroups_Student] PRIMARY KEY  CLUSTERED ([Full_Group_Number] ASC,[Email] ASC),
	CONSTRAINT [R_39] FOREIGN KEY ([Full_Group_Number]) REFERENCES [Groups]([Full_Group_Number])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_40] FOREIGN KEY ([Email]) REFERENCES [Student]([Email])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Groups_Class]
( 
	[Full_Group_Number]  nvarchar(15)  NOT NULL ,
	[ID_Time_span]       integer  NOT NULL ,
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Number_Room]        integer  NOT NULL ,
	[Date_Class]         date  NOT NULL ,
	CONSTRAINT [XPKGroups_Class] PRIMARY KEY  CLUSTERED ([Full_Group_Number] ASC,[ID_Time_span] ASC,[Campus_Name] ASC,[Name_Number_of_Building] ASC,[Number_Room] ASC,[Date_Class] ASC),
	CONSTRAINT [R_33] FOREIGN KEY ([Full_Group_Number]) REFERENCES [Groups]([Full_Group_Number])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_34] FOREIGN KEY ([ID_Time_span],[Campus_Name],[Name_Number_of_Building],[Number_Room],[Date_Class]) REFERENCES [Class]([ID_Time_span],[Campus_Name],[Name_Number_of_Building],[Number_Room],[Date_Class])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE [Campus_Faculty]
( 
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Short_Faculty_Name] nvarchar(15)  NOT NULL ,
	CONSTRAINT [XPKCampus_Faculty] PRIMARY KEY  CLUSTERED ([Campus_Name] ASC,[Short_Faculty_Name] ASC),
	CONSTRAINT [R_24] FOREIGN KEY ([Campus_Name]) REFERENCES [Campus]([Campus_Name])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_25] FOREIGN KEY ([Short_Faculty_Name]) REFERENCES [Faculty]([Short_Faculty_Name])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go
