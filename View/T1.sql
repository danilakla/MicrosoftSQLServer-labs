USE UNIVER;
go
/* ������ � �������������� (view) */
CREATE VIEW [�������������]
	as select TEACHER [���],
			  TEACHER_NAME[��� �������������],
			  PULPIT [�������] 
		FROM TEACHER
/* ����� �� ����� ������������� ������������� */
go
SELECT * FROM �������������
/* ��������� ������������� � ��� ��������� Alter (��������� ) */
go
ALTER VIEW [�������������]
	as select TEACHER [���],
			  TEACHER_NAME[��� �������������],
			  GENDER [���],
			  PULPIT [�������] 
		FROM TEACHER
go
SELECT * FROM �������������
/* �������� ������������� */
DROP VIEW [�������������]