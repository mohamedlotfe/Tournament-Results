-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

--When I found database delete it immediately.
DROP DATABASE IF EXISTS tournament;

--Create Database(empty).
CREATE DATABASE tournament;

--Connect Database.
\c tournament;

--Create table for  Players.
CREATE TABLE player(
                    ID SERIAL PRIMARY KEY,
                    name text
                    );
--Create table games.
CREATE TABLE matches(
                   ID SERIAL PRIMARY KEY,
                   loser INTEGER REFERENCES player(ID),
                   winner INTEGER REFERENCES player(ID)
                   );



--  number of matches played by each player

create view Matches_players AS
    SELECT player.ID as id ,player.name as name ,COUNT(matches) as matches
    from player  LEFT OUTER JOIN matches
    on (player.ID = matches.winner) OR (player.ID = matches.loser)
    GROUP BY player.ID;


-- number of wins for each player

CREATE VIEW players_wins AS
    SELECT player.ID as id , player.name as name ,COUNT(matches) as wins
    from player  LEFT OUTER JOIN matches
    on (player.ID = matches.winner)
    GROUP BY player.ID
    ORDER BY wins DESC;


--  number of wins and matches played for each player

CREATE VIEW players_standings AS
     SELECT player.id as id, player.name as name , players_wins.wins as win ,Matches_players.matches as matches
     FROM player , players_wins , Matches_players
     WHERE player.id = players_wins.id and players_wins.id = Matches_players.id;





