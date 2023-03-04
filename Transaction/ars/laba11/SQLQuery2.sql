use UNIVER;

begin try 
	begin tran
		delete TEACHER where TEACHER = '���';
		insert TEACHER values ('���','��������� ����� ��������', '�', '����');
		commit tran;
	end try
	begin catch
		print '������: ' + case
		when error_number() = 2627 and patindex('%PK_TEACHER%', error_message()) > 0
		/*patindex ���������� � ������ ������� ������� ������� ���������, �������� ��������. � ������� ���� ������� � ������ ��������� 
		�� ������ ������������ ��� ����������� ����������� */
		then '������������ ������'
		else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@trancount > 0 rollback tran; --TRANCOUNT ���������� ������� ����������� ����������. (���� �������� ������ ����, �� ���������� �� ���������). 
end catch;
