
/* №1 - Некореллированные подзапросы */
/* Операция IN формирует логическое значение «истина» в том случае, если значение, указанное слева от ключевого слова IN, 
равно хотя бы одному из значений списка, указанного справа.  */
use UNIVER;

SELECT FACULTY.FACULTY[Факультет], PULPIT.PULPIT_NAME[Кафедра], PROFESSION.PROFESSION_NAME[Специальность]
	FROM FACULTY, PULPIT, PROFESSION
	WHERE FACULTY.FACULTY = PULPIT.FACULTY and FACULTY.FACULTY = PROFESSION.FACULTY
	and PROFESSION.PROFESSION_NAME in (Select PROFESSION.PROFESSION_NAME from PROFESSION
									   Where (PROFESSION.PROFESSION_NAME like '%технологи%'))

/* №2 - тоже самое, но через Inner Join */
SELECT FACULTY.FACULTY[Факультет], PULPIT.PULPIT_NAME[Кафедра], PROFESSION.PROFESSION_NAME[Специальность]
	FROM FACULTY 
	Inner Join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	Inner Join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
	Where PROFESSION.PROFESSION_NAME in (Select PROFESSION.PROFESSION_NAME from PROFESSION
									   Where (PROFESSION.PROFESSION_NAME like '%технологи%'))

/* №3 - тоже самое, но через Inner Join и без исп-ия подзапросов */
SELECT FACULTY.FACULTY[Факультет], PULPIT.PULPIT_NAME[Кафедра], PROFESSION.PROFESSION_NAME[Специальность]
	FROM FACULTY 
	Inner Join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	Inner Join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
	Where PROFESSION.PROFESSION_NAME like '%технологи%'