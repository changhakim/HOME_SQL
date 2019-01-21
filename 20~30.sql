-- Employees 테이블
--[ employee_id = 사번 ] [ first_name = 이름 ] 
--[ last_name = 성 ] [ email = 이메일 ] 
--[ phone_number = 전화번호 ] [ hire_date = 입사일 ]
--[ job_id = 업무코드 ] [ salary = 급여]
--[ commission_pct = 커미션비율 ] [ manager_id = 매니저아이디]
--[ department_id = 부서코드]
--  Jobs 테이블
-- job_id 업무코드
-- job_title 업무타이틀
-- min_salary  최저급여
-- max_salary 최고급여

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
-- [문제021]
-- JOB_TITLE 가 "Programmer" 또는 "Sales Manager"인 
-- 직원의 이름, 입사일, 업무명 표시.
-- 직원의 이름을 오름차순으로 정렬하시오
-- *******************
SELECT E.FNAME,E.HDATE,J.TITLE
FROM EMP E
JOIN JOB J ON J.JID LIKE E.JID
WHERE J.TITLE IN('Programmer','Sales Manager')
ORDER BY E.FNAME;
-- *******************
-- [문제022]
-- 부서명 및 관리자이름 표시
-- (단, 컬럼명은 관리자 [공백] 이름 이 되도록 ...)
-- DEPARTMENTS 에서 MANAGER_ID 가 관리자 코드
-- *******************  
SELECT D.DNAME 부서명 ,E.FNAME"관리자 이름"
FROM EMP E
JOIN DEP D ON D.MID LIKE E.EID;
-- *******************
-- [문제023]
-- 마케팅(Marketing) 부서에서 근무하는 사원의 
-- 사번, 직책, 이름, 근속기간
-- (단, 근속기간은 JOB_HISTORY 에서 END_DATE-START_DATE로 구할 것)
-- EMPLOYEE_ID 사번, JOB_TITLE 직책임
-- *******************  
SELECT E.EID 사번, J.TITLE 직책, E.FNAME 이름, H.EDATE - H.SDATE 근속기간
FROM HIS H
JOIN JOB J ON J.JID LIKE H.JID
JOIN EMP E ON E.EID LIKE H.EID
WHERE E.DID LIKE (SELECT D.DID 
FROM DEP D
WHERE D.DNAME LIKE 'Marketing');
-- *******************
-- [문제024]
--  직책이 "Programmer"인 사원의 정보를 출력 
-- DEPARTMENT_NAME 부서명, 이름(FIRST_NAME + [공백] + LAST_NAME)까지 출력
-- 이름은 중복되어서 출력됨. 즉 한명이 여러부서에서 업무를 수행함
-- *******************  
SELECT DNAME 부서명,FNAME||''||LNAME 이름
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
JOIN JOB J ON J.JID LIKE E.JID
WHERE J.TITLE LIKE 'Programmer';
-- *******************
-- [문제025]
-- 부서명, 관리자 이름, 부서위치 도시 표시
-- 부서명 오름차순
-- *******************   
SELECT D.DNAME 부서명, E.FNAME "관리자 이름", L.CITY "부서위치 도시"
FROM DEP D
JOIN LOC L ON D.LID LIKE L.LID
JOIN EMP E ON E.EID LIKE D.MID
ORDER BY D.DNAME; 
-- *******************
-- [문제026]
--  부서명, "부서별 평균 급여" 를 출력하시오
-- ******************* 
SELECT D.DNAME 부서명, AVG(E.SAL) "부서별 평균 급여"
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
GROUP BY E.DID,D.DNAME;
-- *******************
-- [문제027]
-- 부서별 평균 급여가 10000 이 넘는
--  부서명, "부서별 평균 급여" 를 출력하시오
-- *******************  

SELECT D.DNAME 부서명, ROUND(AVG(E.SAL),2)"부서별 평균 급여"
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
GROUP BY E.DID,D.DNAME
HAVING ROUND(AVG(SAL),2) >=1000;
-- *******************
-- [문제029]
-- 부서별로 담당하는 관리자와 업무를 
-- 한번씩만 출력하시오 (11행)
-- *********************
SELECT
    DISTINCT D.DNAME 부서,
    E.FNAME 관리자,
    J.TITLE 업무
FROM EMP E
    JOIN DEP D
        ON E.EID LIKE D.MID
    JOIN JOB J
        ON E.JID LIKE J.JID;



SELECT DISTINCT D.DNAME 부서명,E.FNAME 관리자,J.TITLE 업무
FROM EMP E
JOIN DEP D ON E.EID LIKE D.MID
JOIN JOB J ON J.JID LIKE E.JID;


-- *******************
-- [문제030]
-- 이번 분기에 IT부서(부서명: IT)에서는 신규 프로그램을 개발하고 
-- 보급하여 회사에 공헌하였다. 
-- 이에 해당 부서의 사원 급여를 12.3% 인상하여 지급합니다.
-- 정수만(반올림) 표시하여 보고서를 작성하시오. 
-- 보고서는 사원번호, 성과 이름(이름), 
-- 급여, 내년 순으로 출력하시오
-- 급액은 천원단위임
-- *********************
SELECT E.EID 사원번호,D.DNAME 부서, E.FNAME||''||E.LNAME 이름,E.SAL 급여, E.SAL*0.123 "내년 급여"
FROM EMP E
JOIN DEP D ON D.DID LIKE E.DID
WHERE D.DNAME LIKE 'IT';
 