# LernMoment im Docker Container - Die `--rm` Option für `docker* run`

Hier findest du den Quellcode zum [entsprechenden Artikel](http://www.lernmoment.de/docker/die-rm-option-fuer-docker-run/) auf [LernMoment.de](http://www.lernmoment.de).

> Dieser LernMoment wird veröffentlicht am ???

## Einige Beispiele für die Verwendung der `--rm` Option

### Einfaches `docker run`

Wenn du folgendes Kommando ausführst, wirst du mit `docker ps -a` sehen, dass ein neuer Container erstellt wurde und das er den Status `Exited` hat:

```
docker run debian:jessie
```

Nachdem du das Kommando um die Option `--rm` erweitert hast, wirst du keinen neuen Container in der Ausgabe von `docker ps -a` entdecken. Also schnell einmal ausprobieren:

```
docker ps -a
docker run --rm debian:jessie
docker ps -a
```

### `docker run` mit Fehler beim starten des Containers

Nun kannst du auch ausprobieren, was passiert, wenn dein Container nicht richtig gestartet werden kann:

```
docker run --rm --name=run--rm-option --link bla:bla debian:jessie
```

Nun wieder `docker ps -a` und du siehst einen Container mit dem Namen `run--rm-option`. Dieser hat keinen Status, er wurde aber auch nicht entfernt. Du kannst ihn mit `docker rm run--rm-option` selber entfernen.

### `docker-compose run` hat die Option auch!

Das Beispiel für `docker-compose` ist ein wenig komplizierter. Es geht darum, dass in einem Container ein einfaches Setup (msi) für Windows erstellt werden soll. Dazu wird neben dem Wix-Toolset auch Wine benutzt. Wenn alles richtig läuft, hast du nach dem ausführen des folgenden Befehls sowohl eine MSI-Datei wie auch eine Log-Datei:

```
docker-compose run --rm Wix /bin/bash beispiel-projekt-erstellen.sh
```

Mit `docker-compose run` kannst du einen bestimmten Service starten der im `docker-compose.yml` definiert ist. Dabei achtet `docker-compose` darauf, dass alle abhängigen Container auch gleich mit gestartet werden. Anhand von diesem Beispiel ist gut zusehen, dass Container die als daemon (also detached) laufen, nicht von `--rm` beeinflusst werden. Denn obwohl insgesamt 3 Container gestartet werden, wird nur 1 Container entfernt.

Dabei kannst du noch einen weiteren Punkt beobachten. Denn obwohl der Container `DisplayServerData` im Status `Exited` ist, wird er nicht gelöscht. Das ist natürlich richtig so, weil im `docker-compose.yml` eine Abhängigkeit zwischen `DisplayServer` und `DisplayServerData` definiert ist.

Um nun auch diese beiden Container zu löschen musst du erst den noch laufenden Container stoppen und dann können beide gelöscht werden. `docker-compose` hilft dir dabei:

```
docker-compose stop
docker-compose rm
```

Nun bist du alle Container wieder los.

Wenn du mit dem erstellen des MSI noch ein wenig rum spielen willst, dann kannst du auch die Container so starten:

```
docker-compose run --rm Wix /bin/bash
```

Nun kannst du die Befehle selber im Container ausführen oder auch dich mit der Oberfläche von wine verbinden. Wenn du nach der Installation zum Beispiel `wine uninstaller` im Container ausführst, bekommst du eine Art "Add/Remove Programs" Dialog angezeigt. Manchmal musst du das Kommando zweimal eingeben, weil der X-Server nicht ganz richtig läuft. Wenn du den Dialog siehst, wirst du auch einen Eintrag dort von LernMoment.de sehen.
