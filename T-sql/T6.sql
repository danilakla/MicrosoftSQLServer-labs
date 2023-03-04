
-- ����������� ��������, � ������� � ������� CASE ������������� ����-��, ���������� ���������� ��������-�� ���������� ��� ����� ���������.
USE UNIVER;
SELECT CASE 
		when (PROGRESS.NOTE = 5) then '����'
		when (PROGRESS.NOTE = 6) then '�����'
		when (PROGRESS.NOTE between 6 and 7) then '����'
		when (PROGRESS.NOTE between 7 and 8) then '������'
		else '������ �������'
		end [������],
		count(*) [���������� �������� � ������ ��������]
		FROM PROGRESS 
		Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		GROUP BY CASE 
			when (PROGRESS.NOTE = 5) then '����'
			when (PROGRESS.NOTE = 6) then '�����'
			when (PROGRESS.NOTE between 6 and 7) then '����'
			when (PROGRESS.NOTE between 7 and 8) then '������'
			else '������ �������'
			end
		ORDER BY [���������� �������� � ������ ��������]
