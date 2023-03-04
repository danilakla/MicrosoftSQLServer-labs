use UNIVER

declare @Note int, @Name nvarchar(50), @Faculty nvarchar(20);
declare myCurs cursor dynamic global for select PROGRESS.NOTE, STUDENT.NAME, GROUPS.FACULTY
                      from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
                      inner join  GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP

open myCurs
fetch myCurs into @Note, @Name, @Faculty
while @@FETCH_STATUS = 0
  begin
    print 'Оценка ' + cast(@Note as nvarchar(10)) + ' - ' + @Name + ' - ' + @Faculty
    fetch myCurs into @Note, @Name, @Faculty

    if @Note <4 
      delete PROGRESS where current of myCurs

    if @Note <4 
      delete STUDENT where current of myCurs

    if @Note <4 
      delete GROUPS where current of myCurs
  end
close myCurs
deallocate myCurs
go


--------------------------------------------------------------------------------------



declare @Subject nvarchar(10), @IDStudent int, @Note int
declare Task6 cursor global dynamic for select SUBJECT, IDSTUDENT, NOTE
                    from PROGRESS for update

open Task6
fetch Task6 into @Subject, @IDStudent, @Note
while @@FETCH_STATUS = 0
  begin
    print @Subject + ' ' +cast(@IDStudent as nvarchar(10)) + ' ' + cast(@Note as nvarchar(20))
    if @IDStudent = 1021 update PROGRESS set NOTE = NOTE - 1 where current of Task6
    fetch Task6 into @Subject, @IDStudent, @Note
  end
close Task6
deallocate Task6

select SUBJECT[Предмет], IDSTUDENT[Id студента], NOTE[Оценка] from PROGRESS
go

update PROGRESS set NOTE = 9 where IDSTUDENT = 1021







--USE UNIVER;
--SELECT STUDENT.IDSTUDENT, STUDENT.NAME, PROGRESS.NOTE								--до изменения отметки на 1
--		FROM STUDENT
--		Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--		WHERE STUDENT.IDSTUDENT IN ('1007')


--DECLARE @n int, @name nvarchar(30), @mark int
--DECLARE Stud CURSOR LOCAL DYNAMIC
--	for SELECT STUDENT.IDSTUDENT, STUDENT.NAME, PROGRESS.NOTE
--		FROM STUDENT
--		Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--		WHERE STUDENT.IDSTUDENT IN ('1007')

--OPEN Stud;
--FETCH Stud into @n, @name, @mark;
--PRINT cast(@n as nvarchar(10)) + ' ' + @name + ' ' + cast(@mark as nvarchar(2))
--UPDATE PROGRESS SET NOTE = NOTE + 1 WHERE CURRENT OF Stud
--CLOSE Stud


--SELECT STUDENT.IDSTUDENT, STUDENT.NAME, PROGRESS.NOTE 								--после изменения отметки на 1
--		FROM STUDENT
--		Inner Join PROGRESS ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--		WHERE STUDENT.IDSTUDENT IN ('1007')