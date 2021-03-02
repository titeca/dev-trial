# Titeca DEV Trial

## Setup

* Clone deze repository deze naar je lokale development omgeving;
* Installeer indien dit nog niet het geval is, docker op je computer;
* Kopieer de bestanden `.docker.env.example` en`.env.example` en hernoem deze naar `.docker.env` en`.env`;
* Breng de DEV-omgeving vervolgens live via het commando `docker-compose up --build -d`;
* Als laatste dienen nog enkele artisan commando's uitgevoerd te worden op de Laravel applicatie te kunnen hosten:
  * `docker-compose exec app php artisan key:generate`: Genereert een applicatie sleutel en voegt deze toe aan je .env-file;
  * `docker-compose exec app php artisan horizon:install`: Finaliseert de installatie van Laravel Horizon, een monitoring tool voor Redis Queues;
* Open je browser en surf naar `http://localhost:8080`. Deze zou de introductie pagina van laravel moeten tonen. Surfen naar `http://localhost:8080/about` toont je de output van `phpinfo()`;

## Opdracht

1. Maak een eenvoudige CRUD-applicatie voor het beheren van contacten. Bewaar van ieder contact zijn: naam, adres, postcode, gemeente, e-mailadres, telefoon, etc... Bewaar deze op de mySQL server aanwezig in het docker netwerk. Gebruik Laravel migraties voor de opbouw van je tabellen en vul deze a.d.h.v. seeders op met dummy-data. Gebruik voor je applicatie zoveel mogelijk de functionaliteiten die Laravel voorziet: e.g. Models, Controllers, Requests, Routes, Views,...
2. Start een trial-abonnement op bij Exact Online, bekijk hoe hun API en het oAuth 2.0 protocol werkt. Probeer vervolgens met een tool zoals e.g.: Postman of Insomnia door hun authenticatie proces te geraken, data te gaan opvragen en te gaan wegschrijven. Integreer vervolgens de functionaliteit in je laravel-applicatie: dat wanneer je een contact aanmaakt, wijzigt of verwijdert, dit doorgepusht wordt naar de relatie module in je Exact Online administratie. API-calls kunnen voor de nodige vertraging zorgen, houd hier rekening mee. Laravel's model observers, job queueing en de HTTP-client kunnen je helpen dit voor elkaar te krijgen.
3. Onderzoek als laatste de mogelijkheid om de synchronisatie van contacten tussen jouw applicatie en jouw Exact Online administratie bidirectioneel te maken.

## Handige links

* [Documentatie laravel]<https://laravel.com/docs>
* [Documentatie API Exact-Online]<https://support.exactonline.com/community/s/knowledge-base#All-All-DNO-Content-restrefdocs>
* [Aanvraag voor een Exact proefaccount]<https://www.exact.com/benl/producten/accountancy/probeer/professional>
* [Insomnia download]<https://insomnia.rest/download/>
