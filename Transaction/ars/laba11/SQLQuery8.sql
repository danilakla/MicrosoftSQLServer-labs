

begin tran 
	create table #Task8 (Num int identity, Words nvarchar(20))
	insert #Task8 values ('����������'), ('���������'), ('���������')

	begin tran 
		insert #Task8 values ('������')
	commit tran 

 if exists (select Words from #Task8 where Words = '������')
 commit tran 
 else rollback tran 
 select Num[Id], Words[������] from #Task8
drop table #Task8


begin tran 
	create table #Task9(Num int identity, Words nvarchar(20))
	insert #Task9 values ('qwerty'), ('asdfg'), ('zxcvb')
	begin tran 
		insert #Task9 values ('zxcvbn')
	--rollback tran 
 if exists (select Words from #Task9 where Words = 'zxcvbn')
 commit tran 
 else rollback tran 
 select Num[Id], Words[������] from #Task9

 drop table #Task9