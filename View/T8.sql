--����������� ������������� ��� ������� TIMETABLE (������������ ������ 6) � ���� ����������. ������� �������� PIVOT � ������������ ���
USE UNIVER;
go
CREATE VIEW [����������]
	as select WEEKDAY.WEEKDAY_NAME [���� ������],
			  TIMETABLE.SCHEDULE_ID [����� ����],
			  TIMETABLE.SUBJECT [����������],
			  TIMETABLE.AUDITORIUM [���������],
			  TIMETABLE.IDGROUP [������]
	from WEEKDAY Inner Join TIMETABLE
	on WEEKDAY.ID = TIMETABLE.WEEKDAY
go

SELECT * FROM [����������]

SELECT [����� ����], [�����������], [�������], [�����], [�������], [�������], [�������] 
FROM [����������]
PIVOT (count(����������) for [���� ������] in ([�����������], [�������], [�����], [�������], [�������], [�������])) as first_test_pivot

SELECT [������], 
	   [1] as [8.00-9.20], 
	   [2] as [9.35-10.55], 
	   [3] as [11.25-12.45], 
	   [4] as [13.00-14.20],
	   [5] as [14.40-16.00],
	   [6] as [16.30-17.50],
	   [7] as [18.05-19.25],
	   [8] as [19.40-21.00]
FROM [����������]
PIVOT(count([����������]) for [����� ����] in([1], [2], [3], [4], [5], [6], [7], [8])) as sec_test_pivot
   
DROP VIEW [����������]