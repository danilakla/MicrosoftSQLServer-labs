USE UNIVER;
/* ������������� � like */
go
CREATE VIEW [���������] ([��� ���������], [��� ���������])
	as select AUDITORIUM.AUDITORIUM,
			  AUDITORIUM.AUDITORIUM_TYPE		
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE like('��%')
go
SELECT * FROM [���������]

/* ��������� �������������� ������ */
--INSERT INTO [���������] ([��� ���������], [��� ���������]) values ('138-5', '��');
SELECT * FROM [���������] WHERE [��� ���������] = '138-5'


DROP VIEW [���������]