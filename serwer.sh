#!/bin/bash

					

echo "Uruchamianie serwera MySQL"								# Uruchamiamy server MySQL

service mysql start
								

sleep 2												# Dajemy chwile na rozruch 





echo "Logujemy się do MySQL i dodajemy nowego użytkownika oraz baze danych"			# Konfiguracja bazy DVWA.

mysql -u root -p <<EOF

CREATE DATABASE dvwa;

CREATE USER 'uzytkownik'@'127.0.0.1' IDENTIFIED BY 'haslo';

GRANT ALL PRIVILEGES ON dvwa.* TO 'uzytkownik'@'127.0.0.1' IDENTIFIED BY 'haslo';

FLUSH PRIVILEGES;

EOF



cd /etc/php/8.2/apache2										# Przechodzimy do ustawien, i odblokowujemy parametry dla DVWA.

echo "Zmiana allow_url_include na On w pliku php.ini..."

sed -i 's/allow_url_include = Off/allow_url_include = On/' php.ini


service apache2 start



sleep 10



echo "Koniec - serwer został skonfigurowany pomyślnie. Proszę otworzyć kolejny skrypt - misie.sh"

