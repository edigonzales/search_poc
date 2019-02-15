# search_poc
poc (prove of concept) for a unified search module for the gdi using good old 'sql like' functionality on postgresql

## german
Der poc soll zeigen, ob mit einer einfachen einheitlichen Lösung gute Suchresultate erziehlt werden können für die folgenden Suchobjekte:
* Adressen
* Parzellen
* beliebige weitere Objekte in Datensätzen
* Datensätze (Metasuche)

Lösungsansatz für den POC
* Eine grössere, alles umfassende Suchtabelle, in welcher die folgenden Spalten enthalten sind
  * searchtext_1: Text, welcher von der Suche durchsucht wird. Zum Beispiel einen komplette Adresse
  * searchtext_2: Für Metasuche: Suchtext zweiter Prio
  * searchtext_3: Für Metasuche: Suchtext dritter Prio
  * group: Gruppe, zu welcher eine Zeile gehört. Zum Beispiel 'ch.so.agi.adressen' für Adressen
  * displaytext: Text, welcher für dieses Objekt als Suchresultat angezeigt werden soll
* Pro Such-token werden drei queries abgesetzt (auf searchtext_1, searchtext_2, searchtext_3). Diese werden gewichtet mit einem union all verknüpft.
* Bei Vorliegen mehrerer Such-Token werden die like-queries mit AND verknüpft.

Anforderungen:
* Gute Suchresultate
  * Treffend auf die Suchanfrage
  * Unnötigen Treffer werden nicht angezeigt
* Eine Suche mit drei Tokens darf nicht länger als 0.5 Sekunden dauern, bis die Resultate angezeigt werden.


## Fehlende Anbindung an GDI
Falls zum Ausprobieren die GDI-Datenbanken nicht zur Verfügung stehen, kann die z.B. die Pub-DB einfach in eine Vagrant-Box importiert werden. Die Datenbank wird in diesem Fall auch gleich für die neue "Gott"-Suchtabelle verwendet. (Kann bisschen fricklig sein mit den Dumps, falls unterschiedliche DB-Versionen.)

```
vagrant ssh
sudo su postgres
psql -d postgres -f globals_geodb.rootso.org.dmp
pg_restore --role=postgres --exit-on-error -d pub pub_geodb.rootso.org.dmp
```

`build.gradle` angepasst, damit es ohne Docker-Gretl-Image funktioniert.

```
gradle createTable loadData setupSearchFunc
```
