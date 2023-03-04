use [Vakulenchik-SALES];

-- Работа с Full Outer Join

SELECT *
	From Заказы a Full Outer Join ТОВАРЫ b 
	On a.Наименование_товара = b.Наименование
	Order by a.Наименование_товара, b.Наименование

-- Док-во, что Full Outer Join включает в себя Inner Join

SELECT *
	FROM Заказы a Inner Join Товары b
	On a.Наименование_товара = b.Наименование
	Order by a.Наименование_товара, b.Наименование

-- Док-во, что Full Outer Join является объединеним Right и Left Outer Join

SELECT *
	FROM Заказы a Left Outer Join Товары b
	On a.Наименование_товара = b.Наименование
	Order by a.Наименование_товара, b.Наименование

SELECT *
	FROM Заказы a Right Outer Join Товары b
	On a.Наименование_товара = b.Наименование
	Order by a.Наименование_товара, b.Наименование

-- Док-во, что Full ... коммутативная - что порядок входящих таблиц не влияет на результат

SELECT *
	From ТОВАРЫ b  Full Outer Join Заказы a 
	On a.Наименование_товара = b.Наименование
	Order by a.Наименование_товара, b.Наименование