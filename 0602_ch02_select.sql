-- [II] SELECT 문 - 조회 /* 여러줄 주석 */
-- 1. SELECT 문 작성법
SHOW USER;
    -- 현재 계정(실행 : CTRL+ENTER)
SELECT * FROM TAB; -- 현 계정이 가지고있는 테이블들
SELECT * FROM EMP; -- EMP테이블의 모든 열, 모든행
SELECT * FROM DEPT; -- DEPT테이블의 모든 열, 모든행
SELECT * FROM SALGRADE;

-- 2. 특정열만 출력
DESC EMP;
    -- EMP 테이블 구조를 나타내는 ORACLE 명령
SELECT EMPNO, ENAME, SAL, JOB FROM EMP; -- 오른쪽 열들만 모든행 검색
SELECT EMPNO AS "사 번", ENAME AS "이름", SAL AS "급여", JOB AS "직책" FROM EMP;
SELECT EMPNO "사 번", ENAME "이름", SAL "급여", JOB "직책" FROM EMP;
SELECT EMPNO "사 번", ENAME 이름, SAL 급여, JOB "직책" FROM EMP;
SELECT EMPNO NO, ENAME ENAME, SAL SALARY FROM EMP;

-- 3. 특정행 출력 : WHERE절(조건절) - 비교연산자 : 같다(=), 다르다(f=, ^=, <>), >, >=, 
SELECT EMPNO NO, ENAME, SAL FROM EMP WHERE SAL=3000;
SELECT EMPNO NO, ENAME, SAL FROM EMP WHERE SAL^=3000;
SELECT EMPNO NO, ENAME, SAL FROM EMP WHERE SAL<>3000;
SELECT EMPNO NO, ENAME, SAL FROM EMP WHERE SAL!=3000;
    -- 비교연산자는 숫자, 문자, 날짜형 모두 가능
    -- EX1) 사원이름(ENAME)이 'A','B','C'로 시작하는 사원의 모든 필드
    -- 'A' < 'AA' < 'AAA' < 'AAAA' < 'B' < 'C' < 'D'
    SELECT * FROM EMP WHERE ENAME < 'D';
    -- EX2) 82년도 이전에 입사한 사원의 모든 필드
    SELECT * FROM EMP WHERE HIREDATE < '82/01/01';
    -- EX3) 부서번호(DEPTnO)가 10번인 사원의 모든 필드
    SELECT * FROM EMP WHERE DEPTNO=10;
    -- EW4) 이름(ENAME)이 FORD인 직원의 ENPNO, ENAME, MGR(상사의 사번)을 출력
    SELECT EMPNO, ENAME, MGR
        FROM ENP
        WHERE ENAME='FORD';
        -- SQL문은 대소문자 구별없음, 데이터 대소문자 구별
    select empno, ename, mgr from emp where ename='FORD';
    
