use [Vakulenchik-SALES];

-- ������ � Full Outer Join

SELECT *
	From ������ a Full Outer Join ������ b 
	On a.������������_������ = b.������������
	Order by a.������������_������, b.������������

-- ���-��, ��� Full Outer Join �������� � ���� Inner Join

SELECT *
	FROM ������ a Inner Join ������ b
	On a.������������_������ = b.������������
	Order by a.������������_������, b.������������

-- ���-��, ��� Full Outer Join �������� ����������� Right � Left Outer Join

SELECT *
	FROM ������ a Left Outer Join ������ b
	On a.������������_������ = b.������������
	Order by a.������������_������, b.������������

SELECT *
	FROM ������ a Right Outer Join ������ b
	On a.������������_������ = b.������������
	Order by a.������������_������, b.������������

-- ���-��, ��� Full ... ������������� - ��� ������� �������� ������ �� ������ �� ���������

SELECT *
	From ������ b  Full Outer Join ������ a 
	On a.������������_������ = b.������������
	Order by a.������������_������, b.������������