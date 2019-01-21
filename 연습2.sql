-- *******
-- 문제011. 
 
-- 커미션을 받지 못하는 직원의 이름,업무코드,급여,커미션비율을 조회
-- *******
SELECT FNAME 이름,JID 업무코드,SAL 급여,PCT "커미션 비율"
FROM EMP
WHERE PCT IS NULL;
-- *******
-- 문제012. 
-- 사번이 110,120,130인 사원의 사번, 성, 이름 조회
-- *******
SELECT EID 사번, LNAME 성,FNAME 이름
FROM EMP
WHERE EID  IN('110','120','130');
-- *******
-- 문제013. 
-- 부서코드는 오름차순, 급여는 내림차순으로 
-- 부서코드, 급여, 사번, 이름, 성 정렬
-- 오름차순 0,1,2 ... 내림차순 9,8,7...
-- ******
SELECT DID 부서코드,SAL 급여,EID 사번,FNAME 이름,LNAME 성
FROM EMP
ORDER BY DID ,SAL DESC; 
-- *******
-- 문제014. 
-- 이름에 am 이란 글자가 포함된 직원의 사번,이름, 성
-- *******
SELECT EID 사번,FNAME 이름,LNAME 성
FROM EMP
WHERE FNAME LIKE '%am%';
-- *******
-- 문제015. 
-- 이메일에 'GG' 와 'KK'두단어 중 하나만 포함되어도 조회
-- 단, 대소문자 구분함
-- *******
SELECT EMAIL
FROM EMP
WHERE EMAIL LIKE '%GG%'  OR EMAIL LIKE '%KK%';

-- *******
-- 문제016. 
-- 이메일주소가 A 로 시작하지 않는 이메일 갯수
-- *******
   SELECT EMAIL
   FROM EMP
   WHERE EMAIL NOT LIKE'A%';
-- *******
-- 문제017.
-- 성의 두번째,세번째 글자가 동시에 e 인 직원의 이름, 성
-- *******
SELECT FNAME 이름,LNAME 성
FROM EMP
WHERE FNAME LIKE '_ee%';
-- *******
-- 문제018
 -- 최저임금이 10000불 이상인 업무 의 상세 내역을 표시한다
-- *******
SELECT JID,TITLE,MINSAL,MAXSAL
FROM JOB
WHERE MINSAL >= 1000;
-- *******************
-- [문제19]
-- 2002년부터 2005년까지 
-- 가입한 직원의 이름과 가입 일자를 표시한다.
-- *******************
SELECT FNAME 이름,HDATE "가입 일자"
FROM EMP
WHERE HDATE BETWEEN '2002/01/01' AND '2005/12/31';
-- *******************
-- [문제020]
-- IT Programmer 또는 Sales Man인 
-- 직원의 이름, 입사일, 업무코드 표시.
-- *******************

SELECT FNAME 이름,HDATE 입사일,JID 업무코드
FROM EMP
WHERE JID IN('IT_PROG','SA_MAN');