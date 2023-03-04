-- разработать запросы которые извлекают данные из xml дока

USE UNIVER;
begin tran
declare @h int = 0, -- ниже xml док
      @xml varchar(2000) = '<?xml version="1.0" encoding="windows-1251" ?>	
							<SUBJECTS> 
								<SUBJECT SUBJECT="РПР" SUBJECT_NAME="Разработка программных роботов" PULPIT="ИСиТ" /> 
								<SUBJECT SUBJECT="ИГИГ" SUBJECT_NAME="Инженерная геометрия и графика" PULPIT="ТЛ" /> 
								<SUBJECT SUBJECT="ПГИГ" SUBJECT_NAME="Полиграфическая геометрия и графика" PULPIT="ТиП"  />  
							</SUBJECTS>'

exec sp_xml_preparedocument @h output, @xml;	 -- подготовка документа 
select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)	--дескриптор, выражение XPATH и целое положительное число, определя-ющее режим работы функции.    	
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20))  -- указываем структуру формируемого рез-а  

insert into SUBJECT select * from openxml(@h, '/SUBJECTS/SUBJECT', 0)
	with(SUBJECT char(10), SUBJECT_NAME varchar(100), PULPIT char(20)) 

select * from SUBJECT where SUBJECT LIKE '%ИГ'

exec sp_xml_removedocument @h          

rollback 

select * from SUBJECT
