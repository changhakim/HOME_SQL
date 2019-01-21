-- Employees ���̺�
--[ employee_id = ��� ] [ first_name = �̸� ] 
--[ last_name = �� ] [ email = �̸��� ] 
--[ phone_number = ��ȭ��ȣ ] [ hire_date = �Ի��� ]
--[ job_id = �����ڵ� ] [ salary = �޿�]
--[ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = �Ŵ������̵�]
--[ department_id = �μ��ڵ�]

--  Jobs ���̺�

-- job_id �����ڵ�
-- job_title ����Ÿ��Ʋ
-- min_salary  �����޿�
-- max_salary �ְ�޿�

DESC EMPLOYEES;
CREATE VIEW  EMP AS
SELECT 
EMPLOYEE_ID EID,
FIRST_NAME FNAME,
LAST_NAME LNAME,
EMAIL,
PHONE_NUMBER PNUMBER,
HIRE_DATE HDATE,
JOB_ID JID,
SALARY SAL,
COMMISSION_PCT PCT,
MANAGER_ID MID,
DEPARTMENT_ID DID
FROM EMPLOYEES;
DESC JOBS;
CREATE VIEW JOB AS
SELECT
JOB_ID JID,
JOB_TITLE TITLE,
MIN_SALARY MINSAL,
MAX_SALARY MAXSAL
FROM JOBS;
-- *******
-- ����001. 
-- HR ��Ű�� ���̺��� ��� ���?
-- *******
SELECT * FROM TAB;
-- *******
-- ����002. 
-- HR ��Ű�� ���̺� ���� �?
-- *******
SELECT COUNT(*) FROM TAB;
-- *******
-- ����003. 
-- ���, ��, �̸����?
-- *******
SELECT EID,LNAME,FNAME
FROM EMP;

-- *******
-- ����004. 
-- �̸��� s�� ������ ������ �̸� ���?
-- *******
SELECT FNAME
FROM EMP
WHERE FNAME LIKE '%s';
-- *******
-- ����005. 
-- �̸��� s�� �����ϴ� ������ �̸� ���?
-- *******
SELECT FNAME
FROM EMP
WHERE FNAME LIKE 'S%';
-- *******
-- ����006. 
-- �޿��� ���� ������ �̸�,�μ��ڵ�,�޿� ��ȸ 
-- *******
 SELECT FNAME,DID,SAL
 FROM EMP
 ORDER BY SAL DESC;

-- *******
-- ����007.
-- �޿��� 12000 �̻��� ���,�̸�,�μ��ڵ�, �޿� ��ȸ 
-- *******
SELECT EID,FNAME,DID,SAL
FROM EMP
ORDER BY SAL ASC;
-- *******
-- ����008.
-- �޿��� 1500�̻� 2500���ϸ� �޴� ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ 
-- ( AND ��� )
-- *******
SELECT EID,FNAME,DID,SAL
FROM EMP
WHERE SAL >=1500 AND SAL<=2500;
-- *******
-- ����009.
-- �޿��� 1500�̻� 2500���ϸ� �޴� 
-- ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ (BETWEEN ���) 
-- *******
SELECT EID,FNAME,DID,SAL
FROM EMP
WHERE SAL BETWEEN 1500 AND 2500;
-- *******
-- ����010.
-- 2005�⵵�� �Ի��� ������ �̸��� �μ��ڵ�, 
-- �Ի����ڸ� ��ȸ
-- *******
SELECT FNAME,DID,HDATE
FROM EMP
WHERE HDATE LIKE '05%';

-- *******
-- ����011. 

-- Ŀ�̼��� ���� ���ϴ� ������ �̸�,�����ڵ�,�޿�,Ŀ�̼Ǻ����� ��ȸ
-- *******
SELECT FNAME,DID,SAL,PCT
FROM EMP
WHERE PCT IS NULL;
-- *******
-- ����012. 
-- ����� 110,120,130�� ����� ���, ��, �̸� ��ȸ
-- *******
SELECT EID,LNAME,FNAME
FROM EMP
WHERE EID IN('110','120','130');
-- *******
-- ����013. 
-- �μ��ڵ�� ��������, �޿��� ������������ 
-- �μ��ڵ�, �޿�, ���, �̸�, �� ����
-- �������� 0,1,2 ... �������� 9,8,7...
-- ******
SELECT DID,SAL,EID,LNAME
FROM EMP
ORDER BY SAL,DID DESC; 
-- *******
-- ����014. 
-- �̸��� am �̶� ���ڰ� ���Ե� ������ ���,�̸�, ��
-- *******
SELECT EID,FNAME,LNAME
FROM EMP
WHERE FNAME LIKE ('%am%');
-- *******
-- ����015. 
-- �̸��Ͽ� 'GG' �� 'KK'�δܾ� �� �ϳ��� ���ԵǾ ��ȸ
-- ��, ��ҹ��� ������
-- *******
select email
from emp
where email LIKE '%GG%' OR email like '%KK%';
-- *******
-- ����016. 
-- �̸����ּҰ� A �� �������� �ʴ� �̸��� ����
-- *******
SELECT COUNT(EMAIL)
FROM EMP
WHERE EMAIL NOT LIKE 'A%';  

-- *******
-- ����017.
-- ���� �ι�°,����° ���ڰ� ���ÿ� e �� ������ �̸�, ��
-- *******
SELECT FNAME,LNAME
FROM EMP
WHERE LNAME LIKE '_ee';
-- *******
-- ����018
 -- �����ӱ��� 10000�� �̻��� ���� �� �� ������ ǥ���Ѵ�
-- *******
SELECT TITLE
FROM JOB
WHERE MINSAL >=1000;

-- *******************
-- [����19]
-- 2002����� 2005����� 
-- ������ ������ �̸��� ���� ���ڸ� ǥ���Ѵ�.
-- ********
SELECT LNAME,HDATE
FROM EMP
WHERE HDATE BETWEEN '2002/01/01' AND '2005/12/31';
-- *******************
-- [����020]
-- IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, �����ڵ� ǥ��.
-- *******************
SELECT E.FNAME �̸�,E.HDATE �Ի���,J.JID �����ڵ�
FROM JOB J
JOIN EMP E
ON E.JID = J.JID
WHERE J.JID IN('IT_PROG','SA_MAN');