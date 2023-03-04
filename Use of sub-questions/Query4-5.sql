/* №4 - сортировка с подзапросами */
use UNIVER;

/* смотрим, какие capacity у одинаковых type, сортируем их по убивынию, берем только верхнее значение и выводим для данного type.
Далее переходим к следующему типу. */
SELECT AUDITORIUM_CAPACITY[Вместимость], AUDITORIUM_TYPE[Тип], AUDITORIUM_NAME
	from AUDITORIUM a
	Where AUDITORIUM_CAPACITY = (SELECT top(1) AUDITORIUM_CAPACITY from AUDITORIUM aa
								where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE
								Order by AUDITORIUM_CAPACITY desc)
	Order by AUDITORIUM_CAPACITY desc

/* №5 - сортировка с прединкатом not exists */
/* Операция EXISTS формирует значение «истина», если результирующий набор подзапроса содержит хотя бы одну строку, 
в противоположном случае - значение «ложь». */

select FACULTY.FACULTY_NAME[Факультет]
	from FACULTY
	where not exists (SELECT * from PULPIT where FACULTY.FACULTY = PULPIT.FACULTY)
/* если посмотреть инф-ю faculty и pulpit, то заметим, что только у факультета ИиДП нету кафедр */