/*Логическое выражение, указанное в секции HAVING вычисляется для каж-дой строки результирующего набора, 
сформированного секцией GROUP BY. Как и в случае с секцией WHERE строка отбирается в результирующий набор, 
если логическое выражение принимает значение «истина».*/
USE UNIVER;
SELECT  p1.SUBJECT[Предмет], 
		p1.NOTE[Оценка],
		(SELECT COUNT(*) FROM PROGRESS p2
					WHERE p1.NOTE = p2.NOTE AND p1.SUBJECT = p2.SUBJECT) [Количество]
	FROM PROGRESS p1
	 GROUP BY p1.SUBJECT, p1.NOTE
	 HAVING NOTE IN(8, 9)
