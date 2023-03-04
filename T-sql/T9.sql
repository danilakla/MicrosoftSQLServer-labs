-- try-catch
declare @x int = 3, @y int = 0, @z int;
begin TRY
	set @z = @x / @y;
end TRY
begin CATCH 
	print '����� ������ : ' + CAST(ERROR_NUMBER() as varchar(6));
	print '���������    : ' + ERROR_MESSAGE();
	print '����� ������ : ' + CAST(ERROR_LINE() as varchar(8));
	print '���������    : ' + CAST(ERROR_PROCEDURE() as varchar(6));
	print '�������      : ' + CAST(ERROR_SEVERITY() as varchar(6));
	print '����� ������ : ' + CAST(ERROR_STATE() as varchar(8));
end catch