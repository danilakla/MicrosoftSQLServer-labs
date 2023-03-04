
/* �1 - ����������������� ���������� */
/* �������� IN ��������� ���������� �������� ������� � ��� ������, ���� ��������, ��������� ����� �� ��������� ����� IN, 
����� ���� �� ������ �� �������� ������, ���������� ������.  */
use UNIVER;

SELECT FACULTY.FACULTY[���������], PULPIT.PULPIT_NAME[�������], PROFESSION.PROFESSION_NAME[�������������]
	FROM FACULTY, PULPIT, PROFESSION
	WHERE FACULTY.FACULTY = PULPIT.FACULTY and FACULTY.FACULTY = PROFESSION.FACULTY
	and PROFESSION.PROFESSION_NAME in (Select PROFESSION.PROFESSION_NAME from PROFESSION
									   Where (PROFESSION.PROFESSION_NAME like '%���������%'))

/* �2 - ���� �����, �� ����� Inner Join */
SELECT FACULTY.FACULTY[���������], PULPIT.PULPIT_NAME[�������], PROFESSION.PROFESSION_NAME[�������������]
	FROM FACULTY 
	Inner Join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	Inner Join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
	Where PROFESSION.PROFESSION_NAME in (Select PROFESSION.PROFESSION_NAME from PROFESSION
									   Where (PROFESSION.PROFESSION_NAME like '%���������%'))

/* �3 - ���� �����, �� ����� Inner Join � ��� ���-�� ����������� */
SELECT FACULTY.FACULTY[���������], PULPIT.PULPIT_NAME[�������], PROFESSION.PROFESSION_NAME[�������������]
	FROM FACULTY 
	Inner Join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	Inner Join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
	Where PROFESSION.PROFESSION_NAME like '%���������%'