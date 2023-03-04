
/* скрипт для создания трех таблиц */

use SALES;
CREATE table ТОВАРЫ
(	Наименование nvarchar(50) primary key,
	Цена real unique not null,
	Количество int
);

CREATE TABLE Заказчики
(   Наименование_фирмы nvarchar(20) primary key,
	Адрес nvarchar(50),
    Расчетный_счет nvarchar(20) 
);


CREATE TABLE Заказы
 (	Номер_заказа int primary key,
    Наименование_товара nvarchar(50) foreign key references Товары (Наименование),
	Цена_продажи real,
    Количество int,
	Дата_поставки date,
	Заказчик nvarchar(20) foreign key references Заказчики(Наименование_фирмы)
);


/* скрипт для добавляения и удаления нового столбца */

ALTER Table Товары ADD Дата_поставки date not null;
ALTER Table Товары DROP Column Дата_поставки;

