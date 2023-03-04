--Локальный курсор может применяться в рамках одного пакета и ресурсы, вы-деленные ему при объявлении, 
--освобождаются сразу после завершения работы пакета

USE UNIVER;
DECLARE Student CURSOR LOCAL
				for SELECT STUDENT.NAME, PROGRESS.NOTE
					FROM PROGRESS Inner Join STUDENT
					ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
					WHERE PROGRESS.SUBJECT IN('СУБД')
PRINT '<---Отметки студентов за экзамен по СУБД--->' 
DECLARE @stud char(50), @n int;
	OPEN Student;
	FETCH Student into @stud, @n;
	print '1.'+ @stud + cast(@n as varchar(3));
	go
	--конец пакета
DECLARE @stud char(50), @n int;
	FETCH Student into @stud, @n;
	print '2.'+ @stud + cast(@n as varchar(3));
	go

---==================================================---
--Глобальный курсор может быть объявлен, открыт и использован в разных паке-тах. 
--Выделенные ему при объявлении ресурсы освобождаются только после вы-полнения оператора DEALLOCATE или при завершении сеанса пользователя

DECLARE Student CURSOR GLOBAL
				for SELECT STUDENT.NAME, PROGRESS.NOTE
					FROM PROGRESS Inner Join STUDENT
					ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
					WHERE PROGRESS.SUBJECT IN('СУБД')
DECLARE @stud char(50), @n int;
	OPEN Student;
	FETCH Student into @stud, @n;
	print '1.'+ @stud + cast(@n as varchar(3));
	go
DECLARE @stud char(50), @n int;
	FETCH Student into @stud, @n;
	print '2.'+ @stud + cast(@n as varchar(3));
	go
	CLOSE Student;
	DEALLOCATE Student;
	go

