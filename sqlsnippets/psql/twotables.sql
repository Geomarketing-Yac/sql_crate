/*
Kai-Christian Bruhn
2014
twotables.sql

vgl. http://kacebe/github.io/sql_crate/slidify/PostgreSQL-Slides/

source: http://kacebe/github.io/sql_crate/sql/psql/twotables.sql

CC0 1.0 Universal (CC0 1.0)
*/

BEGIN;

CREATE TABLE tbl_1 (id_1 serial PRIMARY KEY, feld_a1 varchar(2), feld_b1 integer NOT NULL);
CREATE TABLE tbl_2 (id_2 serial PRIMARY KEY, feld_a2 varchar(2), feld_b2 integer NOT NULL);

INSERT INTO tbl_1 (feld_a1, feld_b1) VALUES
('a', 5), ('b', 4), ('c', 3), ('b', 2), ('a', 1);

INSERT INTO tbl_2 (feld_a2, feld_b2) VALUES
('a', 1), ('b', 2), ('c', 3), ('d', 2), ('e', 1);

COMMIT;

/*
tbl_1:
 id_1 | feld_a1 | feld_b1 
------+---------+---------
    1 | a       |       5
    2 | b       |       4
    3 | c       |       3
    4 | b       |       2
    5 | a       |       1

tbl_2:
id_2 | feld_a2 | feld_b2 
------+---------+---------
    1 | a       |       1
    2 | b       |       2
    3 | c       |       3
    4 | d       |       2
    5 | e       |       1
*/

-- Einfache SELECT-Abfragen

SELECT feld_a1 FROM tbl_1;
/*
     feld_a1 
    ---------
      a
      b
      c
      b
      a
*/

SELECT DISTINCT feld_a1 FROM tbl_1;
/*
     feld_a1 
    ---------
      c
      b
      a
*/

-- Einfache SELECT-Abfragen mit SORT BY

SELECT feld_b1, feld_a1 FROM tbl_1 ORDER BY feld_b1 DESC;
/*
     feld_b1 | feld_a1 
    ---------+---------
           5 | a
           4 | b
           3 | c
           2 | b
           1 | a
*/

SELECT feld_b1, feld_a1 FROM tbl_1 ORDER BY feld_a1, feld_b1;
/*
     feld_b1 | feld_a1 
    ---------+---------
           1 | a
           5 | a
           2 | b
           4 | b
           3 | c
*/

-- SELECT-Abfragen mit WHERE-Klausel

SELECT feld_a2, feld_b2 FROM tbl_2 WHERE feld_b2>2;
/*
     feld_a2 | feld_b2 
    ---------+---------
     c       |       3
*/

SELECT feld_a2, feld_b2 FROM tbl_2 WHERE feld_a2='a';
/*
     feld_a2 | feld_b2 
    ---------+---------
     a       |       1
*/

SELECT feld_a2, feld_b2 FROM tbl_2 WHERE feld_a2='c' OR feld_b2=1;
/*
     feld_a2 | feld_b2 
    ---------+---------
     a       |       1
     c       |       3
     e       |       1
*/


-- SELECT mit LIMIT, OFFSET und FETCH

SELECT * FROM tbl_1 LIMIT 2;
/*
 id_1 | feld_a1 | feld_b1 
------+---------+---------
    1 | a       |       5
    2 | b       |       4
*/

SELECT * FROM tbl_1 LIMIT 2 OFFSET 3;
/*
 id_1 | feld_a1 | feld_b1 
------+---------+---------
    4 | b       |       2
    5 | a       |       1
*/

SELECT * FROM tbl_1 OFFSET 3 FETCH FIRST 2 ROWS ONLY; -- entspricht SQL:2008
/*
 id_1 | feld_a1 | feld_b1 
------+---------+---------
    4 | b       |       2
    5 | a       |       1
*/

-- ALIASES

SELECT id_1 AS "Schlüssel", feld_a1 AS "X", feld_b1 AS "Y" FROM tbl_1;

/*
 Schlüssel | X | Y 
-----------+---+---
         1 | a | 5
         2 | b | 4
         3 | c | 3
         4 | b | 2
         5 | a | 1
*/

SELECT apfel.feld_a1 AS "Sorte", apfel.feld_b1 AS "Anzahl"
FROM tbl_1 AS "apfel";

/*
 Sorte | Anzahl 
-------+--------
 a     |      5
 b     |      4
 c     |      3
 b     |      2
 a     |      1
*/

-- Aggregats-Funktionen

SELECT AVG(feld_b2) AS "Durchschnitt" FROM tbl_2;
/*
        Durchschnitt    
    --------------------
     1.8000000000000000   -- Rückgabewert vom Typ numeric
*/

