-- ���������� -  ��� �������� ���� ������, ����������� ����� ������� ���������� ��������� ����������, ������-���� ���� ������, ����� 
-- ��� ���������� ���� ������������ ���������� ��� ��� ��� ����������� ��� ��� �� �������-����. 
-- �������� �������� ����������: 
-- ����������� (��������� ��������� ��, ���������� � ����������, ���� ��������-�� ���, ���� �� ���������� �� ����); 
-- ��������������� (���������� ������ ����������� ����� ������������� ��������� ��); 
-- ��������������� (���������� ��������� ������� ������������ ���������� �� ���������� �� ����������); 
-- ������������� (��������� � ��, ����������� � ��������������� �����������, ����� ���� �������� ������ � ������� ����� ����������).



USE [Vakulenchik-SALES]
SET nocount on

IF exists(SELECT * FROM SYS.OBJECTS			-- ���� �� ������� NewT
		  WHERE OBJECT_ID = object_id(N'DBO.NewT'))
DROP TABLE NewT;	-- ���� ���� �� ������� ��


DECLARE @c int, @flag char = 'c';

SET IMPLICIT_TRANSACTIONS ON --�������� ����� ������� ����������
CREATE TABLE NewT	-- ������ ����������
(
	K int
)
	INSERT NewT values (1),
					(2),
					(3);

	SET @c = (SELECT count(*) FROM NewT);

	PRINT '���������� ����� � ������� NewT: ' + cast(@c as varchar(2));
	IF  @flag = 'c' COMMIT;		-- ���������� ����������: �������� 
	ELSE ROLLBACK;				-- ���������� ����������: �����  
SET IMPLICIT_TRANSACTIONS OFF --��������� ����� ������� ����������

IF exists(SELECT * FROM SYS.OBJECTS
		  WHERE OBJECT_ID = object_id(N'DBO.NewT'))
PRINT '������� NewT ����';
ELSE PRINT '������� NewT ���'
-----------------------------------------------------


--DECLARE @r char = '';
--IF exists(SELECT * FROM SYS.OBJECTS
--		  WHERE OBJECT_ID = object_id(N'DBO.#newtable'))
--		  SET @r = 'yes'
--ELSE set @r = 'no'

--SET IMPLICIT_TRANSACTIONS ON
--if @r = 'yes'
--begin
--CREATE TABLE #newtable
--(
--	K int
--)

--COMMIT --�������� ��������
--end

---- else rollback; -- �������� ������ 

--SET IMPLICIT_TRANSACTIONS OFF



--INSERT INTO #newtable 
--values (1),
--	   (2),
--	   (3),
--	   (4)

--SELECT * FROM #newtable
--DROP TABLE #newtable