-- � ������ ���� � try ���������� �� ���������, ��� �������� � catch, ������ ������ � ���������� ����� ����� rollback
-- �������� ��� �������� ��-�� �����������

USE UNIVER
DECLARE @trcount int
BEGIN TRY -- ������ ����� try
	BEGIN TRAN -- ������������ � ����� ����� ����������
		DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = '����� ����������';
		--DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = '����� ����� ����������';
		INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����������');
		INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����������');
		INSERT AUDITORIUM_TYPE VALUES ('��-�', '����� ����� ����������');
		COMMIT TRAN;
	END TRY
BEGIN CATCH 
		PRINT '������: ' + case -- PATINDEX ���������� � ������ ������� ������� ������� ���-������, �������� ��������
							WHEN error_number() = 2627 and patindex('%AUDITORIUM_TYPE_PK%', error_message()) > 0 -- 2627 - ������ ���� ����
								THEN '������������ ���� ���������'
						   else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
						   end;
	SET @trcount = @@TRANCOUNT  -- ���������� ������� ����������� ���������� (���� ������ 0 �� ���� �� ���������)
	PRINT @trcount
	IF @@TRANCOUNT > 0 ROLLBACK TRAN;
END CATCH;

-- � ����� ��������� ��� ��� ��� ���� �� ������ (@trancount ����� = 1), �� ���������� ����� � ������� insert �� ������� � ����
-- ����� �� �� ������� �������� ������ ��-�� �����������: ����-� ���-� ������ � ����-� ���� ��� �������-�, ���� ���.
