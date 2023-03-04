USE UNIVER;
go
/* ������ �� 2�� ������� */
CREATE VIEW [���������� ������]
	as select FACULTY.FACULTY_NAME [���������],
			  count(*) [���������� ������]
			  FROM FACULTY Inner Join PULPIT
			  ON FACULTY.FACULTY = PULPIT.FACULTY
			  GROUP BY FACULTY.FACULTY_NAME
go
SELECT * FROM [���������� ������]
/* ����� SCHEMABINDING ������������� ���������� �� �������� � ��������� � ���������������, ������� ����� �������� � 
   ��������� ��-��������������� �������������.
   ����� ��� �������� ���������� �������� ������������� ������������� � ��-����� �������� */
go
ALTER VIEW [���������� ������] WITH SCHEMABINDING
	as select FACULTY.FACULTY_NAME [���������],
			  count(*) [���������� ������]
			  FROM dbo.FACULTY Inner Join dbo.PULPIT
			  ON FACULTY.FACULTY = PULPIT.FACULTY
			  GROUP BY FACULTY.FACULTY_NAME
go

SELECT * FROM [���������� ������]

DROP VIEW [���������� ������];