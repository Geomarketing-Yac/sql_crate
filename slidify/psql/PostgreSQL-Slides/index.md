## PostgreSQL

### Einführung in die Syntax

Kai-Christian Bruhn
University of Applied Sciences Mainz
CC-BY-SA

SQL-Snippets:

https://github.com/kacebe/sql_crate/tree/master/sqlsnippets/psql/twotables.sql

HTML5-Version (created with slidify)

http://kacebe.github.io/sql_crate/slidify/psql/PostgreSQL-Slides/

---

## Handbücher

* Eisentraut, Peter, und Bernd Helmle. PostgreSQL-Administration. 2. Auflage. O?Reilly, 2010.
* Fröhlich, Lutz. PostgreSQL 9: Praxisbuch für Administratoren und Entwickler. Carl Hanser Verlag GmbH & CO. KG, 2012.
* Krosing, H. Postgresql Server Programming. [S.l.]: Packt Publishing Limited, 2013.
* Papakostas, Ioannis. Datenbankentwicklung mit PostgreSQL 9. Teia AG, 2010.
* Obe, Regina O, und Leo S Hsu. PostgreSQL: Up an Running. Beijing: O?Reilly, 2012.
* Riggs, Simon, Hannu Krosing, und Inc ebrary. PostgreSQL 9 Admin Cookbook: Over 80 Recipes to Help You Run an Efficient PostgreSQL 9. 0 Database. Birmingham: Packt Publishing, Limited, 2010.
* Scherbaum, Andreas. PostgreSQL. Datenbankpraxis für Anwender, Administratoren und Entwickler. 1., Aufl. Open Source Press, 2009.

---

## www-Ressourcen

http://www.postgresql.org

http://www.postgresonline.com/

http://www.teialehrbuch.de/Kostenlose-Kurse/Datenbankentwicklung-mit-PostgreSQL-9/index.html

http://workshop-postgresql.de/

---

## createdb: Datenbank erstellen

Erstellen einer Datenbank 'meineDB' als user (-U) 'student':

    createdb meineDB -U student

Weitere wichtige Optionen:

    -E -- Zeichenkodierung (e.g. UTF8, WIN1250, LATIN1)
    -O -- Besitzer, falls abweichend von user (e.g. "meinName")
    -T -- Template, also Vorlage. Kopie einer Bestehenden anlegen

Vollständige Dokumentation:

http://www.postgresql.org/docs/9.3/static/app-createdb.html

---

## dropdb: Datenbank löschen

Löschen der Datenbank 'meineDB'

    dropdb meineDB

mit Bestätigung:

    dropdb meineDB -i

---

## psql: Hilfe

Syntaxhilfe für das Programm psql

    psql --help

Vollständige Dokumentation:

http://www.postgresql.org/docs/9.3/static/app-psql.html

---

## psql: PostgreSQL-Version erfragen

Version des PostgreSQL-Servers abrufen

    psql -V

---

## psql: Verbindung zu Datenbank herstellen

Verbindung zu Datenbank herstellen:

    psql -d meineDB -U student

Meldet den user (-U) 'student' auf der Datenbank (-d) 'meineDB' an

Eingabeaufforderung wechselt zu:

    meineDB=#   --Weitere psql-Befehle, SQL-Statements

Beenden von psql:

    \q

---

## psql: Datenbanken anlegen (SQL)

Anlegen neuer Datenbanken während der Verbindung mit dem PostgreSQL-Server:

    meineDB=# CREATE DATABASE andereDB OWNER nutzer;

Wechseln der Datenbankverbindung

    meineDB=# \connect andereDB

---

## psql: Daten einspielen

sicherung.sql-Datei in meineDB einspielen:

    meineDB=# \i /pfad_zu_der_sql_sicherung/sicherung.sql

Unabhängig vom Betriebssystem erwartet PostgreSQL ?/?.

Mit dem Befehl \i werden sql-Dateien zeilenweise eingelesen.

Einlesen weiterer Datenformate (csv etc.):

http://www.postgresql.org/docs/9.3/static/sql-copy.html.

---

## psql: Funktionen

    meineDB=# \dg  -- Rollen auflisten
    meineDB=# \dn	-- Schemata auflisten
    meineDB=# \dp	-- Zugriffsprivilegien auflisten (entspricht \z)
    meineDB=# \dt	-- Tabellen auflisten
    meineDB=# \dv	-- Sichten auflisten
    meineDB=# \l	-- Datenbanken auflisten
    
    meineDB=# \a	-- ausgerichteter/unausgerichteter Ausgabemodus

