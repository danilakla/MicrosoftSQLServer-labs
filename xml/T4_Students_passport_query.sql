-- разработать select запрос с xml доком
USE UNIVER
create table Students
(
	STUDENT nvarchar(100) primary key ,
	PasportData xml
);
 
insert into Students 
values ('Манакова Анастасия Владимировна',
		'<Pasport>
			<Sereal>MP</Sereal>
				<Number>22223333</Number>
				<PersonalNumber>124124124</PersonalNumber>
				<Date>15/05/2015</Date>
				<Addres>ул.Первомайская, д.110</Addres>
		</Pasport>'),
	   ('Махно Нестр Петрович',
		'<Pasport>
			<Sereal>MP</Sereal>
			<Number>1234555</Number>
			<PersonalNumber>9412412</PersonalNumber>
			<Date>01/04/2014</Date>
			<Addres>ул.Свердлова, д.53</Addres>
		</Pasport>')
 select Students.STUDENT,
		PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[Серия паспорта],
		PasportData.value('(/Pasport/Number)[1]','int')[Номер паспорта],
		PasportData.value('(/Pasport/PersonalNumber)[1]','varchar(100)')[Личный номер],
		PasportData.value('(/Pasport/Date)[1]','date')[Дата выдачи],
		PasportData.value('(/Pasport/Addres)[1]','varchar(100)')[Адрес студента],
		PasportData.query('/Pasport') [Паспортные данные]
			from Students;

update Students 
	  set PasportData = '<Pasport>
							<Sereal>MM</Sereal>
							<Number>55666777</Number>
							<PersonalNumber>123456</PersonalNumber>
							<Date>16/06/2015</Date>
							<Addres>ул.Свердлова, д.53</Addres>
						</Pasport>'
				where PasportData.value('(/Pasport/Number)[1]','int')=1234555
 go
  select Students.STUDENT[Name],
		PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[Серия паспорта],
		PasportData.value('(/Pasport/Number)[1]','int')[Номер паспорта],
		PasportData.query('/Pasport') [Паспортные данные]
			from Students;



drop table Students