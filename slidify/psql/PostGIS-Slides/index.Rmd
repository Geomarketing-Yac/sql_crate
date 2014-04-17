---
title       : PostGIS
subtitle    : Einführung in die Syntax
author      : Kai-Christian Bruhn
job         : University of Applied Sciences Mainz
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
license: by-sa

---

## Handbücher



---

## www-Ressourcen

http://postgis.net/

http://postgis.org/

---

## psql: PostGIS-Datenbank anlegen

Anlegen einer Geodatenbank (PostgreSQL mit Erweiterung PostGIS)-  
 Vorausgesetzt wird der user 'student'

Ab PostgreSQL 9.1 ff. | PostGIS 2.0 ff.

mit createdb die Datenbank anlegen:

    createdb meineDB -U student -O "postgres"

anschließend mit psql die Erweiterung 'postgis' laden

    psql -d meineDB -c "CREATE EXTENSION postgis;"

Frühere Versionen von PostgreSQL und PostGIS arbeiten mit einem 'template_postgis'

    createdb meineDB -T "template_postgis"