---

## Datendefinition

Tabellen anlegen

    CREATE TABLE name (spalte1 datentyp, spalte2 datentyp, ...);

Tabelle löschen

    DROP TABLE name;
    DROP TABLE IF EXISTS name; -- Ohne Fehlermeldung

Abhängige Objekte mitlöschen (Fremdschlüsseldefinitionen, Views)

    DROP TABLE name CASCADE;

---

## PostgreSQL Datentypen (Auswahl)

    serial -- 4 Byte, 1 bis 2.147.483.647, selbstzählende ganze Zahl.
    integer -- 4 Byte, -2.147.483.648 bis +2.147.483.647
    double precision -- 8 Byte, -1E308 bis +1E308, Genauigkeit 15
    numeric / decimal (length,precision) -- variabel, (4,2 -> ##,##)
    boolean -- Bool'sche Werte, (TRUE, 't', 'y', 'on', '1')
                             -- (FALSE, 'f', 'n', 'off', '0')
    varchar(length) -- Text mit variabler Länge (1-4056 Bytes)
    char(length) -- Text mit fester Länge n (1-255 Bytes)
    text -- Variable Länge ohne Höchstgrenze
    bytea -- Binär-Strings
    money -- Währung, 8 Byte
    time -- Zeit, 8 Byte, 00:00:00:00 bis 23:59:59:99
    date -- Datum, 4 Byte, von 4713 v.u.Z. bis 32767 u.Z.

Vollständige Liste

http://www.postgresql.org/docs/9.3/static/datatype.html

---

## Constraints (Bedingungen)

Check-Constraints

    spalte datentyp CHECK -- Prüfausdruck
    spalte datentyp CHECK (x > 10),
    spalte datentyp CHECK (x < y),

NOT NULL Constraints

    spalte datentyp NOT NULL, -- Keine NULL-Werte

Kombiniert

    spalte datentyp NOT NULL CHECK (x > 10);

---

## Primärschlüssel

    CREATE TABLE name (
    spalte1 datentyp PRIMARY KEY,
    ...);
    
    CREATE TABLE name (
    spalte1 datentyp,
    spalte2 datentyp,
    ...,
    PRIMARY KEY (spalte1)
    );

---

## Fremdschlüssel

    CREATE TABLE name (
    spalte1 datentyp,
    spalte2 datentyp REFERENCES fs-tabelle (fs-spalte),
    ...
    );
    
    CREATE TABLE name (
    spalte1 datentyp,
    spalte2 datentyp,
    ...,
    FOREIGN KEY (spalte2) REFERENCES fs-tabelle (fs-spalte)
    );

---

## Indizes

Mehrdeutiger Index:

    CREATE INDEX indexname ON tabelle (spalte);

Eindeutiger Index:

    CREATE UNIQUE INDEX indexname ON tabelle (spalte);

Index löschen

    DROP INDEX indexname;

---

## ALTER TABLE I

Spalte hinzufügen:

    ALTER TABLE name ADD COLUMN spalte;

Spalte umbenennen:

    ALTER TABLE name RENAME COLUMN spalte;

Spalte löschen

    ALTER TABLE name DROP COLUMN spalte;

---

## ALTER TABLE II

Primärschlüssel hinzufügen

    ALTER TABLE name ADD PRIMARY KEY (spalte);

Fremdschlüssel hinzufügen

    ALTER TABLE name ADD CONSTRAINT constraint_name
    FOREIGN KEY (spalte) REFERENCES fs-tabelle (fs-spalte);

---

## Dateneingabe

Einen Datensatz:

    INSERT INTO name (spalte1, spalte2) VALUES ('wert1', wert2);

Mehrere Datensätze

    INSERT INTO name (spalte1, spalte2) VALUES
    ('wert1', wert2),
    ('wert3', wert4); 

---

## SQL: Abfragen

Aufbau eines SELECT-Statements

    SELECT      -- Spaltenliste
    
    FROM        -- Tabellenname
    
    [WHERE]     -- Auswahl
    
    [GROUP BY]  -- Gruppierung
    [HAVING]    -- Auswahl in Gruppierung
    
    [ORDER BY]  -- Sortierung;

--- &twocol

## Beispieldaten



*** =left

    SELECT * FROM tbl_1;
    
    id_1 | feld_a1 | feld_b1 
    -----+---------+---------
       1 | a       |       5
       2 | b       |       4
       3 | c       |       3
       4 | b       |       2
       5 | a       |       1

*** =right

    SELECT * FROM tbl_2;
    
    id_2 | feld_a2 | feld_b2
    -----+---------+---------
       1 | a       |       1
       2 | b       |       2
       3 | c       |       3
       4 | d       |       2
       5 | e       |       1

---

## Einfache SELECT-Abfragen

    SELECT feld_a1 FROM tbl_1;
     feld_a1 
    ---------
      a
      b
      c
      b
      a
    
Reduktion auf eindeutige Werte mit DISTINCT
    
    SELECT DISTINCT feld_a1 FROM tbl_1;
     feld_a1 
    ---------
      c
      b
      a
    
Wichtig: DISTINCT ist keine Aggregation. Die ganze Tabelle wird ausgelesen, es findet keine Gruppierung statt.

---

## Einfache SELECT-Abfragen mit SORT BY

    SELECT feld_b1, feld_a1 FROM tbl_1 ORDER BY feld_b1 DESC;
    
    feld_b1 | feld_a1 
    --------+---------
          5 | a
          4 | b
          3 | c
          2 | b
          1 | a

    SELECT feld_b1, feld_a1 FROM tbl_1 ORDER BY feld_a1, feld_b1;
    
    feld_b1 | feld_a1 
    --------+---------
          1 | a
          5 | a
          2 | b
          4 | b
          3 | c

---

## SELECT-Abfragen mit WHERE-Klausel

    SELECT feld_a2, feld_b2 FROM tbl_2 WHERE feld_b2>2;
    
    feld_a2 | feld_b2
    --------+---------
    c       |       3

    SELECT feld_a2, feld_b2 FROM tbl_2 WHERE feld_a2='a';
    
    feld_a2 | feld_b2
    --------+---------
    a       |       1

    SELECT feld_a2, feld_b2 FROM tbl_2 WHERE feld_a2='c' OR feld_b2=1;
    
    feld_a2 | feld_b2 
    --------+---------
    a       |       1
    c       |       3
    e       |       1

---

## SELECT mit LIMIT und OFFSET

    SELECT * FROM tbl_1 LIMIT 2;
    
     id_1 | feld_a1 | feld_b1 
    ------+---------+---------
        1 | a       |       5
        2 | b       |       4
    
    SELECT * FROM tbl_1 LIMIT 2 OFFSET 3;
    
     id_1 | feld_a1 | feld_b1 
    ------+---------+---------
        4 | b       |       2
        5 | a       |       1

---

## SELECT mit ALIASES

    SELECT id_1 AS "Schlüssel", feld_a1 AS "X", feld_b1 AS "Y"
    FROM tbl_1;

     Schlüssel | X | Y 
     ----------+---+---
             1 | a | 5
             2 | b | 4
             3 | c | 3
             4 | b | 2
             5 | a | 1
    
    SELECT apfel.feld_a1 AS "Sorte", apfel.feld_b1 AS "Anzahl"
    FROM tbl_1 AS "apfel";
    
     Sorte | Anzahl 
    -------+--------
     a     |      5
     b     |      4
     c     |      3
     b     |      2
     a     |      1

---

## Aggregats-Funktionen

    SELECT AVG(feld_b2) AS "Durchschnitt" FROM tbl_2;
      Durchschnitt    
    --------------------
     1.8000000000000000   -- Rückgabewert vom Typ numeric

    SELECT MIN(feld_b2) AS "Minimum" FROM tbl_2;
      Minimum 
    ---------
         1                -- Rückgabewert entspricht Spaltentyp

    SELECT MAX(feld_b2) AS "Maximum" FROM tbl_2;
      Maximum 
    ---------
         3                -- Rückgabewert entspricht Spaltentyp

Ausführliche Dokumentation und weitere Funktionen:

http://www.postgresql.org/docs/9.3/static/functions-aggregate.html

---

## Aggregats-Funktionen mit GROUP-Klausel

    SELECT COUNT(id_2) AS "Anzahl" FROM tbl_2;
     Anzahl 
    --------
          5             -- Rückgabewert vom Typ bigint
    
    SELECT COUNT(id_1) AS "Anzahl", feld_a1 FROM tbl_1 GROUP BY feld_a1;
     Anzahl | feld_a1 
    --------+---------
          1 | c
          2 | b
          2 | a
    
    SELECT SUM(id_1) AS "Anzahl", feld_a1 FROM tbl_1 GROUP BY feld_a1;
     Anzahl | feld_a1 
    --------+---------
          3 | c
          6 | b
          6 | a

---

## GROUP-BY und HAVING

Filtern von Aggregaten (nicht mehr WHERE-Klausel!)

    SELECT SUM(id_1) AS "Anzahl", feld_a1 FROM tbl_1
    GROUP BY feld_a1
    HAVING feld_a1='a';
    
     Anzahl | feld_a1 
    --------+---------
          6 | a

---

## Tabellenverbünde

<center><img src="http://www.codeproject.com/KB/database/Visual_SQL_Joins/Visual_SQL_JOINS_orig.jpg" alt="C.L. Moffat licensed under The Code Project Open License (CPOL)" width=600px) />

