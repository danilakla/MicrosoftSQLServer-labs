USE PP_MyBase
go
create procedure OUTPUT_PROCEDURE as
begin
	declare @count int = (select count(*) from ������)
	select * from ������
	return @count
end
go

declare @count int
exec @count = OUTPUT_PROCEDURE
print @count

drop procedure OUTPUT_PROCEDURE


------------------------------------------------//---------------------------------------------

go
CREATE TABLE #SDELKI
(
	�����_������ int primary key,
	���������� nvarchar(20),
	�����_�������� nvarchar(10),
	������������_������ nvarchar(20),
	���������� int,
	����_������ date,
	���� real
)
--------------------------------------------------------
go

ALTER PROCEDURE [dbo].[OUTPUT_PROCEDURE] @p varchar(20) = null
as
begin
	declare @k int = (select count (*) from ������);
	select * from ������
					where ���������� = @p;
end;
go
-------------------------------------------------------
INSERT #SDELKI exec OUTPUT_PROCEDURE @p = '�����1'
INSERT #SDELKI exec OUTPUT_PROCEDURE @p = '�����3'

SELECT * FROM #SDELKI
DROP TABLE #SDELKI