SELECT MIN(feld_b2) AS "Minimum" FROM tbl_2;
/*
	Minimum 
	---------
       1               -- Rückgabewert entspricht Spaltentyp
*/

SELECT MAX(feld_b2) AS "Maximum" FROM tbl_2;
/*
	Maximum 
	---------
       3               -- Rückgabewert entspricht Spaltentyp
*/

-- Aggregats-Funktionen mit GROUP-Klausel

    SELECT COUNT(id_1) AS "Anzahl" FROM tbl_1;
      Anzahl 
    ------
        5                 -- Rückgabewert vom Typ bigint
	
	SELECT COUNT(id_1) AS "Anzahl", feld_a1 FROM tbl_1 GROUP BY feld_a1;
	/*
	 Anzahl | feld_a1 
    --------+---------
          1 | c
          2 | b
          2 | a
	*/

    SELECT SUM(id_1) AS "Anzahl", feld_a1 FROM tbl_1 GROUP BY feld_a1;
	/*
	 Anzahl | feld_a1 
    --------+---------
          3 | c
          6 | b
          6 | a
	*/
	
-- 

    SELECT SUM(id_1) AS "Anzahl", feld_a1 FROM tbl_1 GROUP BY feld_a1 HAVING feld_a1='a';
     /*
	 Anzahl | feld_a1 
    --------+---------
          6 | a
	*/

-- Tabellenverbünde, Kartesisches Produkt zweier Tabellen

    SELECT tbl_1.feld_a1, tbl_2.feld_a2 FROM tbl_1, tbl_2;
	/*
	 feld_a1 | feld_a2 
---------+---------
 a       | a
 a       | b
 a       | c
 a       | d
 a       | e
 b       | a
 b       | b
 b       | c
 b       | d
 b       | e
 c       | a
 c       | b
 c       | c
 c       | d
 c       | e
 b       | a
 b       | b
 b       | c
 b       | d
 b       | e
 a       | a
 a       | b
 a       | c
 a       | d
 a       | e

	*/

    SELECT tbl_1.id_1, tbl_1.feld_a1, tbl_2.id_2, tbl_2.feld_a2 FROM tbl_1, tbl_2;
	/*
	 id_1 | feld_a1 | id_2 | feld_a2 
------+---------+------+---------
    1 | a       |    1 | a
    1 | a       |    2 | b
    1 | a       |    3 | c
    1 | a       |    4 | d
    1 | a       |    5 | e
    2 | b       |    1 | a
    2 | b       |    2 | b
    2 | b       |    3 | c
    2 | b       |    4 | d
    2 | b       |    5 | e
    3 | c       |    1 | a
    3 | c       |    2 | b
    3 | c       |    3 | c
    3 | c       |    4 | d
    3 | c       |    5 | e
    4 | b       |    1 | a
    4 | b       |    2 | b
    4 | b       |    3 | c
    4 | b       |    4 | d
    4 | b       |    5 | e
    5 | a       |    1 | a
    5 | a       |    2 | b
    5 | a       |    3 | c
    5 | a       |    4 | d
    5 | a       |    5 | e
*/
	
	
-- Tabellenverbünde

	SELECT tbl_1.id_1, tbl_2.id_2, tbl_1.feld_a1, tbl_2.feld_a2  FROM tbl_1 INNER JOIN tbl_2 ON (tbl_1.feld_a1 = tbl_2.feld_a2);
	/*
	 id_1 | id_2 | feld_a1 | feld_a2 
    ------+------+---------+---------
        1 |    1 | a       | a
        5 |    1 | a       | a
        2 |    2 | b       | b
        4 |    2 | b       | b
        3 |    3 | c       | c
	*/

	SELECT tbl_1.id_1, tbl_2.id_2, tbl_1.feld_a1, tbl_2.feld_a2 FROM tbl_1 RIGHT OUTER JOIN tbl_2 ON (tbl_1.feld_a1 = tbl_2.feld_a2);
	/*
	 id_1 | id_2 | feld_a1 | feld_a2 
    ------+------+---------+---------
        1 |    1 | a       | a
        5 |    1 | a       | a
        2 |    2 | b       | b
        4 |    2 | b       | b
        3 |    3 | c       | c
          |    4 |         | d
          |    5 |         | e
	*/

	SELECT tbl_1.id_1, tbl_2.id_2, tbl_1.feld_a1, tbl_2.feld_a2 FROM tbl_1 RIGHT OUTER JOIN tbl_2 ON (tbl_1.feld_a1 = tbl_2.feld_a2) WHERE tbl_1.id_1 IS NULL;
	/*
	 id_1 | id_2 | feld_a1 | feld_a2 
    ------+------+---------+---------
          |    4 |         | d
          |    5 |         | e
	*/
	
	
	
	
	
	
	
	
	
	