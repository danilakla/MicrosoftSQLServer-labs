USE UNIVER;
DECLARE @faculty nvarchar(10), @pulpitcount int, 
		@pulpitn nvarchar(10), @teachercount int, 
		@subjectn nvarchar(15), @subjectPulpit nvarchar(50), @subjectarray nvarchar(300) = ''

DECLARE @i int

DECLARE Faculty CURSOR LOCAL DYNAMIC
	for SELECT FACULTY.FACULTY, COUNT(*) 
	FROM FACULTY
	Inner Join PULPIT ON PULPIT.FACULTY = FACULTY.FACULTY
	GROUP BY FACULTY.FACULTY 
	ORDER BY FACULTY.FACULTY

DECLARE Pulpit CURSOR LOCAL DYNAMIC
	for SELECT PULPIT.PULPIT, COUNT(*) 
	FROM PULPIT
	Left Outer Join TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
	GROUP BY FACULTY, PULPIT.PULPIT
	ORDER BY FACULTY

DECLARE Subjectt CURSOR LOCAL DYNAMIC
	for SELECT SUBJECT.SUBJECT, SUBJECT.PULPIT
	FROM SUBJECT

OPEN Faculty
OPEN Pulpit 
	FETCH from Faculty into @faculty, @pulpitcount
	PRINT 'Факультет: ' + @faculty
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @i = 0
		WHILE @i < @pulpitcount
			BEGIN
				SET @subjectarray = ''
				FETCH from Pulpit into @pulpitn, @teachercount
				PRINT char(9) + 'Кафедра: ' + @pulpitn
				PRINT char(9) + char(9) + 'Количество преподавателей: ' + cast(@teachercount as nvarchar(10))

				OPEN Subjectt
					FETCH from Subjectt into @subjectn, @subjectPulpit
					IF (@subjectPulpit = @pulpitn)
						SET @subjectarray = trim(@subjectn) + ', ' + @subjectarray

						WHILE @@FETCH_STATUS = 0
							BEGIN 
							FETCH from Subjectt into @subjectn, @subjectPulpit
							IF (@subjectPulpit = @pulpitn)
								SET @subjectarray = trim(@subjectn) + ', ' + @subjectarray
								END
				CLOSE Subjectt

				IF len(@subjectarray) > 0
					SET @subjectarray = left(@subjectarray, len(@subjectarray)-1)
				ELSE
					SET @subjectarray = 'нет'
					PRINT char(9) + char(9) + 'Дисциплины: ' + @subjectarray
					SET @i = @i+1
				END

			FETCH from Faculty into @faculty, @pulpitcount
			IF (@@fetch_status = 0) print 'Факультет: ' + @faculty
		END

CLOSE Faculty
CLOSE Pulpit
go
