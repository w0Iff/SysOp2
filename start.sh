#!/bin/bash



read -p "Czy oglądałeś film 'Chłopaki nie płaczą'? (T/N): " film_odp									# Obowiązkowe pytanie o film :) 



if [ "$film_odp" == "T" ] || [ "$film_odp" == "t" ]; then

   
    read -p "Czy chcesz do testów używać serwera: A) Apache czy B) Nginx? (A/B): " serwer_wybor			  			# Wybór serwera



    if [ "$serwer_wybor" == "A" ] || [ "$serwer_wybor" == "a" ]; then

       

        echo "Instalacja serwera Apache."												# Instalacja Apache w przypadku wyboru 

        sudo apt update

        sudo apt install apache2

        echo "Serwer Apache został pomyśłnie zainstalowany."

        echo "Instaluje skrypty PHP"

        sudo sudo apt install php-mysql





    elif [ "$serwer_wybor" == "B" ] || [ "$serwer_wybor" == "b" ]; then

																	# Instalacja Nginx w przypadku wyboru

        echo "Instalacja serwera Nginx"

        sudo apt update

        sudo apt install nginx

        echo "Serwer Nginx został pomyslnie zainstalowany."



    else

        echo "Udzielona odpowiedź jest nieprawidłowa"

        exit 1

    fi



																	# Przechodzimy do folderu gdzie będziemy instalować DVWA


    cd /var/www/html

    echo "Instaluję DVWA"

    git clone https://github.com/digininja/DVWA.git



    echo "Zmiana nazwy folderu"														# Dla bezpieczeństwa i lepszego działania zmieniamy nazwę folderu

    mv DVWA dvwa




    echo "Wykonuję: chmod -R 777 dvwa/"													# Dodajemy uprawnienia

    chmod -R 777 dvwa/

																	# Wbijamy się w folder konfiguracyjny 

    cd dvwa/config



    cp config.inc.php.dist config.inc.php												# Tworzymy plik konfiguracyjny



    echo "Zmieniam dane logowania na domyslne: uzytkownik/haslo"

    sed -i "s/\$_DVWA\[ 'db_user' \]     = 'dvwa';/\$_DVWA[ 'db_user' ]     = 'uzytkownik';/g; s/\$_DVWA\[ 'db_password' \] = 'p@ssw0rd';/\$_DVWA[ 'db_password' ] = 'haslo';/g" config.inc.php		# Ustawiamy dane logowania (uzytkownik/haslo)

    
   echo "Proszę otworzyć kolejny skrypt: serwer.sh"

sleep 25



else

    echo "Pan prowadzący polecił zapoznać się z filmem \"Chłopaki nie płaczą\", więc proszę to zrobić przed resztą projektu :)"

    exit 1

fi

