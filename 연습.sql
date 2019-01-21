
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
SELECT * FROM JOB;
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
WHERE TITLE IN('Programmer','Sales Manager')
ORDER BY  FNAME ; 
-- *******************
-- [����022]
-- �μ��� �� �������̸� ǥ��
-- (��, �÷����� ������ [����] �̸� �� �ǵ��� ...)
-- DEPARTMENTS ���� MANAGER_ID �� ������ �ڵ�
-- *******************  
SELECT D.DNAME �μ���,E.FNAME "������ �̸�"
FROM EMP E
JOIN DEP D ON D.MID LIKE E.EID;
 
-- *******************
-- [����023]
-- ������(Marketing) �μ����� �ٹ��ϴ� ����� 
-- ���, ��å, �̸�, �ټӱⰣ
-- (��, �ټӱⰣ�� JOB_HISTORY ���� END_DATE-START_DATE�� ���� ��)
-- EMPLOYEE_ID ���, JOB_TITLE ��å��
-- *******************  
SELECT E.EID,J.TITLE,E.FNAME,H.SDATE||'~'||H.EDATE "�ټ� �Ⱓ"
FROM HIS H
JOIN EMP E ON E.EID LIKE H.EID
JOIN JOB J ON J.JID LIKE E.JID
WHERE E.DID LIKE (SELECT D.DID
FROM DEP D
WHERE D.DNAME LIKE 'Marketing');


-- *******************
-- [����024]
--  ��å�� "Programmer"�� ����� ������ ��� 
-- DEPARTMENT_NAME �μ���, �̸�(FIRST_NAME + [����] + LAST_NAME)���� ���
-- �̸��� �ߺ��Ǿ ��µ�. �� �Ѹ��� �����μ����� ������ ������
-- *******************  
SELECT D.DNAME �μ���,E.FNAME||''||E.LNAME �̸�
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
WHERE E.JID LIKE (SELECT J.JID
                  FROM JOB J
                  WHERE J.TITLE LIKE 'Programmer');
-- *******************
-- [����025]
-- �μ���, ������ �̸�, �μ���ġ ���� ǥ��
-- �μ��� ��������
-- *******************    
SELECT D.DNAME �μ���,E.FNAME ������,L.CITY "�μ���ġ ����"
FROM DEP D
JOIN LOC L ON L.LID LIKE D.LID
JOIN EMP E ON D.MID LIKE E.EID
ORDER BY D.DNAME ;
-- *******************
-- [����026]
--  �μ���, "�μ��� ��� �޿�" �� ����Ͻÿ�
-- *******************    
SELECT D.DNAME �μ���,ROUND(AVG(E.SAL),2) "��� �޿�"
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID 
GROUP BY D.DID,D.DNAME;
-- *******************
-- [����027]
-- �μ��� ��� �޿��� 10000 �� �Ѵ�
--  �μ���, "�μ��� ��� �޿�" �� ����Ͻÿ�
-- *******************  
SELECT D.DNAME �μ���,ROUND(AVG(E.SAL),2) "��� �޿�"
FROM EMP E
JOIN DEP D ON E.DID LIKE D.DID
GROUP BY D.DNAME,D.DID
HAVING ROUND(AVG(E.SAL),2) >= 1000;
-- *******************
-- [����028]
-- ���� �������� 10% �λ�� �޾��� ���� ��������
-- å���Ǿ����ϴ�. ���� ������� ����޿���
-- ����ϼ���.
-- ��, ���� = �޿� * 12 �Դϴ�
-- *********************
SELECT E.FNAME �̸�,E.SAL �޿�,((((E.SAL*12)*0.1)+E.SAL*12)/12) "���� �޿�"
FROM EMP E;
-- *******************
-- [����029]
-- �μ����� ����ϴ� �����ڿ� ������ 
-- �ѹ����� ����Ͻÿ� (20��)
-- *********************
SELECT DISTINCT D.DNAME,E.FNAME,J.TITLE
FROM EMP E
JOIN JOB J ON J.JID LIKE E.JID
JOIN DEP D ON D.MID LIKE E.EID;



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