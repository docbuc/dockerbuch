# Fehler im Buch (3. Auflage)

## Seite 73
Die Datei **mysql-pw.txt** existiert nicht. Es muss das Passwort **geheim** vom run command verwendet werden.

## Seite 107
Korrekt: docker service ps stacktest_db --no-trunc  
Falsch: docker service ps sometest --no-trunc

## Seite 120
Die die Rede ist hier von der Extension **Docker** und nicht von der Extension **Docker Extension ...**.

## Seite 138
Das Schlüsselwort **--now** darf nicht verwendet werden, sonst wird der Service zusätzlich gestartet/angehalten.
Korrigiert: systemctl enbale docker-mysql
Korrigiert: systemctl disable docker-mysql

## Seite 142
Hier wird fälschlicherweise von **MiB** (Mebibyte) anstelle von **Megabyte** gesprochen. 

## Seite 262
Wordpress CLI benötig die "environment variables" um zur Datenbank verbinden zu können.  

Korrekt:  
docker run --rm -t \
--volumes-from wordpress-web-1 \
--network wordpress_default \
--env WORDPRESS_DB_HOST=mariadb \
--env WORDPRESS_DB_NAME=dockerbuch \
--env WORDPRESS_DB_USER=dockerbuch \
--env WORDPRESS_DB_PASSWORD=johroo2zaeQu \
wordpress:cli plugin update --all

Falsch:  
docker run --rm -t --volumes-from wordpress-web-1 --network wordpress_default wordpress:cli plugin update --all

## Seite 313
Korrekt: [[outputs.influxdb]]
Falsch: [[outputs.telegraf]]
