
/* є6 - работа со средним значением */

use UNIVER;
SELECT top 1
	(SELECT avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT like '%ќјиѕ') [—редн€€ оц-а по ќјиѕ],
	(SELECT avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT like '% √') [—редн€€ оц-а по  √],
	(SELECT avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT like '%—”Ѕƒ') [—редн€€ оц-а по —”Ѕƒ]
	from PROGRESS


/* є7 - all-подзапросы */
/* ќпераци€ >=ALL формирует истинное значение в том случае, если значение сто€щее слева больше или равно каждому значению в списке, 
указанном справа. */

/* дл€ отображени€ всех предметов и оценок по ним */
SELECT SUBJECT, NOTE from PROGRESS
/* выводит все предметы, по которым оценка выше, чем у каждого ќјиѕ */
SELECT SUBJECT, NOTE from PROGRESS
	where note >= all (SELECT NOTE from PROGRESS
						where SUBJECT like 'ќјиѕ')


/* є8 - работа с any-подзапросами */
/* ќпераци€  >=ANY формирует истинное значение в том случае, если значение сто€щее слева, больше или равно хот€ бы одному значению 
в списке, ука-занном справа. */

SELECT SUBJECT, NOTE from PROGRESS
/* выводит все предметы, по которым оценка выше, чем хот€ бы у одного ќјиѕ */
SELECT SUBJECT, NOTE from PROGRESS
	where note >= any (SELECT NOTE from PROGRESS
						where SUBJECT like 'ќјиѕ')