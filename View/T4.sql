USE UNIVER;
------���������� INSERT � UPDATE �����������, �� � ������ �����������, ����������� ������ WITH CHECK OPTION
go
CREATE VIEW [���������� ���������]
	as select AUDITORIUM.AUDITORIUM [��� ���������],
			  AUDITORIUM.AUDITORIUM_TYPE [��� ���������]
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE like('��%') WITH CHECK OPTION
go
SELECT * FROM [���������� ���������]

/* ������� �������� ������, ������� �� ����� ������������� ������� */
--INSERT INTO [���������� ���������]([��� ���������], [��� ���������]) values ('1490-1', '��-�'); 
/* �������� ������, ���� �� �������� ��-� �� �� */
--INSERT INTO [���������� ���������]([��� ���������], [��� ���������]) values ('141-11', '��');
SELECT * FROM [���������� ���������] WHERE [��� ���������] = '140-1'



DROP VIEW [���������� ���������]

