








-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���
 SELECT TEAM_NAME,STADIUM_NAME
 FROM TEAM T
      JOIN STADIUM S ON T.STADIUM_ID = S.STADIUM_ID;
-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�
SELECT TEAM_NAME,STADIUM_NAME,AWAYTEAM_ID,SCHE_DATE
FROM STADIUM S
        JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
    JOIN (SELECT SCHE_DATE,AWAYTEAM_ID,STADIUM_ID
     FROM SCHEDULE
     WHERE SCHE_DATE LIKE '20120317') C  ON C.STADIUM_ID = S.STADIUM_ID; 



-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
SELECT P.PLAYER_NAME,P.POSITION,CONCAT(T.REGION_NAME,'',T.TEAM_NAME),S.STADIUM_NAME,C.SCHE_DATE
FROM STADIUM S
        JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
    JOIN (SELECT SCHE_DATE,AWAYTEAM_ID,STADIUM_ID
     FROM SCHEDULE
     WHERE SCHE_DATE LIKE '20120317') C  ON C.STADIUM_ID = S.STADIUM_ID; 



-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
SELECT S.STADIUM_NAME,TEAM_NAME,(SELECT TEAM_NAME
                  FROM TEAM
                  WHERE TEAM_ID LIKE AWAYTEAM_ID)�������,SCHE_DATE
FROM STADIUM S
    JOIN TEAM T ON S.STADIUM_ID = T.STADIUM_ID
    JOIN (SELECT AWAYTEAM_ID,SCHE_DATE,STADIUM_ID
          FROM SCHEDULE
          WHERE (HOME_SCORE-AWAY_SCORE) >=3) C ON S.STADIUM_ID = C.STADIUM_ID

;                  

-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20


-- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����


-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���


-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����

-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���


-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.




-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���
select player_name �������,position,back_no
from (select player_name,position,back_no
        from player 
        where team_id like (select team_id
                              from player
                              where player_name like '����'))
order by player_name;






-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
 
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
 
-- Oracle, Simple Case Expr 

SELECT TEAM_ID,NVL(SUM(CASE WHEN POSITION LIKE 'FW' THEN 1 END),0) FW,
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
       FROM PLAYER) ��ü���

FROM PLAYER
;