http://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins

---

## Tabellenverbünde

Kartesisches Produkt:

Menge aller geordneten Paare von Elementen zweier Mengen

    SELECT tbl_1.feld_a1, tbl_2.feld_a2 FROM tbl_1, tbl_2;
    
     feld_a1 | feld_a2 
    ---------+---------
     a       | a
     a       | b
     a       | c
     a       | d
     a       | e
     b       | a
    ... etc.

Das Statement gibt 25 Datensätze zurück - zuviel für die Folie...

---

## Es gilt

    SELECT ... FROM tbl_1, tbl_2;

entspricht:

    SELECT ... FROM tbl_1 CROSS JOIN tbl_2;

entspricht:

    SELECT ... FROM tbl_1 INNER JOIN tbl_2 ON (Ausdruck=TRUE);.

---

## INNER JOIN

    SELECT tbl_1.id_1, tbl_2.id_2, tbl_1.feld_a1, tbl_2.feld_a2
    FROM tbl_1 INNER JOIN tbl_2
    ON (tbl_1.feld_a1 = tbl_2.feld_a2);
     
     id_1 | id_2 | feld_a1 | feld_a2 
    ------+------+---------+---------
        1 |    1 | a       | a
        5 |    1 | a       | a
        2 |    2 | b       | b
        4 |    2 | b       | b
        3 |    3 | c       | c

