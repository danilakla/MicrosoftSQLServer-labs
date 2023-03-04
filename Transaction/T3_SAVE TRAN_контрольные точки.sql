-- ������ � ������������� �� ����� Save Tran

USE UNIVER;
DECLARE @point varchar(32);
BEGIN TRY
	BEGIN TRAN				--������ ����� ����������
		DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = '����� ����������';
		SET @point = 'p1'; SAVE TRAN @point;	-- ��������� ����������� ����� ����������.
		
		INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����������');
		SET @point = 'p2'; SAVE TRAN @point;	-- ������ ��
		
		INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����������');
		--INSERT AUDITORIUM_TYPE VALUES ('��-��', '���������� ����������');
	COMMIT TRAN;	-- ��������� ���� ����� ������ �� (@point = p2)
END TRY
BEGIN CATCH 
		PRINT '������: ' + CASE 
						   WHEN error_number() = 2627 and patindex('%AUDITORIUM_TYPE_PK%', error_message()) > 0
							THEN '������������ ���� ���������'
							ELSE '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
						   end;
	IF @@TRANCOUNT > 0
		begin 
			print '����������� �����: ' + @point;
			rollback tran @point;		--����� � ����������� �����
			commit tran;				--�������� ���������, ������������ �� ����������� �����
		end
END CATCH

