USE UNIVER;
SELECT  FACULTY.FACULTY[���������], PULPIT.PULPIT[�������], STUDENT.NAME[��� ��������], GROUPS.PROFESSION[�������������], SUBJECT.SUBJECT[����������],
		CASE 
		when (PROGRESS.NOTE = 6) then '�����'
		when (PROGRESS.NOTE between 6 and 7) then '����'
		when (PROGRESS.NOTE between 7 and 8) then '������'
		else '������ �������'
		end [������]
		FROM PROGRESS 
		Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		Inner Join GROUPS ON STUDENT.IDGROUP = GROUPS.IDGROUP
		Inner Join SUBJECT ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
		Inner Join FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
		Inner Join PULPIT ON SUBJECT.PULPIT = PULPIT.PULPIT
			ORDER BY 
			(CASE
					when (PROGRESS.NOTE = 7) then 1
					when (PROGRESS.NOTE = 8) then 2
					when (PROGRESS.NOTE = 6) then 3
					else 4
				end
			)