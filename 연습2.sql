-- *******
-- ����011. 
 
-- Ŀ�̼��� ���� ���ϴ� ������ �̸�,�����ڵ�,�޿�,Ŀ�̼Ǻ����� ��ȸ
-- *******
SELECT FNAME �̸�,JID �����ڵ�,SAL �޿�,PCT "Ŀ�̼� ����"
FROM EMP
WHERE PCT IS NULL;
-- *******
-- ����012. 
-- ����� 110,120,130�� ����� ���, ��, �̸� ��ȸ
-- *******
SELECT EID ���, LNAME ��,FNAME �̸�
FROM EMP
WHERE EID  IN('110','120','130');
-- *******
-- ����013. 
-- �μ��ڵ�� ��������, �޿��� ������������ 
-- �μ��ڵ�, �޿�, ���, �̸�, �� ����
-- �������� 0,1,2 ... �������� 9,8,7...
-- ******
SELECT DID �μ��ڵ�,SAL �޿�,EID ���,FNAME �̸�,LNAME ��
FROM EMP
ORDER BY DID ,SAL DESC; 
-- *******
-- ����014. 
-- �̸��� am �̶� ���ڰ� ���Ե� ������ ���,�̸�, ��
-- *******
SELECT EID ���,FNAME �̸�,LNAME ��
FROM EMP
WHERE FNAME LIKE '%am%';
-- *******
-- ����015. 
-- �̸��Ͽ� 'GG' �� 'KK'�δܾ� �� �ϳ��� ���ԵǾ ��ȸ
-- ��, ��ҹ��� ������
-- *******
SELECT EMAIL
FROM EMP
WHERE EMAIL LIKE '%GG%'  OR EMAIL LIKE '%KK%';

-- *******
-- ����016. 
-- �̸����ּҰ� A �� �������� �ʴ� �̸��� ����
-- *******
   SELECT EMAIL
   FROM EMP
   WHERE EMAIL NOT LIKE'A%';
-- *******
-- ����017.
-- ���� �ι�°,����° ���ڰ� ���ÿ� e �� ������ �̸�, ��
-- *******
SELECT FNAME �̸�,LNAME ��
FROM EMP
WHERE FNAME LIKE '_ee%';
-- *******
-- ����018
 -- �����ӱ��� 10000�� �̻��� ���� �� �� ������ ǥ���Ѵ�
-- *******
SELECT JID,TITLE,MINSAL,MAXSAL
FROM JOB
WHERE MINSAL >= 1000;
-- *******************
-- [����19]
-- 2002����� 2005����� 
-- ������ ������ �̸��� ���� ���ڸ� ǥ���Ѵ�.
-- *******************
SELECT FNAME �̸�,HDATE "���� ����"
FROM EMP
WHERE HDATE BETWEEN '2002/01/01' AND '2005/12/31';
-- *******************
-- [����020]
-- IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, �����ڵ� ǥ��.
-- *******************

SELECT FNAME �̸�,HDATE �Ի���,JID �����ڵ�
FROM EMP
WHERE JID IN('IT_PROG','SA_MAN');