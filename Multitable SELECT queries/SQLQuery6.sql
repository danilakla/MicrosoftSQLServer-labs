--- ���� ��������� ���� ���� ������ �� �����������, �� � ������� Left Outer Join, ����� �������
--- �� ������. ����, ������� ��������� � ������� ����� �� ���� ���� Left Outer Join

--- isnull ��������� ��� ��������� � ������� ���, ��� ������ �� ����� null

USE UNIVER;
SELECT PULPIT.PULPIT_NAME[�������], isnull (TEACHER.TEACHER_NAME, '***')[�������������]
	FROM PULPIT Left Outer Join TEACHER
		ON PULPIT.PULPIT = TEACHER.PULPIT