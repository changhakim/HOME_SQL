-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20
SELECT S.STADIUM_NAME ,S.STADIUM_ID,S.SEAT_COUNT,S.HOMETEAM_ID,T.E_TEAM_NAME
FROM  (SELECT STADIUM_NAME,HOMETEAM_ID,STADIUM_ID,SEAT_COUNT
       FROM STADIUM) S
       FULL OUTER JOIN TEAM T ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY HOMETEAM_ID;       

-- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����
SELECT T.TEAM_ID,T.TEAM_NAME,ROUND(AVG(P.HEIGHT),2) ���Ű
    FROM (SELECT HEIGHT,TEAM_ID
          FROM PLAYER) P
    JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
    GROUP BY T.TEAM_ID,T.TEAM_NAME
    HAVING ROUND(AVG(P.HEIGHT),2)<180.51 ;
    
SELECT T.TEAM_ID,T.TEAM_NAME,(SELECT ROUND(AVG(HEIGHT),2)
                              FROM PLAYER P
                              WHERE T.TEAM_ID=P.TEAM_ID) ���Ű
FROM TEAM T;
                               

    
    
-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���
SELECT POSITION ������,TEAM_NAME "�Ҽ� ����",PLAYER_NAME ������,BACK_NO ��ѹ�
FROM (SELECT POSITION,TEAM_ID,BACK_NO,PLAYER_NAME
      FROM PLAYER
      WHERE POSITION LIKE 'MF') P
            JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY ������ ;


-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����
SELECT PLAYER_NAME ������,BACK_NO ��ѹ�,POSITION ������,HEIGHT Ű
FROM (SELECT PLAYER_NAME,BACK_NO,POSITION,HEIGHT
       FROM PLAYER
       WHERE HEIGHT IS NOT NULL 
       ORDER BY HEIGHT DESC
       ) P
WHERE ROWNUM <= 5;       
       

-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���
SELECT TEAM_NAME ����,PLAYER_NAME ������,POSITION ������,BACK_NO ��ѹ�,HEIGHT Ű
FROM (SELECT PLAYER_NAME,POSITION,BACK_NO,AVG(HEIGHT) ,HEIGHT, TEAM_ID
      FROM PLAYER )P
    JOIN TEAM T ON T.TEAM_ID LIKE P.TEAM_ID
    GROUP BY T.TEAM_ID,T.TEAM_NAME,PLAYER_NAME,POSITION,BACK_NO,HEIGHT
    
     ;
      
  SELECT TEAM_NAME ����,PLAYER_NAME ������,POSITION ������,BACK_NO ��ѹ�,HEIGHT Ű   
  FROM PLAYER P    
  WHERE P.HEIGHT <= (SELECT AVG(P.HEIGHT)
      FROM TEAM
      GROUP BY TEAM_ID);
-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.

SELECT STADIUM_ID,STADIUM_NAME
FROM STADIUM S
WHERE EXISTS(SELECT 1
      FROM SCHEDULE D
      WHERE D.STADIUM_ID = S.STADIUM_ID AND D.SCHE_DATE BETWEEN '20120501' AND '20120531'
      );
      
      SELECT S.STADIUM_ID,S.STADIUM_NAME,D.SCHE_DATE
      FROM STADIUM S
      JOIN SCHEDULE D ON D.STADIUM_ID = S.STADIUM_ID;