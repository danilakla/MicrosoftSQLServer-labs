USE UNIVER;
/* ���������� ��� �������� */
select * from AUDITORIUM;
/* �1 */
SELECT  max(AUDITORIUM.AUDITORIUM_CAPACITY)[Max �����������], 
		min(AUDITORIUM.AUDITORIUM_CAPACITY)[Min �����������], 
		avg(AUDITORIUM.AUDITORIUM_CAPACITY)[������� ����������� ���������], 
		sum(AUDITORIUM.AUDITORIUM_CAPACITY)[��������� ����������� ���� ���������], 
		count(*)[����� ���������� ���������]
	FROM AUDITORIUM

/* �2 */
/* Group By ��������� ������������� ������ � ���������� �������. ��� sum ��� ��������� ����� ����� �� ��������� (��������)
   ����� ������������� 
*/
USE UNIVER;
SELECT  AUDITORIUM_TYPE.AUDITORIUM_TYPENAME[��� ���������], 
		max(AUDITORIUM.AUDITORIUM_CAPACITY)[Max �����������], 
		min(AUDITORIUM.AUDITORIUM_CAPACITY)[Min �����������], 
		avg(AUDITORIUM.AUDITORIUM_CAPACITY)[������� ����������� ���������], 
		sum(AUDITORIUM.AUDITORIUM_CAPACITY)[��������� ����������� ���� ���������], 
		count(*)[����� ���������� ���������]
	FROM AUDITORIUM Inner Join AUDITORIUM_TYPE
	ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
	Group by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME

/* �3 */
USE UNIVER;
SELECT * FROM 
			(SELECT Case 
				when PROGRESS.NOTE = 10 then '10'
				when PROGRESS.NOTE between 8 and 9 then '8-9'
				when PROGRESS.NOTE between 6 and 7 then '6-7'
				when PROGRESS.NOTE between 4 and 5 then '4-5'
				when PROGRESS.NOTE between 1 and 3 then '1-3'
				end [������], count(*)[����������]			/* ����� ���� ������� ����� ��������� ����� � ����������� ���������� ���� ������ */
					FROM PROGRESS
					GROUP BY Case		/* ������ ������� � ������� Group By */
						when PROGRESS.NOTE = 10 then '10'	/* ����� ����������� ����� ����� ������� ����� ������������ */
						when PROGRESS.NOTE between 8 and 9 then '8-9'
						when PROGRESS.NOTE between 6 and 7 then '6-7'
						when PROGRESS.NOTE between 4 and 5 then '4-5'
						when PROGRESS.NOTE between 1 and 3 then '1-3'
						end) as T
						ORDER BY Case [������]	/* ����������� ���������� ��� ������������ �������� */
						when '10' then 1
						when '8-9' then 2
						when '6-7' then 3
						when '4-5' then 4
						else 0
						end;

/* �4(�) */
USE UNIVER;
/* ���������� ������� CAST ������������ � ������� ��� �������� �������� � ������������ �����. */
/* ������� ROUND ������������ ������ �������� � ��������� �� ���� ������ ����� �������: */

SELECT  f.FACULTY[���������], /* ������ ����� ���� ����� ��������� (����� �����, ��� �������, f,g - ) */
		g.PROFESSION[�������������], 
		g.YEAR_FIRST[��� �����������],
		round(avg(cast(p.NOTE as float(4))),2)[������� ������]	/* ������� ������� */
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	GROUP BY f.FACULTY, g.PROFESSION, g.YEAR_FIRST
	ORDER BY [������� ������] desc;

/* �4(�) */
-- �������� ������ �������������� ������ ������ �� ����������� � ������ �� � ����
USE UNIVER;
SELECT  f.FACULTY[���������], 
		g.PROFESSION[�������������], 
		g.YEAR_FIRST[��� �����������],
		round(avg(cast(p.NOTE as float(4))),2)[������� ������]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE p.SUBJECT IN('��', '����')
	GROUP BY f.FACULTY, g.PROFESSION, g.YEAR_FIRST
	ORDER BY [������� ������] desc;

/*#5*/
-- ������ ������� ������
USE UNIVER;
SELECT  f.FACULTY[���������], 
		g.PROFESSION[�������������], 
		p.SUBJECT[����������],
		round(avg(cast(p.NOTE as float(4))), 2)[������� ������]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('���')
	GROUP BY f.FACULTY, g.PROFESSION, p.SUBJECT

--ROLLUP ������� ����� �� �������������� ������ ����� ��� � ��� ������� group by � �������� ������ �� ���������, ���������� � ������� ������ �� ���� ����� rollup
SELECT  f.FACULTY[���������], 
		g.PROFESSION[�������������], 
		p.SUBJECT[����������],
		round(avg(cast(p.NOTE as float(4))), 2)[������� ������]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('���')
	GROUP BY ROLLUP (f.FACULTY, g.PROFESSION, p.SUBJECT)
-- ������� ��� ������ �� ������� ���������, �������� ������ �� �������������, ���������� � ���� �����������

-- �6: CUBE ��������� ����� ��������� ���������� ����� � ������� c����
SELECT  f.FACULTY[���������], 
		g.PROFESSION[�������������], 
		p.SUBJECT[����������],
		round(avg(cast(p.NOTE as float(4))), 2)[������� ������]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('���')
	GROUP BY CUBE (f.FACULTY, g.PROFESSION, p.SUBJECT)