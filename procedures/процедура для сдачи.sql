USE UNIVER
go
CREATE PROCEDURE PPROGRESS @sub nvarchar(20) = null
as
begin 
	
	select PROGRESS.NOTE, PROGRESS.SUBJECT FROM PROGRESS WHERE PROGRESS.SUBJECT = @sub

end;
go


exec PPROGRESS @sub = 'ясад'