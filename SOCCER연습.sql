








-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력
 SELECT TEAM_NAME,STADIUM_NAME
 FROM TEAM T
      JOIN STADIUM S ON T.STADIUM_ID = S.STADIUM_ID;
-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오
SELECT TEAM_NAME,STADIUM_NAME,AWAYTEAM_ID,SCHE_DATE
FROM STADIUM S
        JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
    JOIN (SELECT SCHE_DATE,AWAYTEAM_ID,STADIUM_ID
     FROM SCHEDULE
     WHERE SCHE_DATE LIKE '20120317') C  ON C.STADIUM_ID = S.STADIUM_ID; 



-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
SELECT P.PLAYER_NAME,P.POSITION,CONCAT(T.REGION_NAME,'',T.TEAM_NAME),S.STADIUM_NAME,C.SCHE_DATE
FROM STADIUM S
        JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
    JOIN (SELECT SCHE_DATE,AWAYTEAM_ID,STADIUM_ID
     FROM SCHEDULE
     WHERE SCHE_DATE LIKE '20120317') C  ON C.STADIUM_ID = S.STADIUM_ID; 



-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
SELECT S.STADIUM_NAME,TEAM_NAME,(SELECT TEAM_NAME
                  FROM TEAM
                  WHERE TEAM_ID LIKE AWAYTEAM_ID)어웨이팀,SCHE_DATE
FROM STADIUM S
    JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
    JOIN (SELECT AWAYTEAM_ID,SCHE_DATE,STADIUM_ID
          FROM SCHEDULE
          WHERE (HOME_SCORE-AWAY_SCORE) >=3) C ON S.STADIUM_ID = C.STADIUM_ID

;                  

-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20


-- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출


-- SOCCER_SQL_017
-- 포지션이 MF 인 선수들의  소속팀명 및 선수명, 백넘버 출력


-- SOCCER_SQL_018
-- 가장 키큰 선수 5 추출, 오라클, 단 키 값이 없으면 제외

-- SOCCER_SQL_019
-- 선수 자신이 속한 팀의 평균키보다 작은 선수 정보 출력


-- SOCCER_SQL_020
-- 2012년 5월 한달간 경기가 있는 경기장 조회
-- EXISTS 쿼리는 항상 연관쿼리로 상요한다.
-- 또한 아무리 조건을 만족하는 건이 여러 건이라도
-- 조건을 만족하는 1건만 찾으면 추가적인 검색을 진행하지 않는다.




-- SOCCER_SQL_021
-- 이현 선수 소속팀의 선수명단 출력
select player_name 선수명단,position,back_no
from (select player_name,position,back_no
        from player 
        where team_id like (select team_id
                              from player
                              where player_name like '이현'))
order by player_name;






-- SOCCER_SQL_022
-- NULL 처리에 있어
-- SUM(NVL(SAL,0)) 로 하지말고
-- NVL(SUM(SAL),0) 으로 해야 자원낭비가 줄어든다
 
-- 팀별 포지션별 인원수와 팀별 전체 인원수 출력
 
-- Oracle, Simple Case Expr 

SELECT TEAM_ID,NVL(SUM(CASE WHEN POSITION LIKE 'FW' THEN 1 END),0) FW,
                    NVL(SUM(CASE WHEN POSITION LIKE 'MF' THEN 1 END),0) MF,
                     NVL(SUM(CASE WHEN POSITION LIKE 'DF' THEN 1 END),0) DF,
                      NVL(SUM(CASE WHEN POSITION LIKE 'GK' THEN 1 END),0) GK,
                      COUNT(*) SUM
FROM PLAYER
GROUP BY TEAM_ID;
                      





-- SOCCER_SQL_023
-- GROUP BY 절 없이 전체 선수들의 포지션별 평균 키 및 전체 평균 키 출력

SELECT DISTINCT (SELECT ROUND(AVG(HEIGHT),2)
       FROM PLAYER
       WHERE POSITION LIKE 'FW') FW,
       (SELECT ROUND(AVG(HEIGHT),2)
       FROM PLAYER
       WHERE POSITION LIKE 'MF') MF,
       (SELECT ROUND(AVG(HEIGHT),2)
       FROM PLAYER
       WHERE POSITION LIKE 'DF') DF,
       (SELECT ROUND(AVG(HEIGHT),2)
       FROM PLAYER
       WHERE POSITION LIKE 'GK') GK,
       (SELECT ROUND(AVG(HEIGHT),2)
       FROM PLAYER) 전체평균

FROM PLAYER
;