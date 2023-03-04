use UNIVER;
set nocount on;

declare @point varchar(32);
begin try
	begin tran
		delete TEACHER where TEACHER = '���';
		set @point = 'point1'; save tran @point;
		insert TEACHER values ('���','��������� ����� ��������', '�', '����');
		set @point = 'point2'; save tran @point;
		commit tran;
end try
begin catch
	print '������: ' + case when error_number() = 2627
		and patindex('%PK_TEACHER%', error_message()) > 0
	then '������������ ������'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@trancount > 0
		begin 
			print '����������� �����: ' + @point;
			rollback tran @point; --����� � ����������� �����
			commit tran;
		end;
end catch;