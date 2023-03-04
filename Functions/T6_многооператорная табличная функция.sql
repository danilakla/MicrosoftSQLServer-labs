+go
create function FACULTY_REPORT(@c int) returns @fr table ( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, [Количество студентов] int, [Количество специальностей] int )
	as begin 
           declare cc CURSOR static for 
	       select FACULTY from FACULTY 
                             where dbo.COUNT_STUDENTS(FACULTY, default) > @c; 
	       declare @f varchar(30);
	       open cc;  
           fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  (select count(PULPIT) from PULPIT where FACULTY = @f),
	            (select count(IDGROUP) from GROUPS where FACULTY = @f),   dbo.COUNT_STUDENTS(@f, default),
	            (select count(PROFESSION) from PROFESSION where FACULTY = @f)   ); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;
go
-------------------------------------
go
create function PulpitCount(@faculty varchar(50)) returns int
as
begin
	 declare @pulpitCount int = 0
	 set @pulpitCount = (select count(*)
							from PULPIT
								where PULPIT.FACULTY = @faculty)
	return @pulpitCount
end
go
go
create function GroupCount(@faculty varchar(50)) returns int
as
begin
	 declare @groupCount int = 0
	 set @groupCount = (select count(*)
							from GROUPS
								where GROUPS.FACULTY = @faculty)
	return @groupCount
end
go
go
create function StudentCount(@faculty varchar(50)) returns int
as
begin
	declare @studentCount int = 0
	set @studentCount = (select count(*) 
							from STUDENT 
							Inner Join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
							Inner Join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
								where FACULTY.FACULTY = @faculty)
	return @studentCount
end
go
go
create function ProfessionCount(@faculty varchar(50)) returns int
as
begin
	 declare @professionCount int = 0
	 set @professionCount = (select count(*)
							from PROFESSION
								where PROFESSION.FACULTY = @faculty)
	return @professionCount
end
go

go
create function FacultyReport(@studentCount int) returns  @result table
																(
																	faculty varchar(50),
																	pulpitCount int, 
																	groupCount int, 
																	professionCount int
																)
as
begin
	declare FacultyCursor cursor local for
		select FACULTY from FACULTY where dbo.StudentCount(FACULTY) > @studentCount
	declare @faculty varchar(50)
	open FacultyCursor
		fetch FacultyCursor into @faculty
		while @@FETCH_STATUS = 0
		begin
			insert into @result values
			(@faculty, dbo.PulpitCount(@faculty), dbo.GroupCount(@faculty), dbo.ProfessionCount(@faculty))

			fetch FacultyCursor into @faculty
		end

	close FacultyCursor
	return
end
go

select FACULTY, dbo.StudentCount(FACULTY)[student count] from FACULTY
select * from dbo.FacultyReport(14)