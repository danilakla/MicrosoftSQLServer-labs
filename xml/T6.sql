USE PP_MyBase
go
select s.?????_??????'?????_??????', s.??????????'??????????', p.?????'?????'
	from ?????? s
	Inner Join ????????????? p on p.????????????_????? = s.??????????
		where  p.????? = '?.?????'
	for xml RAW('TEACHER'), root('?????????????_???????_????'), elements;
go

-------------------------------------------------------------

go
select s.?????_??????, s.??????????, p.?????
	from ?????? s
	Inner Join ????????????? p on p.????????????_????? = s.??????????
		where  p.????? = '?.?????'
	for xml AUTO, 
	root('?????????????_???????_????'), 
	elements;
go

------------------------------------------------------------

begin tran
declare @h int = 0,
      @xml varchar(2000) = '<?xml version="1.0" encoding="windows-1251" ?>
							<?????????????> 
								<????????????? ????????????_?????="?????4" ?????="?.??????????" ???????="9191454" /> 
								<????????????? ????????????_?????="?????5" ?????="?.?????" ???????="9988999" /> 
							</?????????????>'

exec sp_xml_preparedocument @h output, @xml;
select * from openxml(@h, '/?????????????/?????????????', 0)
	with(????????????_????? char(50), ????? varchar(50), ??????? char(20))    

print @h
print '?????????? ????????'

insert into ????????????? select * from openxml(@h, '/?????????????/?????????????', 0)
	with(????????????_????? char(50), ????? varchar(50), ??????? char(20))    

select * from ????????????? where ????????????_????? LIKE '?????%'

exec sp_xml_removedocument @h          

rollback 

select * from ?????????????