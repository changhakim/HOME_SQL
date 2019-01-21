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

DESC JOB_HISTORY
CREATE VIEW HIS AS
SELECT
EMPLOYEE_ID EID,
START_DATE SDATE,
END_DATE EDATE,
JOB_ID JID,
DEPARTMENT_ID DID
FROM JOB_HISTORY;

DESC DEPARTMENTS;
CREATE VIEW DEP AS
SELECT
DEPARTMENT_ID DID,
DEPARTMENT_NAME DNAME,
MANAGER_ID MID,
LOCATION_ID LID
FROM DEPARTMENTS;

DESC LOCATIONS
CREATE VIEW LOC AS
SELECT
LOCATION_ID LID,
STREET_ADDRESS ADDRESS,
POSTAL_CODE PCODE,
CITY,
STATE_PROVINCE STATE,
COUNTRY_ID CID
FROM LOCATIONS;
SELECT*FROM EMP;
SELECT*FROM DEP;
-- *******************
-- [����021]
-- JOB_TITLE �� "Programmer" �Ǵ� "Sales Manager"�� 
-- ������ �̸�, �Ի���, ������ ǥ��.
-- ������ �̸��� ������������ �����Ͻÿ�
-- *******************
SELECT E.FNAME,E.HDATE,J.TITLE
FROM EMP E
JOIN JOB J ON J.JID LIKE E.JID
WHERE J.TITLE IN('Programmer','Sales Manager')
ORDER BY E.FNAME;
-- *******************
-- [����022]
-- �μ��� �� �������̸� ǥ��
-- (��, �÷����� ������ [����] �̸� �� �ǵ��� ...)
-- DEPARTMENTS ���� MANAGER_ID �� ������ �ڵ�
-- *******************  
SELECT D.DNAME �μ��� ,E.FNAME"������ �̸�"
FROM EMP E
JOIN DEP D ON D.MID LIKE E.EID;
-- *******************
-- [����023]
-- ������(Marketing) �μ����� �ٹ��ϴ� ����� 
-- ���, ��å, �̸�, �ټӱⰣ
-- (��, �ټӱⰣ�� JOB_HISTORY ���� END_DATE-START_DATE�� ���� ��)
-- EMPLOYEE_ID ���, JOB_TITLE ��å��
-- *******************  
SELECT E.EID ���, J.TITLE ��å, E.FNAME �̸�, H.EDATE - H.SDATE �ټӱⰣ
FROM HIS H
JOIN JOB J ON J.JID LIKE H.JID
JOIN EMP E ON E.EID LIKE H.EID
WHERE E.DID LIKE (SELECT D.DID 
FROM DEP D
WHERE D.DNAME LIKE 'Marketing');
-- *******************
-- [����024]
--  ��å�� "Programmer"�� ����� ������ ��� 
-- DEPARTMENT_NAME �μ���, �̸�(FIRST_NAME + [����] + LAST_NAME)���� ���
-- �̸��� �ߺ��Ǿ ��µ�. �� �Ѹ��� �����μ����� ������ ������
-- *******************  
SELECT DNAME �μ���,FNAME||''||LNAME �̸�
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
JOIN JOB J ON J.JID LIKE E.JID
WHERE J.TITLE LIKE 'Programmer';
-- *******************
-- [����025]
-- �μ���, ������ �̸�, �μ���ġ ���� ǥ��
-- �μ��� ��������
-- *******************   
SELECT D.DNAME �μ���, E.FNAME "������ �̸�", L.CITY "�μ���ġ ����"
FROM DEP D
JOIN LOC L ON D.LID LIKE L.LID
JOIN EMP E ON E.EID LIKE D.MID
ORDER BY D.DNAME; 
-- *******************
-- [����026]
--  �μ���, "�μ��� ��� �޿�" �� ����Ͻÿ�
-- ******************* 
SELECT D.DNAME �μ���, AVG(E.SAL) "�μ��� ��� �޿�"
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
GROUP BY E.DID,D.DNAME;
-- *******************
-- [����027]
-- �μ��� ��� �޿��� 10000 �� �Ѵ�
--  �μ���, "�μ��� ��� �޿�" �� ����Ͻÿ�
-- *******************  

SELECT D.DNAME �μ���, ROUND(AVG(E.SAL),2)"�μ��� ��� �޿�"
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
GROUP BY E.DID,D.DNAME
HAVING ROUND(AVG(SAL),2) >=1000;
-- *******************
-- [����029]
-- �μ����� ����ϴ� �����ڿ� ������ 
-- �ѹ����� ����Ͻÿ� (11��)
-- *********************
SELECT
    DISTINCT D.DNAME �μ�,
    E.FNAME ������,
    J.TITLE ����
FROM EMP E
    JOIN DEP D
        ON E.EID LIKE D.MID
    JOIN JOB J
        ON E.JID LIKE J.JID;



SELECT DISTINCT D.DNAME �μ���,E.FNAME ������,J.TITLE ����
FROM EMP E
JOIN DEP D ON E.EID LIKE D.MID
JOIN JOB J ON J.JID LIKE E.JID;


-- *******************
-- [����030]
-- �̹� �б⿡ IT�μ�(�μ���: IT)������ �ű� ���α׷��� �����ϰ� 
-- �����Ͽ� ȸ�翡 �����Ͽ���. 
-- �̿� �ش� �μ��� ��� �޿��� 12.3% �λ��Ͽ� �����մϴ�.
-- ������(�ݿø�) ǥ���Ͽ� ������ �ۼ��Ͻÿ�. 
-- ������ �����ȣ, ���� �̸�(�̸�), 
-- �޿�, ���� ������ ����Ͻÿ�
-- �޾��� õ��������
-- *********************
SELECT E.EID �����ȣ,D.DNAME �μ�, E.FNAME||''||E.LNAME �̸�,E.SAL �޿�, E.SAL*0.123 "���� �޿�"
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
WHERE D.DNAME LIKE 'IT';
 