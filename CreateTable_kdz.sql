
CREATE TABLE [Time_span]
( 
	[ID_Time_span]       integer  IDENTITY  NOT NULL ,
	[Start_time]         datetime  NOT NULL ,
	[End_time]           datetime  NOT NULL ,
	CONSTRAINT [XPKTime_span] PRIMARY KEY  CLUSTERED ([ID_Time_span] ASC)
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

CREATE TABLE [Schadule_Organisation]
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

CREATE TABLE [Campus]
( 
	[Campus_Name]        nvarchar(50)  NOT NULL ,
	[Type]               nvarchar(50)  NULL ,
	[Main_Address]       nvarchar(80)  NOT NULL ,
	[City]               nvarchar(32)  NOT NULL ,
	CONSTRAINT [XPKCampus] PRIMARY KEY  CLUSTERED ([Campus_Name] ASC)
)
go

CREATE TABLE [Schadule_Campus]
( 
	[ID_Labor_day]       integer  NOT NULL ,
	[Campus_Name]        nvarchar(50)  NOT NULL ,
	CONSTRAINT [XPKLabor_day_Campus] PRIMARY KEY  CLUSTERED ([ID_Labor_day] ASC,[Campus_Name] ASC),
	CONSTRAINT [R_27] FOREIGN KEY ([ID_Labor_day]) REFERENCES [Labor_day]([ID_Labor_day])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT [R_28] FOREIGN KEY ([Campus_Name]) REFERENCES [Campus]([Campus_Name])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
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

CREATE TABLE [Student]
( 
	[First_Name]         nvarchar(32)  NULL ,
	[Second_Name]        nvarchar(32)  NULL ,
	[Surname]            nvarchar(32)  NULL ,
	[Email]              varchar(64)  NOT NULL ,
	CONSTRAINT [XPKStudent] PRIMARY KEY  CLUSTERED ([Email] ASC)
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

CREATE TABLE [Class]
( 
	[ID_Time_span]       integer  NOT NULL ,
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Number_Room]        integer  NOT NULL ,
	[Date_Class]         datetime  NOT NULL ,
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

CREATE TABLE [Groups_Class]
( 
	[Full_Group_Number]  nvarchar(15)  NOT NULL ,
	[ID_Time_span]       integer  NOT NULL ,
	[Campus_Name]        nvarchar(64)  NOT NULL ,
	[Name_Number_of_Building] nvarchar(32)  NOT NULL ,
	[Number_Room]        integer  NOT NULL ,
	[Date_Class]         datetime  NOT NULL ,
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
	[Campus_Name]        nvarchar(50)  NOT NULL ,
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

CREATE TRIGGER tD_campus ON Campus FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Campus */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Campus  Schadule_Campus on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002ee0c", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Campus_Name" */
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Campus
      WHERE
        /*  %JoinFKPK(Schadule_Campus,deleted," = "," AND") */
        Schadule_Campus.Campus_Name = deleted.Campus_Name
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Campus because Schadule_Campus exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Campus  Campus_Faculty on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Campus_Name" */
    IF EXISTS (
      SELECT * FROM deleted,Campus_Faculty
      WHERE
        /*  %JoinFKPK(Campus_Faculty,deleted," = "," AND") */
        Campus_Faculty.Campus_Name = deleted.Campus_Name
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Campus because Campus_Faculty exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Campus  Building on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Building"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="Campus_Name" */
    IF EXISTS (
      SELECT * FROM deleted,Building
      WHERE
        /*  %JoinFKPK(Building,deleted," = "," AND") */
        Building.Campus_Name = deleted.Campus_Name
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Campus because Building exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_campus ON Campus FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Campus */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCampus_Name nvarchar(50),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Campus  Schadule_Campus on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00036259", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Campus_Name" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Campus_Name)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Campus
      WHERE
        /*  %JoinFKPK(Schadule_Campus,deleted," = "," AND") */
        Schadule_Campus.Campus_Name = deleted.Campus_Name
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Campus because Schadule_Campus exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Campus  Campus_Faculty on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Campus_Name" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Campus_Name)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Campus_Faculty
      WHERE
        /*  %JoinFKPK(Campus_Faculty,deleted," = "," AND") */
        Campus_Faculty.Campus_Name = deleted.Campus_Name
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Campus because Campus_Faculty exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Campus  Building on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Building"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="Campus_Name" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Campus_Name)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Building
      WHERE
        /*  %JoinFKPK(Building,deleted," = "," AND") */
        Building.Campus_Name = deleted.Campus_Name
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Campus because Building exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_building ON Building FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Building */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Building  Room on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00023d54", PARENT_OWNER="", PARENT_TABLE="Building"
    CHILD_OWNER="", CHILD_TABLE="Room"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Campus_Name""Name_Number_of_Building" */
    IF EXISTS (
      SELECT * FROM deleted,Room
      WHERE
        /*  %JoinFKPK(Room,deleted," = "," AND") */
        Room.Campus_Name = deleted.Campus_Name AND
        Room.Name_Number_of_Building = deleted.Name_Number_of_Building
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Building because Room exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Campus  Building on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Building"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="Campus_Name" */
    IF EXISTS (SELECT * FROM deleted,Campus
      WHERE
        /* %JoinFKPK(deleted,Campus," = "," AND") */
        deleted.Campus_Name = Campus.Campus_Name AND
        NOT EXISTS (
          SELECT * FROM Building
          WHERE
            /* %JoinFKPK(Building,Campus," = "," AND") */
            Building.Campus_Name = Campus.Campus_Name
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Building because Campus exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_building ON Building FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Building */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCampus_Name nvarchar(64), 
           @insName_Number_of_Building nvarchar(32),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Building  Room on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00029dd9", PARENT_OWNER="", PARENT_TABLE="Building"
    CHILD_OWNER="", CHILD_TABLE="Room"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Campus_Name""Name_Number_of_Building" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Room
      WHERE
        /*  %JoinFKPK(Room,deleted," = "," AND") */
        Room.Campus_Name = deleted.Campus_Name AND
        Room.Name_Number_of_Building = deleted.Name_Number_of_Building
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Building because Room exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Campus  Building on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Building"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="Campus_Name" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Campus_Name)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Campus
        WHERE
          /* %JoinFKPK(inserted,Campus) */
          inserted.Campus_Name = Campus.Campus_Name
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Building because Campus does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_room ON Room FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Room */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Room  Room_Organisation on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003feb1", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Room_Number" */
    IF EXISTS (
      SELECT * FROM deleted,Room_Organisation
      WHERE
        /*  %JoinFKPK(Room_Organisation,deleted," = "," AND") */
        Room_Organisation.Campus_Name = deleted.Campus_Name AND
        Room_Organisation.Name_Number_of_Building = deleted.Name_Number_of_Building AND
        Room_Organisation.Room_Number = deleted.Room_Number
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Room because Room_Organisation exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Room  Class on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Number_Room" */
    IF EXISTS (
      SELECT * FROM deleted,Class
      WHERE
        /*  %JoinFKPK(Class,deleted," = "," AND") */
        Class.Campus_Name = deleted.Campus_Name AND
        Class.Name_Number_of_Building = deleted.Name_Number_of_Building AND
        Class.Number_Room = deleted.Room_Number
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Room because Class exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Building  Room on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Building"
    CHILD_OWNER="", CHILD_TABLE="Room"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Campus_Name""Name_Number_of_Building" */
    IF EXISTS (SELECT * FROM deleted,Building
      WHERE
        /* %JoinFKPK(deleted,Building," = "," AND") */
        deleted.Campus_Name = Building.Campus_Name AND
        deleted.Name_Number_of_Building = Building.Name_Number_of_Building AND
        NOT EXISTS (
          SELECT * FROM Room
          WHERE
            /* %JoinFKPK(Room,Building," = "," AND") */
            Room.Campus_Name = Building.Campus_Name AND
            Room.Name_Number_of_Building = Building.Name_Number_of_Building
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Room because Building exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_room ON Room FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Room */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCampus_Name nvarchar(64), 
           @insName_Number_of_Building nvarchar(32), 
           @insRoom_Number integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Room  Room_Organisation on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004849d", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Room_Number" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building) OR
    UPDATE(Room_Number)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Room_Organisation
      WHERE
        /*  %JoinFKPK(Room_Organisation,deleted," = "," AND") */
        Room_Organisation.Campus_Name = deleted.Campus_Name AND
        Room_Organisation.Name_Number_of_Building = deleted.Name_Number_of_Building AND
        Room_Organisation.Room_Number = deleted.Room_Number
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Room because Room_Organisation exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Room  Class on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Number_Room" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building) OR
    UPDATE(Room_Number)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Class
      WHERE
        /*  %JoinFKPK(Class,deleted," = "," AND") */
        Class.Campus_Name = deleted.Campus_Name AND
        Class.Name_Number_of_Building = deleted.Name_Number_of_Building AND
        Class.Number_Room = deleted.Room_Number
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Room because Class exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Building  Room on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Building"
    CHILD_OWNER="", CHILD_TABLE="Room"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="Campus_Name""Name_Number_of_Building" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Building
        WHERE
          /* %JoinFKPK(inserted,Building) */
          inserted.Campus_Name = Building.Campus_Name and
          inserted.Name_Number_of_Building = Building.Name_Number_of_Building
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Room because Building does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_organisation ON Organisation FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Organisation */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Organisation  Education_program on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00035ea7", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="ID_Organisation" */
    IF EXISTS (
      SELECT * FROM deleted,Education_program
      WHERE
        /*  %JoinFKPK(Education_program,deleted," = "," AND") */
        Education_program.ID_Organisation = deleted.ID_Organisation
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Organisation because Education_program exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Organisation  Schadule_Organisation on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="ID_Organisation" */
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Organisation
      WHERE
        /*  %JoinFKPK(Schadule_Organisation,deleted," = "," AND") */
        Schadule_Organisation.ID_Organisation = deleted.ID_Organisation
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Organisation because Schadule_Organisation exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Organisation  Room_Organisation on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="ID_Organisation" */
    IF EXISTS (
      SELECT * FROM deleted,Room_Organisation
      WHERE
        /*  %JoinFKPK(Room_Organisation,deleted," = "," AND") */
        Room_Organisation.ID_Organisation = deleted.ID_Organisation
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Organisation because Room_Organisation exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_organisation ON Organisation FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Organisation */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insID_Organisation integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Organisation  Education_program on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003c597", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="ID_Organisation" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Organisation)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Education_program
      WHERE
        /*  %JoinFKPK(Education_program,deleted," = "," AND") */
        Education_program.ID_Organisation = deleted.ID_Organisation
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Organisation because Education_program exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Organisation  Schadule_Organisation on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="ID_Organisation" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Organisation)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Organisation
      WHERE
        /*  %JoinFKPK(Schadule_Organisation,deleted," = "," AND") */
        Schadule_Organisation.ID_Organisation = deleted.ID_Organisation
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Organisation because Schadule_Organisation exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Organisation  Room_Organisation on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="ID_Organisation" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Organisation)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Room_Organisation
      WHERE
        /*  %JoinFKPK(Room_Organisation,deleted," = "," AND") */
        Room_Organisation.ID_Organisation = deleted.ID_Organisation
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Organisation because Room_Organisation exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_class ON Class FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Class */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Class  Groups_Class on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000578ff", PARENT_OWNER="", PARENT_TABLE="Class"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="ID_Time_span""Campus_Name""Name_Number_of_Building""Number_Room""
               Date_Class" */
    IF EXISTS (
      SELECT * FROM deleted,Groups_Class
      WHERE
        /*  %JoinFKPK(Groups_Class,deleted," = "," AND") */
        Groups_Class.ID_Time_span = deleted.ID_Time_span AND
        Groups_Class.Campus_Name = deleted.Campus_Name AND
        Groups_Class.Name_Number_of_Building = deleted.Name_Number_of_Building AND
        Groups_Class.Number_Room = deleted.Number_Room AND
        Groups_Class.Date_Class = deleted.Date_Class
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Class because Groups_Class exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Room  Class on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Number_Room" */
    IF EXISTS (SELECT * FROM deleted,Room
      WHERE
        /* %JoinFKPK(deleted,Room," = "," AND") */
        deleted.Campus_Name = Room.Campus_Name AND
        deleted.Name_Number_of_Building = Room.Name_Number_of_Building AND
        deleted.Number_Room = Room.Room_Number AND
        NOT EXISTS (
          SELECT * FROM Class
          WHERE
            /* %JoinFKPK(Class,Room," = "," AND") */
            Class.Campus_Name = Room.Campus_Name AND
            Class.Name_Number_of_Building = Room.Name_Number_of_Building AND
            Class.Number_Room = Room.Room_Number
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Class because Room exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Professor  Class on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Professor"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Professor_s_Email" */
    IF EXISTS (SELECT * FROM deleted,Professor
      WHERE
        /* %JoinFKPK(deleted,Professor," = "," AND") */
        deleted.Professor_s_Email = Professor.Professor_s_Email AND
        NOT EXISTS (
          SELECT * FROM Class
          WHERE
            /* %JoinFKPK(Class,Professor," = "," AND") */
            Class.Professor_s_Email = Professor.Professor_s_Email
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Class because Professor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Time_span  Class on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="ID_Time_span" */
    IF EXISTS (SELECT * FROM deleted,Time_span
      WHERE
        /* %JoinFKPK(deleted,Time_span," = "," AND") */
        deleted.ID_Time_span = Time_span.ID_Time_span AND
        NOT EXISTS (
          SELECT * FROM Class
          WHERE
            /* %JoinFKPK(Class,Time_span," = "," AND") */
            Class.ID_Time_span = Time_span.ID_Time_span
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Class because Time_span exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_class ON Class FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Class */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insID_Time_span integer, 
           @insCampus_Name nvarchar(64), 
           @insName_Number_of_Building nvarchar(32), 
           @insNumber_Room integer, 
           @insDate_Class datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Class  Groups_Class on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00062b20", PARENT_OWNER="", PARENT_TABLE="Class"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="ID_Time_span""Campus_Name""Name_Number_of_Building""Number_Room""
               Date_Class" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Time_span) OR
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building) OR
    UPDATE(Number_Room) OR
    UPDATE(Date_Class)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Groups_Class
      WHERE
        /*  %JoinFKPK(Groups_Class,deleted," = "," AND") */
        Groups_Class.ID_Time_span = deleted.ID_Time_span AND
        Groups_Class.Campus_Name = deleted.Campus_Name AND
        Groups_Class.Name_Number_of_Building = deleted.Name_Number_of_Building AND
        Groups_Class.Number_Room = deleted.Number_Room AND
        Groups_Class.Date_Class = deleted.Date_Class
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Class because Groups_Class exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Room  Class on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Number_Room" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building) OR
    UPDATE(Number_Room)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Room
        WHERE
          /* %JoinFKPK(inserted,Room) */
          inserted.Campus_Name = Room.Campus_Name and
          inserted.Name_Number_of_Building = Room.Name_Number_of_Building and
          inserted.Number_Room = Room.Room_Number
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Class because Room does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Professor  Class on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Professor"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Professor_s_Email" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Professor_s_Email)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Professor
        WHERE
          /* %JoinFKPK(inserted,Professor) */
          inserted.Professor_s_Email = Professor.Professor_s_Email
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Professor_s_Email IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Class because Professor does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Time_span  Class on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="ID_Time_span" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Time_span)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Time_span
        WHERE
          /* %JoinFKPK(inserted,Time_span) */
          inserted.ID_Time_span = Time_span.ID_Time_span
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Class because Time_span does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_time_span ON Time_span FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Time_span */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Time_span  Class on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001d9f0", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="ID_Time_span" */
    IF EXISTS (
      SELECT * FROM deleted,Class
      WHERE
        /*  %JoinFKPK(Class,deleted," = "," AND") */
        Class.ID_Time_span = deleted.ID_Time_span
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Time_span because Class exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Time_span  Labor_day on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Labor_day"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Time_span" */
    IF EXISTS (
      SELECT * FROM deleted,Labor_day
      WHERE
        /*  %JoinFKPK(Labor_day,deleted," = "," AND") */
        Labor_day.ID_Time_span = deleted.ID_Time_span
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Time_span because Labor_day exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_time_span ON Time_span FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Time_span */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insID_Time_span integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Time_span  Class on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000231b7", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="ID_Time_span" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Time_span)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Class
      WHERE
        /*  %JoinFKPK(Class,deleted," = "," AND") */
        Class.ID_Time_span = deleted.ID_Time_span
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Time_span because Class exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Time_span  Labor_day on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Labor_day"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Time_span" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Time_span)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Labor_day
      WHERE
        /*  %JoinFKPK(Labor_day,deleted," = "," AND") */
        Labor_day.ID_Time_span = deleted.ID_Time_span
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Time_span because Labor_day exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_labor_day ON Labor_day FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Labor_day */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Labor_day  Schadule_Organisation on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00036e9f", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="ID_Labor_day" */
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Organisation
      WHERE
        /*  %JoinFKPK(Schadule_Organisation,deleted," = "," AND") */
        Schadule_Organisation.ID_Labor_day = deleted.ID_Labor_day
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Labor_day because Schadule_Organisation exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Labor_day  Schadule_Campus on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Labor_day" */
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Campus
      WHERE
        /*  %JoinFKPK(Schadule_Campus,deleted," = "," AND") */
        Schadule_Campus.ID_Labor_day = deleted.ID_Labor_day
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Labor_day because Schadule_Campus exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Time_span  Labor_day on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Labor_day"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Time_span" */
    IF EXISTS (SELECT * FROM deleted,Time_span
      WHERE
        /* %JoinFKPK(deleted,Time_span," = "," AND") */
        deleted.ID_Time_span = Time_span.ID_Time_span AND
        NOT EXISTS (
          SELECT * FROM Labor_day
          WHERE
            /* %JoinFKPK(Labor_day,Time_span," = "," AND") */
            Labor_day.ID_Time_span = Time_span.ID_Time_span
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Labor_day because Time_span exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_labor_day ON Labor_day FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Labor_day */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insID_Labor_day integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Labor_day  Schadule_Organisation on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003d970", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="ID_Labor_day" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Labor_day)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Organisation
      WHERE
        /*  %JoinFKPK(Schadule_Organisation,deleted," = "," AND") */
        Schadule_Organisation.ID_Labor_day = deleted.ID_Labor_day
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Labor_day because Schadule_Organisation exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Labor_day  Schadule_Campus on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Labor_day" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Labor_day)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Schadule_Campus
      WHERE
        /*  %JoinFKPK(Schadule_Campus,deleted," = "," AND") */
        Schadule_Campus.ID_Labor_day = deleted.ID_Labor_day
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Labor_day because Schadule_Campus exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Time_span  Labor_day on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Time_span"
    CHILD_OWNER="", CHILD_TABLE="Labor_day"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Time_span" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Time_span)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Time_span
        WHERE
          /* %JoinFKPK(inserted,Time_span) */
          inserted.ID_Time_span = Time_span.ID_Time_span
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ID_Time_span IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Labor_day because Time_span does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Faculty ON Faculty FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Faculty */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Faculty  Education_program on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00023937", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="Short_Faculty_Name" */
    IF EXISTS (
      SELECT * FROM deleted,Education_program
      WHERE
        /*  %JoinFKPK(Education_program,deleted," = "," AND") */
        Education_program.Short_Faculty_Name = deleted.Short_Faculty_Name
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Faculty because Education_program exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Faculty  Campus_Faculty on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="Short_Faculty_Name" */
    IF EXISTS (
      SELECT * FROM deleted,Campus_Faculty
      WHERE
        /*  %JoinFKPK(Campus_Faculty,deleted," = "," AND") */
        Campus_Faculty.Short_Faculty_Name = deleted.Short_Faculty_Name
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Faculty because Campus_Faculty exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Faculty ON Faculty FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Faculty */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insShort_Faculty_Name nvarchar(15),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Faculty  Education_program on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00027b8c", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="Short_Faculty_Name" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Short_Faculty_Name)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Education_program
      WHERE
        /*  %JoinFKPK(Education_program,deleted," = "," AND") */
        Education_program.Short_Faculty_Name = deleted.Short_Faculty_Name
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Faculty because Education_program exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Faculty  Campus_Faculty on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="Short_Faculty_Name" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Short_Faculty_Name)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Campus_Faculty
      WHERE
        /*  %JoinFKPK(Campus_Faculty,deleted," = "," AND") */
        Campus_Faculty.Short_Faculty_Name = deleted.Short_Faculty_Name
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Faculty because Campus_Faculty exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Professor ON Professor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Professor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Professor  Class on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000110f8", PARENT_OWNER="", PARENT_TABLE="Professor"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Professor_s_Email" */
    IF EXISTS (
      SELECT * FROM deleted,Class
      WHERE
        /*  %JoinFKPK(Class,deleted," = "," AND") */
        Class.Professor_s_Email = deleted.Professor_s_Email
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Professor because Class exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Professor ON Professor FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Professor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insProfessor_s_Email varchar(40),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Professor  Class on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001265d", PARENT_OWNER="", PARENT_TABLE="Professor"
    CHILD_OWNER="", CHILD_TABLE="Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="Professor_s_Email" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Professor_s_Email)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Class
      WHERE
        /*  %JoinFKPK(Class,deleted," = "," AND") */
        Class.Professor_s_Email = deleted.Professor_s_Email
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Professor because Class exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Groups ON Groups FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Groups */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Groups  Groups_Student on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00039f49", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="Full_Group_Number" */
    IF EXISTS (
      SELECT * FROM deleted,Groups_Student
      WHERE
        /*  %JoinFKPK(Groups_Student,deleted," = "," AND") */
        Groups_Student.Full_Group_Number = deleted.Full_Group_Number
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Groups because Groups_Student exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Groups  Groups_Class on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="Full_Group_Number" */
    IF EXISTS (
      SELECT * FROM deleted,Groups_Class
      WHERE
        /*  %JoinFKPK(Groups_Class,deleted," = "," AND") */
        Groups_Class.Full_Group_Number = deleted.Full_Group_Number
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Groups because Groups_Class exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Education_program  Groups on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Education_program"
    CHILD_OWNER="", CHILD_TABLE="Groups"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_41", FK_COLUMNS="Edu_level""Edu_prog_name" */
    IF EXISTS (SELECT * FROM deleted,Education_program
      WHERE
        /* %JoinFKPK(deleted,Education_program," = "," AND") */
        deleted.Edu_level = Education_program.Edu_level AND
        deleted.Edu_prog_name = Education_program.Edu_prog_name AND
        NOT EXISTS (
          SELECT * FROM Groups
          WHERE
            /* %JoinFKPK(Groups,Education_program," = "," AND") */
            Groups.Edu_level = Education_program.Edu_level AND
            Groups.Edu_prog_name = Education_program.Edu_prog_name
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Groups because Education_program exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Groups ON Groups FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Groups */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFull_Group_Number nvarchar(15),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Groups  Groups_Student on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00041534", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="Full_Group_Number" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Full_Group_Number)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Groups_Student
      WHERE
        /*  %JoinFKPK(Groups_Student,deleted," = "," AND") */
        Groups_Student.Full_Group_Number = deleted.Full_Group_Number
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Groups because Groups_Student exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Groups  Groups_Class on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="Full_Group_Number" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Full_Group_Number)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Groups_Class
      WHERE
        /*  %JoinFKPK(Groups_Class,deleted," = "," AND") */
        Groups_Class.Full_Group_Number = deleted.Full_Group_Number
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Groups because Groups_Class exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Education_program  Groups on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Education_program"
    CHILD_OWNER="", CHILD_TABLE="Groups"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_41", FK_COLUMNS="Edu_level""Edu_prog_name" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Edu_level) OR
    UPDATE(Edu_prog_name)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Education_program
        WHERE
          /* %JoinFKPK(inserted,Education_program) */
          inserted.Edu_level = Education_program.Edu_level and
          inserted.Edu_prog_name = Education_program.Edu_prog_name
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Edu_level IS NULL AND
      inserted.Edu_prog_name IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Groups because Education_program does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Campus_Faculty ON Campus_Faculty FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Campus_Faculty */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Faculty  Campus_Faculty on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00029b90", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="Short_Faculty_Name" */
    IF EXISTS (SELECT * FROM deleted,Faculty
      WHERE
        /* %JoinFKPK(deleted,Faculty," = "," AND") */
        deleted.Short_Faculty_Name = Faculty.Short_Faculty_Name AND
        NOT EXISTS (
          SELECT * FROM Campus_Faculty
          WHERE
            /* %JoinFKPK(Campus_Faculty,Faculty," = "," AND") */
            Campus_Faculty.Short_Faculty_Name = Faculty.Short_Faculty_Name
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Campus_Faculty because Faculty exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Campus  Campus_Faculty on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Campus_Name" */
    IF EXISTS (SELECT * FROM deleted,Campus
      WHERE
        /* %JoinFKPK(deleted,Campus," = "," AND") */
        deleted.Campus_Name = Campus.Campus_Name AND
        NOT EXISTS (
          SELECT * FROM Campus_Faculty
          WHERE
            /* %JoinFKPK(Campus_Faculty,Campus," = "," AND") */
            Campus_Faculty.Campus_Name = Campus.Campus_Name
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Campus_Faculty because Campus exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Campus_Faculty ON Campus_Faculty FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Campus_Faculty */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCampus_Name nvarchar(50), 
           @insShort_Faculty_Name nvarchar(15),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Faculty  Campus_Faculty on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c778", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="Short_Faculty_Name" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Short_Faculty_Name)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Faculty
        WHERE
          /* %JoinFKPK(inserted,Faculty) */
          inserted.Short_Faculty_Name = Faculty.Short_Faculty_Name
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Campus_Faculty because Faculty does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Campus  Campus_Faculty on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Campus_Faculty"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="Campus_Name" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Campus_Name)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Campus
        WHERE
          /* %JoinFKPK(inserted,Campus) */
          inserted.Campus_Name = Campus.Campus_Name
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Campus_Faculty because Campus does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Labor_day_Campus ON Schadule_Campus FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Schadule_Campus */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Campus  Schadule_Campus on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002974b", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Campus_Name" */
    IF EXISTS (SELECT * FROM deleted,Campus
      WHERE
        /* %JoinFKPK(deleted,Campus," = "," AND") */
        deleted.Campus_Name = Campus.Campus_Name AND
        NOT EXISTS (
          SELECT * FROM Schadule_Campus
          WHERE
            /* %JoinFKPK(Schadule_Campus,Campus," = "," AND") */
            Schadule_Campus.Campus_Name = Campus.Campus_Name
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Schadule_Campus because Campus exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Labor_day  Schadule_Campus on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Labor_day" */
    IF EXISTS (SELECT * FROM deleted,Labor_day
      WHERE
        /* %JoinFKPK(deleted,Labor_day," = "," AND") */
        deleted.ID_Labor_day = Labor_day.ID_Labor_day AND
        NOT EXISTS (
          SELECT * FROM Schadule_Campus
          WHERE
            /* %JoinFKPK(Schadule_Campus,Labor_day," = "," AND") */
            Schadule_Campus.ID_Labor_day = Labor_day.ID_Labor_day
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Schadule_Campus because Labor_day exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Labor_day_Campus ON Schadule_Campus FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Schadule_Campus */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insID_Labor_day integer, 
           @insCampus_Name nvarchar(50),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Campus  Schadule_Campus on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c7fd", PARENT_OWNER="", PARENT_TABLE="Campus"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="Campus_Name" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Campus_Name)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Campus
        WHERE
          /* %JoinFKPK(inserted,Campus) */
          inserted.Campus_Name = Campus.Campus_Name
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Schadule_Campus because Campus does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Labor_day  Schadule_Campus on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Campus"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Labor_day" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Labor_day)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Labor_day
        WHERE
          /* %JoinFKPK(inserted,Labor_day) */
          inserted.ID_Labor_day = Labor_day.ID_Labor_day
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Schadule_Campus because Labor_day does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Room_Organisation ON Room_Organisation FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Room_Organisation */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Organisation  Room_Organisation on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00032214", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="ID_Organisation" */
    IF EXISTS (SELECT * FROM deleted,Organisation
      WHERE
        /* %JoinFKPK(deleted,Organisation," = "," AND") */
        deleted.ID_Organisation = Organisation.ID_Organisation AND
        NOT EXISTS (
          SELECT * FROM Room_Organisation
          WHERE
            /* %JoinFKPK(Room_Organisation,Organisation," = "," AND") */
            Room_Organisation.ID_Organisation = Organisation.ID_Organisation
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Room_Organisation because Organisation exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Room  Room_Organisation on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Room_Number" */
    IF EXISTS (SELECT * FROM deleted,Room
      WHERE
        /* %JoinFKPK(deleted,Room," = "," AND") */
        deleted.Campus_Name = Room.Campus_Name AND
        deleted.Name_Number_of_Building = Room.Name_Number_of_Building AND
        deleted.Room_Number = Room.Room_Number AND
        NOT EXISTS (
          SELECT * FROM Room_Organisation
          WHERE
            /* %JoinFKPK(Room_Organisation,Room," = "," AND") */
            Room_Organisation.Campus_Name = Room.Campus_Name AND
            Room_Organisation.Name_Number_of_Building = Room.Name_Number_of_Building AND
            Room_Organisation.Room_Number = Room.Room_Number
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Room_Organisation because Room exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Room_Organisation ON Room_Organisation FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Room_Organisation */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insCampus_Name nvarchar(64), 
           @insName_Number_of_Building nvarchar(32), 
           @insRoom_Number integer, 
           @insID_Organisation integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Organisation  Room_Organisation on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00032391", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="ID_Organisation" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Organisation)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Organisation
        WHERE
          /* %JoinFKPK(inserted,Organisation) */
          inserted.ID_Organisation = Organisation.ID_Organisation
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Room_Organisation because Organisation does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Room  Room_Organisation on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Room"
    CHILD_OWNER="", CHILD_TABLE="Room_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_30", FK_COLUMNS="Campus_Name""Name_Number_of_Building""Room_Number" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building) OR
    UPDATE(Room_Number)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Room
        WHERE
          /* %JoinFKPK(inserted,Room) */
          inserted.Campus_Name = Room.Campus_Name and
          inserted.Name_Number_of_Building = Room.Name_Number_of_Building and
          inserted.Room_Number = Room.Room_Number
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Room_Organisation because Room does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Groups_Class ON Groups_Class FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Groups_Class */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Class  Groups_Class on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00037432", PARENT_OWNER="", PARENT_TABLE="Class"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="ID_Time_span""Campus_Name""Name_Number_of_Building""Number_Room""
               Date_Class" */
    IF EXISTS (SELECT * FROM deleted,Class
      WHERE
        /* %JoinFKPK(deleted,Class," = "," AND") */
        deleted.ID_Time_span = Class.ID_Time_span AND
        deleted.Campus_Name = Class.Campus_Name AND
        deleted.Name_Number_of_Building = Class.Name_Number_of_Building AND
        deleted.Number_Room = Class.Number_Room AND
        deleted.Date_Class = Class.Date_Class AND
        NOT EXISTS (
          SELECT * FROM Groups_Class
          WHERE
            /* %JoinFKPK(Groups_Class,Class," = "," AND") */
            Groups_Class.ID_Time_span = Class.ID_Time_span AND
            Groups_Class.Campus_Name = Class.Campus_Name AND
            Groups_Class.Name_Number_of_Building = Class.Name_Number_of_Building AND
            Groups_Class.Number_Room = Class.Number_Room AND
            Groups_Class.Date_Class = Class.Date_Class
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Groups_Class because Class exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Groups  Groups_Class on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="Full_Group_Number" */
    IF EXISTS (SELECT * FROM deleted,Groups
      WHERE
        /* %JoinFKPK(deleted,Groups," = "," AND") */
        deleted.Full_Group_Number = Groups.Full_Group_Number AND
        NOT EXISTS (
          SELECT * FROM Groups_Class
          WHERE
            /* %JoinFKPK(Groups_Class,Groups," = "," AND") */
            Groups_Class.Full_Group_Number = Groups.Full_Group_Number
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Groups_Class because Groups exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Groups_Class ON Groups_Class FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Groups_Class */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFull_Group_Number nvarchar(15), 
           @insID_Time_span integer, 
           @insCampus_Name nvarchar(64), 
           @insName_Number_of_Building nvarchar(32), 
           @insNumber_Room integer, 
           @insDate_Class datetime,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Class  Groups_Class on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00035f05", PARENT_OWNER="", PARENT_TABLE="Class"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="ID_Time_span""Campus_Name""Name_Number_of_Building""Number_Room""
               Date_Class" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Time_span) OR
    UPDATE(Campus_Name) OR
    UPDATE(Name_Number_of_Building) OR
    UPDATE(Number_Room) OR
    UPDATE(Date_Class)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Class
        WHERE
          /* %JoinFKPK(inserted,Class) */
          inserted.ID_Time_span = Class.ID_Time_span and
          inserted.Campus_Name = Class.Campus_Name and
          inserted.Name_Number_of_Building = Class.Name_Number_of_Building and
          inserted.Number_Room = Class.Number_Room and
          inserted.Date_Class = Class.Date_Class
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Groups_Class because Class does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Groups  Groups_Class on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Class"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="Full_Group_Number" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Full_Group_Number)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Groups
        WHERE
          /* %JoinFKPK(inserted,Groups) */
          inserted.Full_Group_Number = Groups.Full_Group_Number
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Groups_Class because Groups does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Labor_day_Organisation ON Schadule_Organisation FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Schadule_Organisation */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Organisation  Schadule_Organisation on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002e894", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="ID_Organisation" */
    IF EXISTS (SELECT * FROM deleted,Organisation
      WHERE
        /* %JoinFKPK(deleted,Organisation," = "," AND") */
        deleted.ID_Organisation = Organisation.ID_Organisation AND
        NOT EXISTS (
          SELECT * FROM Schadule_Organisation
          WHERE
            /* %JoinFKPK(Schadule_Organisation,Organisation," = "," AND") */
            Schadule_Organisation.ID_Organisation = Organisation.ID_Organisation
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Schadule_Organisation because Organisation exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Labor_day  Schadule_Organisation on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="ID_Labor_day" */
    IF EXISTS (SELECT * FROM deleted,Labor_day
      WHERE
        /* %JoinFKPK(deleted,Labor_day," = "," AND") */
        deleted.ID_Labor_day = Labor_day.ID_Labor_day AND
        NOT EXISTS (
          SELECT * FROM Schadule_Organisation
          WHERE
            /* %JoinFKPK(Schadule_Organisation,Labor_day," = "," AND") */
            Schadule_Organisation.ID_Labor_day = Labor_day.ID_Labor_day
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Schadule_Organisation because Labor_day exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Labor_day_Organisation ON Schadule_Organisation FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Schadule_Organisation */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insID_Labor_day integer, 
           @insID_Organisation integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Organisation  Schadule_Organisation on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002f3a4", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_37", FK_COLUMNS="ID_Organisation" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Organisation)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Organisation
        WHERE
          /* %JoinFKPK(inserted,Organisation) */
          inserted.ID_Organisation = Organisation.ID_Organisation
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Schadule_Organisation because Organisation does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Labor_day  Schadule_Organisation on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Labor_day"
    CHILD_OWNER="", CHILD_TABLE="Schadule_Organisation"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="ID_Labor_day" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Labor_day)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Labor_day
        WHERE
          /* %JoinFKPK(inserted,Labor_day) */
          inserted.ID_Labor_day = Labor_day.ID_Labor_day
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Schadule_Organisation because Labor_day does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Student ON Student FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Student */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Student  Groups_Student on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00011d51", PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="Email" */
    IF EXISTS (
      SELECT * FROM deleted,Groups_Student
      WHERE
        /*  %JoinFKPK(Groups_Student,deleted," = "," AND") */
        Groups_Student.Email = deleted.Email
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Student because Groups_Student exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Student ON Student FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Student */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insEmail varchar(64),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Student  Groups_Student on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000125f8", PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="Email" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Email)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Groups_Student
      WHERE
        /*  %JoinFKPK(Groups_Student,deleted," = "," AND") */
        Groups_Student.Email = deleted.Email
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Student because Groups_Student exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Groups_Student ON Groups_Student FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Groups_Student */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Student  Groups_Student on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000278dd", PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="Email" */
    IF EXISTS (SELECT * FROM deleted,Student
      WHERE
        /* %JoinFKPK(deleted,Student," = "," AND") */
        deleted.Email = Student.Email AND
        NOT EXISTS (
          SELECT * FROM Groups_Student
          WHERE
            /* %JoinFKPK(Groups_Student,Student," = "," AND") */
            Groups_Student.Email = Student.Email
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Groups_Student because Student exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Groups  Groups_Student on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="Full_Group_Number" */
    IF EXISTS (SELECT * FROM deleted,Groups
      WHERE
        /* %JoinFKPK(deleted,Groups," = "," AND") */
        deleted.Full_Group_Number = Groups.Full_Group_Number AND
        NOT EXISTS (
          SELECT * FROM Groups_Student
          WHERE
            /* %JoinFKPK(Groups_Student,Groups," = "," AND") */
            Groups_Student.Full_Group_Number = Groups.Full_Group_Number
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Groups_Student because Groups exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Groups_Student ON Groups_Student FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Groups_Student */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFull_Group_Number nvarchar(15), 
           @insEmail varchar(64),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Student  Groups_Student on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c40e", PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="Email" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Email)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Student
        WHERE
          /* %JoinFKPK(inserted,Student) */
          inserted.Email = Student.Email
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Groups_Student because Student does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Groups  Groups_Student on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="Groups_Student"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="Full_Group_Number" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Full_Group_Number)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Groups
        WHERE
          /* %JoinFKPK(inserted,Groups) */
          inserted.Full_Group_Number = Groups.Full_Group_Number
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Groups_Student because Groups does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Education_program ON Education_program FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Education_program */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Education_program  Groups on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003e722", PARENT_OWNER="", PARENT_TABLE="Education_program"
    CHILD_OWNER="", CHILD_TABLE="Groups"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_41", FK_COLUMNS="Edu_level""Edu_prog_name" */
    IF EXISTS (
      SELECT * FROM deleted,Groups
      WHERE
        /*  %JoinFKPK(Groups,deleted," = "," AND") */
        Groups.Edu_level = deleted.Edu_level AND
        Groups.Edu_prog_name = deleted.Edu_prog_name
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Education_program because Groups exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Organisation  Education_program on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="ID_Organisation" */
    IF EXISTS (SELECT * FROM deleted,Organisation
      WHERE
        /* %JoinFKPK(deleted,Organisation," = "," AND") */
        deleted.ID_Organisation = Organisation.ID_Organisation AND
        NOT EXISTS (
          SELECT * FROM Education_program
          WHERE
            /* %JoinFKPK(Education_program,Organisation," = "," AND") */
            Education_program.ID_Organisation = Organisation.ID_Organisation
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Education_program because Organisation exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Faculty  Education_program on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="Short_Faculty_Name" */
    IF EXISTS (SELECT * FROM deleted,Faculty
      WHERE
        /* %JoinFKPK(deleted,Faculty," = "," AND") */
        deleted.Short_Faculty_Name = Faculty.Short_Faculty_Name AND
        NOT EXISTS (
          SELECT * FROM Education_program
          WHERE
            /* %JoinFKPK(Education_program,Faculty," = "," AND") */
            Education_program.Short_Faculty_Name = Faculty.Short_Faculty_Name
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Education_program because Faculty exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Education_program ON Education_program FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Education_program */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insEdu_level nvarchar(16), 
           @insEdu_prog_name nvarchar(128),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Education_program  Groups on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00045e5b", PARENT_OWNER="", PARENT_TABLE="Education_program"
    CHILD_OWNER="", CHILD_TABLE="Groups"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_41", FK_COLUMNS="Edu_level""Edu_prog_name" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Edu_level) OR
    UPDATE(Edu_prog_name)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Groups
      WHERE
        /*  %JoinFKPK(Groups,deleted," = "," AND") */
        Groups.Edu_level = deleted.Edu_level AND
        Groups.Edu_prog_name = deleted.Edu_prog_name
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Education_program because Groups exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Organisation  Education_program on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Organisation"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_46", FK_COLUMNS="ID_Organisation" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Organisation)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Organisation
        WHERE
          /* %JoinFKPK(inserted,Organisation) */
          inserted.ID_Organisation = Organisation.ID_Organisation
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.ID_Organisation IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Education_program because Organisation does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Faculty  Education_program on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Faculty"
    CHILD_OWNER="", CHILD_TABLE="Education_program"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_43", FK_COLUMNS="Short_Faculty_Name" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Short_Faculty_Name)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Faculty
        WHERE
          /* %JoinFKPK(inserted,Faculty) */
          inserted.Short_Faculty_Name = Faculty.Short_Faculty_Name
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Short_Faculty_Name IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Education_program because Faculty does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go



