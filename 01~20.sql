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
-- 문제001. 
-- HR 스키마 테이블을 모두 출력?
-- *******
SELECT * FROM TAB;
-- *******
-- 문제002. 
-- HR 스키마 테이블 수는 몇개?
-- *******
SELECT COUNT(*) FROM TAB;
-- *******
-- 문제003. 
-- 사번, 성, 이름출력?
-- *******
SELECT EID,LNAME,FNAME
FROM EMP;

-- *******
-- 문제004. 
-- 이름이 s로 끝나는 직원의 이름 출력?
-- *******
SELECT FNAME
FROM EMP
WHERE FNAME LIKE '%s';
-- *******
-- 문제005. 
-- 이름이 s로 시작하는 직원의 이름 출력?
-- *******
SELECT FNAME
FROM EMP
WHERE FNAME LIKE 'S%';
-- *******
-- 문제006. 
-- 급여가 많은 순으로 이름,부서코드,급여 조회 
-- *******
 SELECT FNAME,DID,SAL
 FROM EMP
 ORDER BY SAL DESC;

-- *******
-- 문제007.
-- 급여가 12000 이상인 사번,이름,부서코드, 급여 조회 
-- *******
SELECT EID,FNAME,DID,SAL
FROM EMP
ORDER BY SAL ASC;
-- *******
-- 문제008.
-- 급여가 1500이상 2500이하를 받는 직원의 사번,이름,부서코드, 급여 조회 
-- ( AND 사용 )
-- *******
SELECT EID,FNAME,DID,SAL
FROM EMP
WHERE SAL >=1500 AND SAL<=2500;
-- *******
-- 문제009.
-- 급여가 1500이상 2500이하를 받는 
-- 직원의 사번,이름,부서코드, 급여 조회 (BETWEEN 사용) 
-- *******
SELECT EID,FNAME,DID,SAL
FROM EMP
WHERE SAL BETWEEN 1500 AND 2500;
-- *******
-- 문제010.
-- 2005년도에 입사한 직원의 이름과 부서코드, 
-- 입사일자를 조회
-- *******
SELECT FNAME,DID,HDATE
FROM EMP
WHERE HDATE LIKE '05%';

-- *******
-- 문제011. 

-- 커미션을 받지 못하는 직원의 이름,업무코드,급여,커미션비율을 조회
-- *******
SELECT FNAME,DID,SAL,PCT
FROM EMP
WHERE PCT IS NULL;
-- *******
-- 문제012. 
-- 사번이 110,120,130인 사원의 사번, 성, 이름 조회
-- *******
SELECT EID,LNAME,FNAME
FROM EMP
WHERE EID IN('110','120','130');
-- *******
-- 문제013. 
-- 부서코드는 오름차순, 급여는 내림차순으로 
-- 부서코드, 급여, 사번, 이름, 성 정렬
-- 오름차순 0,1,2 ... 내림차순 9,8,7...
-- ******
SELECT DID,SAL,EID,LNAME
FROM EMP
ORDER BY SAL,DID DESC; 
-- *******
-- 문제014. 
-- 이름에 am 이란 글자가 포함된 직원의 사번,이름, 성
-- *******
SELECT EID,FNAME,LNAME
FROM EMP
WHERE FNAME LIKE ('%am%');
-- *******
-- 문제015. 
-- 이메일에 'GG' 와 'KK'두단어 중 하나만 포함되어도 조회
-- 단, 대소문자 구분함
-- *******
select email
from emp
where email LIKE '%GG%' OR email like '%KK%';
-- *******
-- 문제016. 
-- 이메일주소가 A 로 시작하지 않는 이메일 갯수
-- *******
SELECT COUNT(EMAIL)
FROM EMP
WHERE EMAIL NOT LIKE 'A%';  

-- *******
-- 문제017.
-- 성의 두번째,세번째 글자가 동시에 e 인 직원의 이름, 성
-- *******
SELECT FNAME,LNAME
FROM EMP
WHERE LNAME LIKE '_ee';
-- *******
-- 문제018
 -- 최저임금이 10000불 이상인 업무 의 상세 내역을 표시한다
-- *******
SELECT TITLE
FROM JOB
WHERE MINSAL >=1000;

-- *******************
-- [문제19]
-- 2002년부터 2005년까지 
-- 가입한 직원의 이름과 가입 일자를 표시한다.
-- ********
SELECT LNAME,HDATE
FROM EMP
WHERE HDATE BETWEEN '2002/01/01' AND '2005/12/31';
-- *******************
-- [문제020]
-- IT Programmer 또는 Sales Man인 
-- 직원의 이름, 입사일, 업무코드 표시.
-- *******************
SELECT E.FNAME 이름,E.HDATE 입사일,J.JID 업무코드
FROM JOB J
JOIN EMP E
ON E.JID = J.JID
WHERE J.JID IN('IT_PROG','SA_MAN');