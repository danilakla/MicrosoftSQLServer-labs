-- ����������� ������ AUTO ����������� � �������������� ��������. � ���� ������ ����� AUTO ��������� ��������� XML-�������� � 
-- �����-������ ��������� ���������.
USE UNIVER
select a.AUDITORIUM_NAME, at.AUDITORIUM_TYPENAME, a.AUDITORIUM_CAPACITY
		from AUDITORIUM a 
		Inner Join AUDITORIUM_TYPE at on at.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE
			where a.AUDITORIUM_TYPE='��' 
for xml auto, 
root('����������_���������'), -- �������� ���
elements;
go 
