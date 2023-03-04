USE VAK_myBase;
SELECT * 
	FROM ПРЕДМЕТ a FULL Outer Join ПРЕПОДАВАТЕЛЬ b
	ON a.код_группы = b.Код_преподавателя

SELECT * 
	FROM ПРЕДМЕТ a FULL Outer Join ПРЕПОДАВАТЕЛЬ b
	ON a.код_группы = b.Код_преподавателя
	WHERE a.код_группы IS NULL OR b.Код_преподавателя IS NULL

SELECT * 
	FROM ПРЕДМЕТ a Inner Join ПРЕПОДАВАТЕЛЬ b
	ON a.код_группы = b.Код_преподавателя

SELECT * 
	FROM ПРЕДМЕТ a Left Outer Join ПРЕПОДАВАТЕЛЬ b
	ON a.код_группы = b.Код_преподавателя

SELECT * 
	FROM ПРЕДМЕТ a Left Outer Join ПРЕПОДАВАТЕЛЬ b
	ON a.код_группы = b.Код_преподавателя
	WHERE b.Код_преподавателя IS NULL

SELECT * 
	FROM ПРЕДМЕТ a Right Outer Join ПРЕПОДАВАТЕЛЬ b
	ON a.код_группы = b.Код_преподавателя

SELECT * 
	FROM ПРЕДМЕТ a Right Outer Join ПРЕПОДАВАТЕЛЬ b
	ON a.код_группы = b.Код_преподавателя
	WHERE a.код_группы IS NULL