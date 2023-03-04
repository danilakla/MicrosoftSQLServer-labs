
/* �6 - ������ �� ������� ��������� */

use UNIVER;
SELECT top 1
	(SELECT avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT like '%����') [������� ��-� �� ����],
	(SELECT avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT like '%��') [������� ��-� �� ��],
	(SELECT avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT like '%����') [������� ��-� �� ����]
	from PROGRESS


/* �7 - all-���������� */
/* �������� >=ALL ��������� �������� �������� � ��� ������, ���� �������� ������� ����� ������ ��� ����� ������� �������� � ������, 
��������� ������. */

/* ��� ����������� ���� ��������� � ������ �� ��� */
SELECT SUBJECT, NOTE from PROGRESS
/* ������� ��� ��������, �� ������� ������ ����, ��� � ������� ���� */
SELECT SUBJECT, NOTE from PROGRESS
	where note >= all (SELECT NOTE from PROGRESS
						where SUBJECT like '����')


/* �8 - ������ � any-������������ */
/* ��������  >=ANY ��������� �������� �������� � ��� ������, ���� �������� ������� �����, ������ ��� ����� ���� �� ������ �������� 
� ������, ���-������ ������. */

SELECT SUBJECT, NOTE from PROGRESS
/* ������� ��� ��������, �� ������� ������ ����, ��� ���� �� � ������ ���� */
SELECT SUBJECT, NOTE from PROGRESS
	where note >= any (SELECT NOTE from PROGRESS
						where SUBJECT like '����')