/*#7-9*/
/* UNION объеден€ет результирующие строки двух запросов, но если будут полностью идентичны строки, он возьмет только одну из них */
/* UNION ALL тоже самое, но выведет две полностью одинковые строки */
/* –езультатом оператора INTERSECT €вл€етс€ набор строк, €вл€ющийс€ пересечением двух исходных наборов строк. */
/* –езультатом оператора EXCEPT €вл€етс€ набор строк, €вл€ющийс€ раз-ностью двух исходных наборов строк 
   (т.е. в результирующий набор вклю-чаютс€ те строки, которые есть в первом запросе, но отсутствуют во втором). */

USE UNIVER;
SELECT  f.FACULTY[‘акультет], 
		g.PROFESSION[—пециальность], 
		p.SUBJECT[ƒисциплина],
		round(avg(cast(p.NOTE as float(4))), 2)[—редн€€ оценка]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('“ќ¬')
	GROUP BY f.FACULTY, g.PROFESSION, p.SUBJECT

UNION all

SELECT  f.FACULTY[‘акультет], 
		g.PROFESSION[—пециальность], 
		p.SUBJECT[ƒисциплина],
		round(avg(cast(p.NOTE as float(4))), 2)[—редн€€ оценка]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('»ƒиѕ')
	GROUP BY f.FACULTY, g.PROFESSION, p.SUBJECT

