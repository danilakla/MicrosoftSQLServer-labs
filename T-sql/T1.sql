
--��� ���������� ����������, ������������ � ����������, ������������ �������� DECLARE
DECLARE 
--������������� � ��������� ����������
--��� ���������� ������ ���������� � ������� @
@h char = 'P',
@v varchar(4) = 'BSTU',
@datet date,
@dtime time,
@i int = 18,
@si smallint,
@ti tinyint,
@num numeric(12,5); 

--� ������� ��������� SET ����� ���������� ��������� �������� � ��������� ����������
SET @datet = '2022-03-31'
SET	@dtime = '20:20'

select @i = 3;
--� ������� ��������� PRINT ����� ������� ������ � ����������� �������� �����.    
PRINT @h 
PRINT @v 
PRINT @datet
PRINT @dtime

--���������� SELECT ����� ������������ �������� �������������� ����� 
SELECT @i intv, @si smallintv, @ti tinyintv