-- 4. 특정행 출력 : WHERE절(조건절) - 논리연산자 : AND, OR, NOT
    -- EX1. 급여(SAL)가 2000이상 3000이하는 직원의 모든 필드
    SELECT * FROM EMP WHERE 2000<=SAL AND SAL <=3000;
    -- EX2. 82년도에 입사한 사원의 모든 필드
    SELECT * FROM EMP WHERE HIREDATE >= '82/01/01' AND HIREDATE<='82/12/31';

    -- 날짜 표기법 세팅(현재: YY/MM/DD 또는 RR/MM/DD
    ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
    ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
    SELECT * FROM EMP;
    SELECT TO_CHAR(HIREDATE, 'YY/MM/DD') FROM EMP;
    --날짜 셋팅을 고려한 02년도 입사한 사원의 모든 필드
    SELECT * FROM EMP 
        WHERE TO_CHAR(HIREDATE, 'YY/MM/DD') >= '82/01/01' AND
            TO_CHAR(HIREDATE, 'YY/MM/DD')<='82/12/31';
    -- EX3. 연봉이 2400이상인 직원의 ENAME, SAL, 연봉(SAL*12)을 출력
    SELECT ENAME, SAL, SAL*12 ANNUALSAL -- (3)
        FROM EMP    -- (1)
        WHERE SAL*12>=2400; -- (2) WHERE절에는 필드의 별칭 사용 불가
    -- EX4. 연봉이 3000 이상인 직원의 ENAME, SAL, 연봉을 연봉순으로 출력
    SELECT ENAME, SAL, SAL*12 연봉 -- (3)
        FROM EMP -- (1)
        WHERE SAL*12>3000 -- (2) WHERE절에는 필드의 별칭 사용 불가
        ORDER BY 연봉; -- (4) ORDER BY절에는 필드의 별칭 사용 가능
    -- EX5. JOB이 MANAGER거나 10번 부서(DEPTNO) 외의 직원의 모든 필드
    SELECT * FROM EMP WHERE JOB='MANAGER' OR DEPTNO!=10;
        
-- 5. 산술연산자(SELECT절, 조건절, ORDER BY절)
    -- 모든 사원의 10% 이상된 월급과 사번(EMPNO), 이름(ENAME)을 출력
    SELECT EMPNO, ENAME, SAL*1.1 FROM EMP;
    -- 모든 사원의 이름(ENAME), 월급(SAL), 상여(COMM), 연봉(SAL*12+COMM)을 출력
    SELECT ENAME, SAL, COMM, SAL*12+COMM 연봉 FROM EMP;
    -- 산술 연산의 결과는 NULL을 포함하면 결과도 NULL
    -- NVL(NULL일 수도 있는 필드명, NULL을 대체할 값)을 이용
    SELECT ENAME, SAL, COMM, NVL(COMM, 0), SAL*12+NVL(COMM, 0) 연봉 FROM EMP;
    -- 모든 사원의 사번, 이름, 상사사번(상사가 없으면 'CEO'로 출력) 출력
    SELECT EMPNO, ENAME, NVL(MGR, 'CEO') FROM EMP;
    DESC EMP;
        
-- 6. 연결연산자(||) : 필드값이나 문자를 연결
SELECT ENAME || '은' || JOB EMPLOYEE FROM EMP;

-- 7. 중복제거(DISTRICT)
SELECT DISTINCT JOB FROM EMP;
SELECT DISTINCT DEPTNO FROM EMP;

-- 연습문제 --
-- 1. emp 테이블의 구조 출력
DESC EMP;

-- 2. emp 테이블의 모든 내용을 출력 
SELECT * FROM EMP;

-- 3. 현 scott 계정에서 사용가능한 테이블 출력
SELECT 'TABLE' FROM USER_TABLE;

-- 4. emp 테이블에서 사번, 이름, 급여, 업무, 입사일 출력
SELECT EMPNO, ENAME, SAL, JOB, HIREDATE FROM EMP;

-- 5. emp 테이블에서 급여가 2000미만인 사람의 사번, 이름, 급여 출력
SELECT EMPNO, ENAME, SAL 
    FROM EMP 
    WHERE SAL < 2000;

-- 6. 입사일이 81/02 이후에 입사한 사람의 사번, 이름, 업무, 입사일 출력
SELECT EMPNO, ENAME, JOB, HIREDATE FROM EMP 
    WHERE HIREDATE >= TO_DATE('1981/02', 'YYYY/MM');

-- 7. 업무가 SALESMAN인 사람들 모든 자료 출력
SELECT * FROM EMP WHERE JOB = 'SALESMAN';

-- 8. 업무가 CLERK이 아닌 사람들 모든 자료 출력
SELECT * FROM EMP WHERE JOB != 'CLERK';

-- 9. 급여가 1500이상이고 3000이하인 사람의 사번, 이름, 급여 출력
SELECT EMPNO, ENAME, SAL FROM EMP 
    WHERE SAL BETWEEN 1500 AND 3000;

-- 10. 부서코드가 10번이거나 30번인 사람의 사번, 이름, 업무, 부서코드 출력
SELECT EMPNO, ENAME, JOB, DEPNO FROM EMP 
    WHERE DEPNO IN (10, 30);

-- 11. 업무가 SALESMAN이거나 급여가 3000이상인 사람의 사번, 이름, 업무, 부서코드 출력
SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP 
    WHERE JOB = 'SALESMAN' OR SAL >= 3000;

-- 12. 급여가 2500이상이고 업무가 MANAGER인 사람의 사번, 이름, 업무, 급여 출력
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
    WHERE SAL >= 2500 AND JOB = 'MANAGER';

-- 13. “ename은 XXX 업무이고 연봉은 XX다” 스타일로 모두 출력(연봉은 SAL*12+COMM)
-- COMM이 NULL인 경우 0으로 처리
SELECT ENAME || '은 ' || JOB || ' 업무이고 연봉은 ' || (SAL*12 + NVL(COMM, 0)) || '이다' AS "직원정보"
FROM EMP;

-- 8. SQL 연산자(BETWEEN, IN, LIKE, IS NULL)
-- (1) BETWEEN A AND B : A부터 B까지(A, B 포함)
    -- EX1. SAL이 1500이상 3000이하인 직원의 사번, 이름, 급여
    SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL>=1500 AND SAL<=3000;
    SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL BETWEEN 1500 AND 3000;
    SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL BETWEEN 3000 AND 1500; -- 불가
    -- EX2. SAL이 1500미만, 3000 초과
    SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL NOT BETWEEN 1500 AND 3000;
    SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL<1500 OR SAL>3000;
    -- EX3. 이름이 'A','B','C'로 시작하는 직원의 모든 필드
    SELECT * FROM EMP
        WHERE ENAME BETWEEN 'A' AND 'D' AND ENAME!='D'; -- A부터 D까지중에 D빼고
    -- EX4. 82년도에 입사한 직원의 모든 필드
    SELECT * FROM EMP
        WHERE TO_CHAR(HIREDATE, 'RR/MM/DD') BETWEEN '82/01/01' AND '82/12/31';
        
-- (2) IN
    -- EX. 부서번호(DEPTNO)가 10, 20, 40번인 직원의 모든 필드
    SELECT * FROM EMP WHERE DEPTNO=10 OR DEPNO=20 OR DEPNO=40;
    SELECT * FROM EMP WHERE DEPTNO IN (10, 20, 40);
    -- EX. 직책(JOB)이 MANAGER거나 ANALYST인 사원의 모든 필드
    SELECT * FROM EMP WHERE JOB IN ('MANAGER', 'ANALYST');
    
-- (3) 필드 LIKE 패턴 : %(0글자이상), _(한글자)를 포함한 패턴
    -- EX. 이름이 M으로 시작하는 사원의 모든 필드
    SELECT * FROM EMP WHERE ENAME LIKE 'M%';
    -- EX. 이름에 N이 들어가거나 JOB에 N이 들어가는 직원의 모든 필드
    SELECT * FROM EMP 
        WHERE ENAME LIKE '%N%' OR JOB LIKE '%N%';
    -- EX. 급여(SAL)가 5로 끝나는 사원의 모든 필드
    SELECT * FROM EMP WHERE SAL LIKE '%5';
    
    -- EX. 02년도에 입사한 사원의 모든 필드
    SELECT * FROM EMP WHERE HIREDATE LIKE '02/%';
    -- EX. 1월에 입사한 사원의 모든 필드
    SELECT * FROM EMP WHERE HIREDATE LIKE '__/01/__';
    
-- (4) 필드 IS NULL (해당 필드가 NULL인지 여부)
    -- EX. 상여금(COMM)을 받지않는 사원의 모든 필드
    SELECT * FROM EMP WHERE COMM=0 OR COMM IS NULL;
    -- EX. 상여금을 받는 사원의 모든 필드
    SELECT * FROM EMP WHERE COMM!=0 AND COMM IS NOT NULL;
    SELECT * FROM EMP WHERE COMM!=0 AND NOT COMM IS NULL;
    
-- 9. 정렬(오름차순, 내림차순) : ORDER BY절
SELECT * FROM EMP ORDER BY SAL; -- SAL 기준 오름차순 정렬
SELECT * FROM EMP ORDER BY SAL, ENAME; -- SAL 기준 오름차순 정렬(SAL이 같으면 ENAME 오름차순)
SELECT * FROM EMP ORDER BY SAL DESC; -- SAL 기준 내림차순 정렬
SELECT * FROM EMP ORDER BY SAL DESC, HIREDATE DESC; -- SAL 기준 내림차순(SAL이 같으면 HIREDATE 내림차순)

-- 연습문제 전 형변환 함수 : TO_CHAR, TO_DATE
-- % 날짜형(HIREDATE)을 문자형으로 변환 : TO_CHAR(날짜형 데이터, 패턴)
    -- YYYY, YY, RR : 년도 / MM 월 / DD 일 / DY 월 / DAY 월요일
    -- HH24, HH12, HH : 시간
    SELECT ENAME, TO_CHAR(HIREDATE, 'YY/MM/DD AM HH12:MI:SS') FROM EMP;
    -- 82년전에 입사한 사원의 데이터
    SELECT * FROM EMP WHERE TO CHAR(HIREDATE, 'RR/MM/DD') < '82/01/01';
    SELECT * FROM EMP WHERE HIREDATE < TO_DATE('82/01/01', 'RR/MM/DD');

-- 연습문제 --
-- 1. sal이 3000 이상
SELECT empno, ename, job, sal
FROM emp
WHERE sal >= 3000;

-- 2. empno가 7788인 사원
SELECT ename, deptno
FROM emp
WHERE empno = 7788;

-- 3. 연봉(SAL*12+COMM)이 24000 이상 (COMM이 NULL일 경우 0 처리), 급여순 정렬
SELECT empno, ename, sal
FROM emp
WHERE (sal * 12 + NVL(comm, 0)) >= 2400
ORDER BY sal DESC;

-- 4. 입사일이 1981-02-20 ~ 1981-05-01 사이, hiredate 순
SELECT ename, job, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1981-02-20', 'YYYY-MM-DD') AND TO_DATE('1981-05-01', 'YYYY-MM-DD')
ORDER BY hiredate;

-- 5. deptno가 10 또는 20, ename 순 정렬
SELECT *
FROM emp
WHERE deptno IN (10, 20)
ORDER BY ename;

-- 6. sal ≥ 1500이고 deptno가 10 또는 30, 타이틀 바꾸기
SELECT ename AS "Employee", sal AS "Monthly Salary"
FROM emp
WHERE sal >= 1500 AND deptno IN (10, 30);

-- 7. hiredate가 1982년인 사원
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') = '1982';
SELECT * FROM emp WHERE TO_CHAR(hiredate, 'YYYY') = '1982';

-- 8. 이름이 C부터 P 사이로 시작, 급여 순 정렬
SELECT ename, sal
FROM emp
WHERE ename BETWEEN 'C' AND 'P'  -- 알파벳 범위
ORDER BY ename;

-- 9. comm이 sal보다 10% 더 큰 사원
SELECT ename, sal, comm
FROM emp
WHERE comm > sal * 1.10;

-- 10. job이 CLERK 또는 ANALYST이고, sal이 1000, 3000, 5000이 아닌 사원
SELECT *
FROM emp
WHERE job IN ('CLERK', 'ANALYST')
  AND sal NOT IN (1000, 3000, 5000);

-- 11. ename에 L이 두 글자 포함되고, deptno=30 또는 mgr=7782
SELECT *
FROM emp
WHERE (LENGTH(ename) - LENGTH(REPLACE(ename, 'L', ''))) = 2
  AND (deptno = 30 OR mgr = 7782);

-- 12. 입사일이 1981년인 사번, 사원명, 입사일, 업무, 급여
SELECT empno, ename, hiredate, job, sal
FROM emp
WHERE TO_CHAR(hiredate, 'YYYY') = '1981';

-- 13. 1981년 입사자 중 SALESMAN 제외
SELECT empno, ename, hiredate, job, sal
FROM emp
WHERE TO_CHAR(hiredate, 'YYYY') = '1981'
  AND job != 'SALESMAN';

-- 14. 급여 내림차순, 급여 동일하면 입사일 오름차순
SELECT empno, ename, hiredate, job, sal
FROM emp
ORDER BY sal DESC, hiredate ASC;

-- 15. 사원명 3번째 알파벳이 'N'
SELECT empno, ename
FROM emp
WHERE SUBSTR(ename, 3, 1) = 'N';

-- 16. 이름에 'A'가 포함된 사원
SELECT empno, ename
FROM emp
WHERE ename LIKE '%A%';

-- 17. 연봉(SAL*12) ≥ 3500
SELECT empno, ename, sal * 12 AS salary
FROM emp
WHERE sal * 12 >= 3500;