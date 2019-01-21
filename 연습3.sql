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
SELECT EID 사번 ,LNAME 성 ,FNAME
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
SELECT FNAME 이름,DID 부서코드,SAL 급여
FROM EMP
ORDER BY SAL ASC; 
-- *******
-- 문제007.
-- 급여가 12000 이상인 사번,이름,부서코드, 급여 조회 
-- *******
SELECT EID 사번,FNAME 이름,DID 부서코드,SAL 급여
FROM EMP
WHERE SAL >= 12000;
-- *******
-- 문제008.
-- 급여가 1500이상 2500이하를 받는 
-- 직원의 사번,이름,부서코드, 급여 조회 (AND 사용) 
-- *******
SELECT EID 사번,FNAME 이름,DID 부서코드,SAL 급여
FROM EMP
WHERE SAL >= 1500 AND SAL <= 2500;
-- *******
-- 문제009.
-- 급여가 1500이상 2500이하를 받는 
-- 직원의 사번,이름,부서코드, 급여 조회 (BETWEEN 사용) 
-- *******
SELECT EID 사번,FNAME 이름,DID 부서코드,SAL 급여
FROM EMP
WHERE SAL BETWEEN 1500 AND 2500;
-- *******
-- 문제010.
-- 2005년도에 입사한 직원의 이름과 부서코드, 
-- 입사일자를 조회
-- *******
SELECT * FROM EMP;
SELECT FNAME 이름, DID 부서코드, HDATE "입사 일자"
FROM EMP
WHERE HDATE LIKE '05%';

