-- 1
-- ���������� ������ ��������� �������
DECLARE @z float, @x int = 5, @t int = 13
if		@t > @x
	SET @z = power(sin(@t),2);
else if @t < @x
	SET @z = 4 * (@t + @x);
else
	SET @z = (1 - exp(@x - 2))
PRINT 'z= ' + cast(@z as varchar(10))


-- 2
-- �������������� ������� ��� � �����������
DECLARE @result nvarchar(20);
DECLARE @fullname TABLE 
			(
				surname nvarchar(10) default '����������',
				name nvarchar(10) default '���������',
				secondname nvarchar(10) default '���������'
			);
INSERT @fullname default values;
SELECT * FROM @fullname;

-- ������� LEFT ��������� ��������� �� ������, ������� � ������ ������ �������.
Set @result = (SELECT (surname + ' ' + left(name, 1) + '. ' + left(secondname, 1) + '.') from @fullname); 

PRINT @result
SELECT @result result


-- 3
-- ������� ������ ��������, ��� �� � ����� ������
-- DATEDIFF( ��������, ����1, ����2 ) - ���������� �������� ���� Variant (Long), ����������� �� ���������� ���������� ������� ����� ����� ���������� ������
-- ������� YEAR ���������� �������������� ��� (��� �����) � ������ �������� ����
-- SYSDATETIME() - ���������� �������� ���� datetime2(7), ������� �������� ���� � ����� ����������, �� ������� ������� ��������� SQL Server.
USE UNIVER;
SELECT STUDENT.NAME [��� ��������],
	   STUDENT.BDAY [���� ��������],
	   DATEDIFF(YEAR, STUDENT.BDAY, SYSDATETIME()) AS [���������� ������ ���]
FROM STUDENT 
-- ������� MONTH ���������� ����� (����� �� 1 �� 12) � ������ �������� ����.
-- DATEADD( �������� (m - �����), �����, ���� ) - ���������� �������� ���� Variant (Date), ���������� ��������� ����������� � ���� ���������� ��������� �������
WHERE MONTH(STUDENT.BDAY) = MONTH(DATEADD(m, 1, SYSDATETIME())) --��������� � ������ �� ������ �������


-- 4
-- ����� ��� ������, � ������� �������� ��������� ������ ������� ������� �� ����.
-- DatePart (�������� (w - week), ���� ) - ������ ���������� ��������� ����� �������� ����.
DECLARE @examday date
SET @examday = (SELECT PROGRESS.PDATE 
				FROM PROGRESS Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
				WHERE PROGRESS.SUBJECT in('����') and STUDENT.IDSTUDENT in('1015'))
PRINT '����, � ������� �������� ��������� ������ ������� ������� �� ����: ' + cast(@examday as varchar(10))
PRINT '���� ������, � ������� �������� ��������� ������ ������� ������� �� ����: ' + CONVERT (varchar(12), DATEPART(w, @examday))
