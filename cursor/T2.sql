--��������� ������ ����� ����������� � ������ ������ ������ � �������, ��-�������� ��� ��� ����������, 
--������������� ����� ����� ���������� ������ ������

USE UNIVER;
DECLARE Student CURSOR LOCAL
				for SELECT STUDENT.NAME, PROGRESS.NOTE
					FROM PROGRESS Inner Join STUDENT
					ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
					WHERE PROGRESS.SUBJECT IN('����')
PRINT '<---������� ��������� �� ������� �� ����--->' 
DECLARE @stud char(50), @n int;
	OPEN Student;
	FETCH Student into @stud, @n;
	print '1.'+ @stud + cast(@n as varchar(3));
	go
	--����� ������
DECLARE @stud char(50), @n int;
	FETCH Student into @stud, @n;
	print '2.'+ @stud + cast(@n as varchar(3));
	go

---==================================================---
--���������� ������ ����� ���� ��������, ������ � ����������� � ������ ����-���. 
--���������� ��� ��� ���������� ������� ������������� ������ ����� ��-�������� ��������� DEALLOCATE ��� ��� ���������� ������ ������������

DECLARE Student CURSOR GLOBAL
				for SELECT STUDENT.NAME, PROGRESS.NOTE
					FROM PROGRESS Inner Join STUDENT
					ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
					WHERE PROGRESS.SUBJECT IN('����')
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

