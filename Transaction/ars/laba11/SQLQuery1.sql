   use �������;
    set nocount on
	if  exists (select * from  SYS.OBJECTS        -- ������� laba11zad1 ����?
	            where OBJECT_ID= object_id(N'DBO.laba11zad1') )	            
	drop table laba11zad1;           
	declare @c int, @flag char = 'c';           -- commit ��� rollback?
	SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
	CREATE table laba11zad1(K int );                         -- ������ ���������� 
		INSERT laba11zad1 values (1),(2),(3);
		set @c = (select count(*) from laba11zad1);
		print '���������� ����� � ������� laba11zad1: ' + cast( @c as varchar(2));
		if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
	          else   rollback;                                 -- ���������� ����������: �����  
      SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
	
	if  exists (select * from  SYS.OBJECTS       -- ������� laba11zad1 ����?
	            where OBJECT_ID= object_id(N'DBO.laba11zad1') )
	print '������� laba11zad1 ����';  
      else print '������� laba11zad1 ���'
