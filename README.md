<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    * [Descrizione del progetto](#descrizione-del-progetto)
    * [Passi comuni per l'installazione](#passi-comuni-per-l'installazione )
    * [Esecuzione locale senza Docker ](#esecuzione-locale-senza-Docker )
    * [Esecuzione con Docker ](#esecuzione-con-Docker)
    * [Versioni utilizzate](#versioni-utilizzate)
</ol>
</details>
# Descrizione  del progetto

L'applicazione web permette di gestire la prenotazione eventi e la relativa creazione di essi, tramite due ruoli gli utenti e i mananger, gli utenti saranno in grado di cercare eventi e prenotarsi mentre i manager saranno in grado di creare e modificare eventi.

L'applicativo offre anche le seguenti funzionalità:
* Per gli utenti:
  * Registrazione di utenti
  * Cercare eventi filtrando per:
    * Posizione geografica
    * Nome evento
    * Descrizione
  * Registrasi o deregistrarsi ad eventi
  * L'iscrizione a eventi è impedità se concomitante ad un altro ai
quali sono già iscritti.

* Per i manager:
  * Registrazione dei manager
  * Permettere ai manager di creare eventi caratterizzati da:
    * Nome
    * Orario Inizio (anche data)
    * Orario Fine (anche data)
    * Luogo
    * Posizione geografica
    * Massimo numero di partecipanti
  * Consultare la lista dei partecipanti ai propri eventi ed eventualmente rimuovere utenti iscritti indesiderati dai propri eventi

L'applicativo implenta anche un sistema di notifiche che avvisa i manager e gli utenti:

* Avvisa gli utenti di: 
  * Un evento se esso ha avuto variazioni, se esso viene annullato
dall’organizzatore
  * Se essi sono stati rimossi

* Avvisa i manager di:
  * Massima capienza raggiunta
  * Utente iscritto 
  * Utente disiscritto 

## Passi comuni per l'installazione 

* clonare il repository con il seguente comando

```
git clone git@github.com:Mattiabzz/LaboratorioIndustria.git
```
* Entrare nella cartella creata 
```
cd LaboratorioIndustria
```


## Esecuzione locale senza Docker 

* Installare le gemme

```bash
bundle install
```

* Creare il database

```bash
bundle exec rake db:migrate
```

* Se si vuole fare una migrazione base per creare dei record nel database 

```bash
bundle exec rake db:seed
```

* Esecuzione del server
```bash 
exec rails server
```
* connetersi a http://127.0.0.1:3000/

* in caso di migrazione effettuata sarà possibile loggarsi tramite: 
  * per gli utenti:

    * e-mail = mattia@utente.com 
    * e-mail = giovanni@utente.com
    * e-mail = vincenzo@utente.com

  * per i manager:
    * e-mail = mattia@manager.com
    * e-mail = karim@manager.com

Per tutti la password di default è "password"

## Esecuzione con Docker 
* Scaricare Docker 

* Creare il container 
```
sudo docker image build --tag event_org:2024 -f Dockerfile.rails .
```

* Lanciare il container 

```
sudo docker container run -p 3000:3000 event_org:2024
```

* Connetersi a http://0.0.0.0:3000/

* L'immagine nel momento della creazione esegue il commando db:seed che popola il database, offrendo la possibilità di logagrsi senza dover registrarsi, tramite: 

* per gli utenti:

    * e-mail = mattia@utente.com 
    * e-mail = giovanni@utente.com
    * e-mail = vincenzo@utente.com

* per i manager:

    * e-mail = mattia@manager.com
    * e-mail = karim@manager.com

Per tutti la password di default è "password"

## Versioni utilizzate 

* Ruby = 3.3.0

* Rails = 7.1.3

* sqlite3 = 1.4

* bootstrap = 5.3.0