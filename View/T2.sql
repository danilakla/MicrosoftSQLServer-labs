/* ������ � inner join ���� ������ � ������������� */
USE UNIVER;
go
CREATE VIEW [���������� ������]
	as select FACULTY.FACULTY_NAME [���������],
			  count(*) [���������� ������]	/* ���������� �-��, ����������� ���-�� ����� � ����. ����-� faculty_name  */
			  FROM FACULTY Inner Join PULPIT
			  ON FACULTY.FACULTY = PULPIT.FACULTY
			  GROUP BY FACULTY.FACULTY_NAME
go
SELECT * FROM [���������� ������]

DROP VIEW [���������� ������];