---

## RIGHT OUTER JOIN inklusiv

    SELECT tbl_1.id_1, tbl_2.id_2, tbl_1.feld_a1, tbl_2.feld_a
    FROM tbl_1 RIGHT OUTER JOIN tbl_2
    ON (tbl_1.feld_a1 = tbl_2.feld_a2);
     
     id_1 | id_2 | feld_a1 | feld_a2 
    ------+------+---------+---------
        1 |    1 | a       | a
        5 |    1 | a       | a
        2 |    2 | b       | b
        4 |    2 | b       | b
        3 |    3 | c       | c
          |    4 |         | d
          |    5 |         | e

---

## RIGHT OUTER JOIN exklusiv

    SELECT tbl_1.id_1, tbl_2.id_2, tbl_1.feld_a1, tbl_2.feld_a2
    FROM tbl_1 RIGHT OUTER JOIN tbl_2
    ON (tbl_1.feld_a1 = tbl_2.feld_a2)
    WHERE tbl_1.id_1 IS NULL;
    
    id_1 | id_2 | feld_a1 | feld_a2 
    ------+------+---------+---------
         |    4 |         | d
         |    5 |         | e

Alles weitere zu JOINS in PostgreSQL:

http://www.postgresql.org/docs/9.3/static/queries-table-expressions.html

---

## Sichten

    CREATE VIEW
    
    DROP VIEW

---

## Benutzer anlegen und löschen

Nutzer mit Passwort anlegen

    CREATE USER nutzer PASSWORD 'passwort';

Nutzer löschen

    DROP USER nutzer;

Mit Bestätigung

    DROP USER nutzer -i;

---

## Rechte ändern

Passwort für user 'nutzer' ändern:

    ALTER USER nutzer WITH PASSWORD 'passwort';

Enddatum für user 'nutzer' setzen

    ALTER USER nutzer VALID UNTIL 'DEC 31 2014';

User 'nutzer' erlauben, weitere User und Datenbanken anlegen 

    ALTER USER nutzer CREATEUSER CREATEDB;

User 'nutzer' verbieten, weitere User und Datenbanken anlegen

    ALTER USER nutzer NOCREATEUSER NOCREATEDB;

---

## Rollen anlegen und löschen

Rolle mit Namen und Passwort anlegen:

    CREATE ROLE rolle LOGIN PASSWORD 'passwort';

Rolle anlegen, die Datenbanken und Rollen anlegen kann:

    CREATE ROLE rolle WITH CREATEDB CREATEROLE;



---

## Rollen ändern
