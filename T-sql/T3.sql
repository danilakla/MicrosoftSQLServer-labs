-- ������ � ����������� �����������

PRINT '����� ������������ �����: ' + cast(@@ROWCOUNT as varchar(10))
PRINT '������ SQL Server: ' + cast(@@VERSION as varchar(10))
PRINT '��������� ������������� ��������, ����������� �������� �������� �����������: ' + cast(@@SPID as varchar(10))
PRINT '��� ��������� ������: ' + cast(@@ERROR as varchar(10))
PRINT '��� �������: ' + cast(@@SERVERNAME as varchar(10))
PRINT '���������� ������� ����������� ����������: ' + cast(@@TRANCOUNT as varchar(10));
PRINT '�������� ���������� ���������� ����� ��������������� ������: ' + cast(@@FETCH_STATUS as varchar(10))
PRINT '������� ����������� ������� ���������: ' + cast(@@NESTLEVEL as varchar(10))
