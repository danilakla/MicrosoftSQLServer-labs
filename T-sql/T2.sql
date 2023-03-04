--����������� ������, � ������� ����-�������� ����� ����������� ������-���. ����� ����� ����������� ���-������ 200, 
--�� ������� ���������� ���������, ������� ����������� ���������, ���������� ���������, ����������� ������� ������ �������, 
--� ������� ����� ���������. ����� ����� ����������� ��������� ������ 200, �� ������� ��������� � ������� ����� �����������

USE UNIVER;
DECLARE @capacity int = (SELECT SUM(AUDITORIUM.AUDITORIUM_CAPACITY) FROM AUDITORIUM),
		@numOfAud int = (SELECT COUNT(*) FROM AUDITORIUM),
		@avgCapac int = (SELECT AVG(AUDITORIUM.AUDITORIUM_CAPACITY) FROM AUDITORIUM),
		@numLessAvg int,
		@proc numeric(8,3);	--��� numeric ��������� ������� ����� � ����� ������� ����������� ����
							-- ���������� � ����� numeric ���� ������ ����������, ��� ��� ��������, ��������, ��� ��������, ��������� � ���������.
IF @capacity > 200
begin
	PRINT '������ ����������� ���������: ' + cast(@capacity as varchar(10));	/* cast ����������� ���� ��� � ������. ���� ��� ������ ����� ����� ������ Conversion failed when converting the varchar value '������ ����������� ���������: ' to data type int. */
	PRINT '���������� ���������: ' + cast(@numOfAud as varchar(10));
	PRINT '������� ����������� ���������: ' + cast(@avgCapac as varchar(10));
	SET @numLessAVG = (SELECT count(*)		-- ����� ��� ���., ����������� ������� ������ ��������
							FROM AUDITORIUM
							WHERE AUDITORIUM_CAPACITY < @avgCapac)
	PRINT '���������� ���������, ����������� ������� ����� �������: ' + cast(@numLessAVG as varchar(10));
	SET @proc = ((cast(@numLessAvg as numeric(8,3)) *100) / cast(@numOfAud as numeric(8,3)));	-- ������� ������� ����� ���.
	PRINT '������� ���������, ����������� ������� ����� �������: ' + cast(@proc as varchar(10));
end
ELSE IF @capacity = 200 PRINT '����� ��������������� ����� 200'
ELSE IF @capacity < 200 PRINT '����� ��������������� ������ 200'

