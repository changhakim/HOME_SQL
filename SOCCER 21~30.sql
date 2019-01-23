-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���
select player_name,position,back_no
from player
where team_id like (select p1.team_id
                    from player p1
                    where p1.player_name like '����')
ORDER BY PLAYER_NAME ASC;

-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
 
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
 
-- Oracle, Simple Case Expr 

SELECT TEAM_ID, NVL(SUM(CASE WHEN POSITION LIKE 'FW' THEN 1 END),0) FW,
                NVL(SUM(CASE WHEN POSITION LIKE 'MF' THEN 1 END),0) MF,
                NVL(SUM(CASE WHEN POSITION LIKE 'DF' THEN 1 END),0) DF,
                NVL(SUM(CASE WHEN POSITION LIKE 'GK' THEN 1 END),0) GK,
                COUNT(*) SUM
FROM PLAYER
GROUP BY TEAM_ID;


-- SOCCER_SQL_023
-- GROUP BY �� ���� ��ü �������� �����Ǻ� ��� Ű �� ��ü ��� Ű ���
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
        FROM PLAYER) "��ü ���"
        
 FROM PLAYER;      

-- SOCCER_SQL_024 
-- �Ҽ����� Ű�� ���� ���� ������� ����

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
-- K-���� 2012�� 8�� ������� �� ������ �������� ABS �Լ��� ����Ͽ�
-- ���밪���� ����ϱ�
SELECT  C.SCHE_DATE,(SELECT T1.TEAM_NAME
                            FROM TEAM T1
                            WHERE T1.TEAM_ID LIKE C.HOMETEAM_ID)||'-'||(SELECT T2.TEAM_NAME
                                                                        FROM TEAM T2
                                                                        WHERE T2.TEAM_ID LIKE C.AWAYTEAM_ID) ����,
                                                                        HOME_SCORE||'-'||AWAY_SCORE ����,
                                                                        (SELECT ABS(HOME_SCORE-AWAY_SCORE)
                                                                        FROM SCHEDULE C1
                                                                        WHERE (C1.HOMETEAM_ID,C1.AWAYTEAM_ID,C1.SCHE_DATE) IN
                                                                              (SELECT C.HOMETEAM_ID,C.AWAYTEAM_ID,C.SCHE_DATE
                                                                               FROM SCHEDULE))������
        
     FROM STADIUM S
     JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
     JOIN (SELECT SCHE_DATE,STADIUM_ID,HOMETEAM_ID,AWAYTEAM_ID,HOME_SCORE ,AWAY_SCORE
           FROM SCHEDULE
           WHERE SCHE_DATE BETWEEN 20120801 AND 20120831) C ON S.STADIUM_ID = C.STADIUM_ID
ORDER BY C.SCHE_DATE            
    ; 
    
    
 C1.HOMETEAM_ID LIKE C.HOMETEAM_ID AND C1.AWAYTEAM_ID LIKE C.AWAYTEAM_ID AND C1.SCHE_DATE LIKE C.SCHE_DATE 

-- SOCCER_SQL_026 
-- 20120501 ���� 20120602 ���̿� ��Ⱑ �ִ� ����� ��ȸ
SELECT S.STADIUM_ID,S.STADIUM_NAME
FROM (SELECT SCHE_DATE,STADIUM_ID
      FROM SCHEDULE
      WHERE SCHE_DATE BETWEEN 20120501 AND 20120602) C
      JOIN STADIUM S ON C.STADIUM_ID LIKE S.STADIUM_ID;
-- SOCCER_SQL_027 
-- ���������� �ش� ������ ����  ���� ���Ű ��ȸ
-- ��, ���Ľ� ���Ű ��������
    SELECT T.TEAM_NAME ����,P.PLAYER_NAME ������,P.HEIGHT Ű,(SELECT ROUND(AVG(P1.HEIGHT),3)
                                                              FROM PLAYER P1
                                                              WHERE P1.TEAM_ID LIKE P.TEAM_ID) �����
                                               
    FROM TEAM T 
        JOIN (SELECT PLAYER_NAME,HEIGHT,TEAM_ID
              FROM PLAYER) P 
              ON T.TEAM_ID LIKE P.TEAM_ID
         
    ORDER BY 4 DESC
        ;    
        

    SELECT T.TEAM_NAME ����,P.PLAYER_NAME ������,P.HEIGHT Ű,(SELECT ROUND(AVG(HEIGHT),3)
                                                        FROM PLAYER P1
                                                        WHERE P1.TEAM_ID LIKE T.TEAM_ID 
                                                    ) ���Ű
    FROM TEAM T
    JOIN (SELECT PLAYER_NAME,HEIGHT,TEAM_ID
          FROM PLAYER) P 
          ON T.TEAM_ID = P.TEAM_ID

    ORDER BY ���Ű DESC;
--LIKE�� = ������ ��α׿����� =�� �������ٰ� �Ѵ�
                                

-- SOCCER_SQL_028 
-- ���Ű�� �Ｚ ������� ���� ���Ű���� ���� ���� 
-- �̸��� �ش� ���� ���Ű
    
    SELECT P.TEAM_ID,T.TEAM_NAME,ROUND(AVG(HEIGHT),2)
    FROM (SELECT TEAM_NAME,TEAM_ID
          FROM TEAM) T
        JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
    GROUP BY P.TEAM_ID,T.TEAM_NAME
    HAVING AVG(HEIGHT) < (SELECT AVG(P1.HEIGHT)
                            FROM TEAM T1
                            JOIN PLAYER P1 ON T1.TEAM_ID LIKE P1.TEAM_ID
                            WHERE T1.TEAM_NAME LIKE '�Ｚ�������')
                         
    ;

SELECT AVG(HEIGHT)
FROM TEAM T
JOIN PLAYER P ON T.TEAM_ID LIKE P.TEAM_ID
WHERE TEAM_NAME LIKE '�Ｚ�������';  

-- SOCCER_SQL_029 
-- �巡����,FC����,��ȭõ�� ������ �� �Ҽ��� GK, MF ���� ����

    SELECT T.TEAM_NAME,P.POSITION,P.BACK_NO,P.PLAYER_NAME,P.HEIGHT
    FROM (SELECT TEAM_NAME,TEAM_ID
          FROM TEAM
          WHERE TEAM_NAME IN ('�巡����','FC����','��ȭõ��')) T
          JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
    WHERE POSITION IN ('GK','MF')
    ORDER BY 1,2,3,4,5;
     
     
     
    
    

-- SOCCER_SQL_030 
-- 29������ ������ ���� �������� �ƴ� �������� ��

 SELECT COUNT(P.PLAYER_NAME)
    FROM (SELECT TEAM_NAME,TEAM_ID
          FROM TEAM
          WHERE TEAM_NAME NOT IN ('�巡����','FC����','��ȭõ��')) T
          JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
    WHERE POSITION NOT IN ('GK','MF')
    