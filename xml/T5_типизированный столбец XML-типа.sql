-- сделать поле INFO таблицы контролировалaсь коллекцией XML-схем
USE UNIVER;
create xml schema collection Studentss as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
		elementFormDefault="qualified"
		xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xs:element name="студент">
	<xs:complexType><xs:sequence>
	<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
	<xs:complexType>
    <xs:attribute name="серия" type="xs:string" use="required" />
    <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="дата"  use="required"  >
	<xs:simpleType>  <xs:restriction base ="xs:string">
	<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	</xs:restriction>	</xs:simpleType>
    </xs:attribute>	</xs:complexType>
	</xs:element>
	<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
	<xs:element name="адрес">   <xs:complexType><xs:sequence>
	<xs:element name="страна" type="xs:string" />
    <xs:element name="город" type="xs:string" />
    <xs:element name="улица" type="xs:string" />
    <xs:element name="дом" type="xs:string" />
    <xs:element name="квартира" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element>
</xs:schema>';

go
create table STUDENTSS
( 
	IDSTUDENT integer  identity(1000,1) 
		 constraint STUDENTSS_PK  primary key,
   IDGROUP integer constraint STUDENTSS_GROUP_FK
		 foreign key  references GROUPS(IDGROUP),        
  NAME nvarchar(100), 
  BDAY  date,
  STAMP timestamp,
  INFO     xml(STUDENTSS),    -- типизированный столбец XML-типа
  FOTO   varbinary
);
go 

insert into STUDENTSS(INFO)
	values (
	'
	<студент>
			<паспорт>
				<серия></серия>
			</паспорт>
			<телефон></телефон>
			<адрес>
				<страна></страна>
				<город></город>
				<улица></улица>
				<дом></дом>
				<квартира></квартира>
			</адрес>
		</студент>
	'
	)

-- с ошибкой, так как валидатор не видит Pasport
--insert into STUDENTSS(INFO)
--	values (
--	'
--	<Pasport>
--			<Sereal>MP</Sereal>
--				<Number>22223333</Number>
--				<PersonalNumber>124124124</PersonalNumber>
--				<Date>15/05/2015</Date>
--				<Addres>ул.Первомайская, д.110</Addres>
--		</Pasport>
--	'
--	)


drop table STUDENTSS;
drop xml schema collection Studentss