USE UNIVER;
go
/* ������ ORDER BY ����� ������������ ������ ��������� � ������ TOP */
CREATE VIEW [����������]
	as select TOP 15  SUBJECT.SUBJECT_NAME [��� ����������],
					  SUBJECT.SUBJECT_NAME [������������ ����������],
					  SUBJECT.PULPIT [��� �������]
	FROM SUBJECT
	ORDER BY SUBJECT.SUBJECT_NAME
go
SELECT * FROM [����������] 

DROP VIEW [����������] 
