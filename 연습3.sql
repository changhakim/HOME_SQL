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
SELECT EID ��� ,LNAME �� ,FNAME
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
SELECT FNAME �̸�,DID �μ��ڵ�,SAL �޿�
FROM EMP
ORDER BY SAL ASC; 
-- *******
-- ����007.
-- �޿��� 12000 �̻��� ���,�̸�,�μ��ڵ�, �޿� ��ȸ 
-- *******
SELECT EID ���,FNAME �̸�,DID �μ��ڵ�,SAL �޿�
FROM EMP
WHERE SAL >= 12000;
-- *******
-- ����008.
-- �޿��� 1500�̻� 2500���ϸ� �޴� 
-- ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ (AND ���) 
-- *******
SELECT EID ���,FNAME �̸�,DID �μ��ڵ�,SAL �޿�
FROM EMP
WHERE SAL >= 1500 AND SAL <= 2500;
-- *******
-- ����009.
-- �޿��� 1500�̻� 2500���ϸ� �޴� 
-- ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ (BETWEEN ���) 
-- *******
SELECT EID ���,FNAME �̸�,DID �μ��ڵ�,SAL �޿�
FROM EMP
WHERE SAL BETWEEN 1500 AND 2500;
-- *******
-- ����010.
-- 2005�⵵�� �Ի��� ������ �̸��� �μ��ڵ�, 
-- �Ի����ڸ� ��ȸ
-- *******
SELECT * FROM EMP;
SELECT FNAME �̸�, DID �μ��ڵ�, HDATE "�Ի� ����"
FROM EMP
WHERE HDATE LIKE '05%';

