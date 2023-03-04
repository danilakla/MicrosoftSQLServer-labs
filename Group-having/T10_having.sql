/*���������� ���������, ��������� � ������ HAVING ����������� ��� ���-��� ������ ��������������� ������, 
��������������� ������� GROUP BY. ��� � � ������ � ������� WHERE ������ ���������� � �������������� �����, 
���� ���������� ��������� ��������� �������� �������.*/
USE UNIVER;
SELECT  p1.SUBJECT[�������], 
		p1.NOTE[������],
		(SELECT COUNT(*) FROM PROGRESS p2
					WHERE p1.NOTE = p2.NOTE AND p1.SUBJECT = p2.SUBJECT) [����������]
	FROM PROGRESS p1
	 GROUP BY p1.SUBJECT, p1.NOTE
	 HAVING NOTE IN(8, 9)
