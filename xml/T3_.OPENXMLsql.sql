-- ����������� ������� ������� ��������� ������ �� xml ����

USE UNIVER;
begin tran
declare @h int = 0, -- ���� xml ���
      @xml varchar(2000) = '<?xml version="1.0" encoding="windows-1251" ?>	
							<SUBJECTS> 
								<SUBJECT SUBJECT="���" SUBJECT_NAME="���������� ����������� �������" PULPIT="����" /> 
								<SUBJECT SUBJECT="����" SUBJECT_NAME="���������� ��������� � �������" PULPIT="��" /> 
								<SUBJECT SUBJECT="����" SUBJECT_NAME="��������������� ��������� � �������" PULPIT="���"  />  
							</SUBJECTS>'

exec sp_xml_preparedocument @h output, @xml;	 -- ���������� ��������� 
select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)	--����������, ��������� XPATH � ����� ������������� �����, ��������-���� ����� ������ �������.    	
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20))  -- ��������� ��������� ������������ ���-�  

insert into SUBJECT select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) 

select * from SUBJECT where SUBJECT LIKE '%��'

exec sp_xml_removedocument @h          

rollback 

select * from SUBJECT
