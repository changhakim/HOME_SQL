-- SOCCER_SQL_021
-- 이현 선수 소속팀의 선수명단 출력
select player_name,position,back_no
from player
where team_id like (select p1.team_id
                    from player p1
                    where p1.player_name like '이현')
ORDER BY PLAYER_NAME ASC;

-- SOCCER_SQL_022
-- NULL 처리에 있어
-- SUM(NVL(SAL,0)) 로 하지말고
-- NVL(SUM(SAL),0) 으로 해야 자원낭비가 줄어든다
 
-- 팀별 포지션별 인원수와 팀별 전체 인원수 출력
 
-- Oracle, Simple Case Expr 

SELECT TEAM_ID, NVL(SUM(CASE WHEN POSITION LIKE 'FW' THEN 1 END),0) FW,
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
        FROM PLAYER) "전체 평균"
        
 FROM PLAYER;      

-- SOCCER_SQL_024 
-- 소속팀별 키가 가장 작은 사람들의 정보

    SELECT T.TEAM_ID,T.TEAM_NAME,P.PLAYER_NAME,P.POSITION,P.BACK_NO,P.HEIGHT
    FROM TEAM T
    JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
    WHERE (T.TEAM_ID,P.HEIGHT) IN(SELECT P1.TEAM_ID,MIN(P1.HEIGHT)
                              FROM PLAYER P1
                              GROUP BY P1.TEAM_ID
                              )
    ORDER BY T.TEAM_ID,T.TEAM_NAME;                          
    
    ;
    

-- SOCCER_SQL_025 
-- K-리그 2012년 8월 경기결과와 두 팀간의 점수차를 ABS 함수를 사용하여
-- 절대값으로 출력하기
SELECT  C.SCHE_DATE,(SELECT T1.TEAM_NAME
                            FROM TEAM T1
                            WHERE T1.TEAM_ID LIKE C.HOMETEAM_ID)||'-'||(SELECT T2.TEAM_NAME
                                                                        FROM TEAM T2
                                                                        WHERE T2.TEAM_ID LIKE C.AWAYTEAM_ID) 팀들,
                                                                        HOME_SCORE||'-'||AWAY_SCORE 점수,
                                                                        (SELECT ABS(HOME_SCORE-AWAY_SCORE)
                                                                        FROM SCHEDULE C1
                                                                        WHERE (C1.HOMETEAM_ID,C1.AWAYTEAM_ID,C1.SCHE_DATE) IN
                                                                              (SELECT C.HOMETEAM_ID,C.AWAYTEAM_ID,C.SCHE_DATE
                                                                               FROM SCHEDULE))점수차
        
     FROM STADIUM S
     JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
     JOIN (SELECT SCHE_DATE,STADIUM_ID,HOMETEAM_ID,AWAYTEAM_ID,HOME_SCORE ,AWAY_SCORE
           FROM SCHEDULE
           WHERE SCHE_DATE BETWEEN 20120801 AND 20120831) C ON S.STADIUM_ID = C.STADIUM_ID
ORDER BY C.SCHE_DATE            
    ; 
    
    
 C1.HOMETEAM_ID LIKE C.HOMETEAM_ID AND C1.AWAYTEAM_ID LIKE C.AWAYTEAM_ID AND C1.SCHE_DATE LIKE C.SCHE_DATE 

-- SOCCER_SQL_026 
-- 20120501 부터 20120602 사이에 경기가 있는 경기장 조회
SELECT S.STADIUM_ID,S.STADIUM_NAME
FROM (SELECT SCHE_DATE,STADIUM_ID
      FROM SCHEDULE
      WHERE SCHE_DATE BETWEEN 20120501 AND 20120602) C
      JOIN STADIUM S ON C.STADIUM_ID LIKE S.STADIUM_ID;
-- SOCCER_SQL_027 
-- 선수정보와 해당 선수가 속한  팀의 평균키 조회
-- 단, 정렬시 평균키 내림차순
    SELECT T.TEAM_NAME 팀명,P.PLAYER_NAME 선수명,P.HEIGHT 키,(SELECT ROUND(AVG(P1.HEIGHT),3)
                                                              FROM PLAYER P1
                                                              WHERE P1.TEAM_ID LIKE P.TEAM_ID) 팀평균
                                               
    FROM TEAM T 
        JOIN (SELECT PLAYER_NAME,HEIGHT,TEAM_ID
              FROM PLAYER) P 
              ON T.TEAM_ID LIKE P.TEAM_ID
         
    ORDER BY 4 DESC
        ;    
        

    SELECT T.TEAM_NAME 팀명,P.PLAYER_NAME 선수명,P.HEIGHT 키,(SELECT ROUND(AVG(HEIGHT),3)
                                                        FROM PLAYER P1
                                                        WHERE P1.TEAM_ID LIKE T.TEAM_ID 
                                                    ) 평균키
    FROM TEAM T
    JOIN (SELECT PLAYER_NAME,HEIGHT,TEAM_ID
          FROM PLAYER) P 
          ON T.TEAM_ID = P.TEAM_ID

    ORDER BY 평균키 DESC;
--LIKE와 = 차이점 블로그에서는 =가 더빠르다고 한다
                                

-- SOCCER_SQL_028 
-- 평균키가 삼성 블루윙즈 팀이 평균키보다 작은 팀의 
-- 이름과 해당 팀의 평균키
    
    SELECT P.TEAM_ID,T.TEAM_NAME,ROUND(AVG(HEIGHT),2)
    FROM (SELECT TEAM_NAME,TEAM_ID
          FROM TEAM) T
        JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
    GROUP BY P.TEAM_ID,T.TEAM_NAME
    HAVING AVG(HEIGHT) < (SELECT AVG(P1.HEIGHT)
                            FROM TEAM T1
                            JOIN PLAYER P1 ON T1.TEAM_ID LIKE P1.TEAM_ID
                            WHERE T1.TEAM_NAME LIKE '삼성블루윙즈')
                         
    ;

SELECT AVG(HEIGHT)
FROM TEAM T
JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
WHERE TEAM_NAME LIKE '삼성블루윙즈';  

-- SOCCER_SQL_029 
-- 드래곤즈,FC서울,일화천마 각각의 팀 소속의 GK, MF 선수 정보

    SELECT T.TEAM_NAME,P.POSITION,P.BACK_NO,P.PLAYER_NAME,P.HEIGHT
    FROM (SELECT TEAM_NAME,TEAM_ID
          FROM TEAM
          WHERE TEAM_NAME IN ('드래곤즈','FC서울','일화천마')) T
          JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
    WHERE POSITION IN ('GK','MF')
    ORDER BY 1,2,3,4,5;
     
     
     
    
    

-- SOCCER_SQL_030 
-- 29번에서 제시한 팀과 포지션이 아닌 선수들의 수

 SELECT COUNT(P.PLAYER_NAME)
    FROM (SELECT TEAM_NAME,TEAM_ID
          FROM TEAM
          WHERE TEAM_NAME NOT IN ('드래곤즈','FC서울','일화천마')) T
          JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
    WHERE POSITION NOT IN ('GK','MF')
    