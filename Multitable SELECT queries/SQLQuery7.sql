use UNIVER;
SELECT PULPIT.PULPIT_NAME[�������], isnull(TEACHER.TEACHER_NAME, '***')[�������������]
	from TEACHER Left Outer Join PULPIT
	on TEACHER.PULPIT = PULPIT.PULPIT

--- ����������� ����� ����� right outer join

SELECT PULPIT.PULPIT_NAME[�������], isnull(TEACHER.TEACHER_NAME, '***')[�������������]
	from PULPIT Right Outer Join TEACHER 
	on TEACHER.PULPIT = PULPIT.PULPIT