# README
# LV
## Ievads
Šis README sniedz instrukcijas par tīmekļa vietnes palaišanu, kas izveidota, izmantojot Ruby on Rails ar Tailwind CSS un PostgreSQL.

## Priekšnosacījumi
Lai veiksmīgi palaistu šo Ruby on Rails lietotni, ir nepieciešami šādi priekšnosacījumi:
## Izmantojot docker container:
Nepieciešamās docker versijas
```bash
# docker -v                                                                 
Docker version 20.10.11, build dea9396

# docker-compose -v                                                                  
Docker Compose version v2.13.0

```

1. Klonējiet repozitoriju uz savu datoru:
```javascript
git clone https://github.com/yaBoiRv/app_lec.git
```
2. Pārejiet uz lietotnes mapi:
```javascript
 cd ceļš/uz/app_lec
```
3. Izpildiet komandu:
```javascript
 docker compose build
 docker compose up
```
4. Atveriet pārlūkprogrammu un ievadiet šādu adresi, lai piekļūtu vietnei - http://127.0.0.1:3000/


## Izveidot izmantojot lokālu atmiņu: 
1. Ruby: Lejupielādējiet un instalējiet Ruby versiju '3.2.2'. Pārliecinieties, ka Ruby ir pareizi instalēts, izpildot ruby -v.
2. Bundler: Instalējiet bundler gem, kas tiek izmantots atkarību pārvaldībai. Izpildiet gem install bundler -v 2.5.3.
3. PostgreSQL: Instalējiet PostgreSQL datubāzi. Pārliecinieties, ka tā darbojas un lietotājam ir atbilstošas tiesības.
   - Windows lietotājiem: Ja lietojat Windows, apsveriet virtuālās vides vai Linux apakšsistēmas izmantošanu.
4. Git: Klonēšanai un versiju pārvaldībai. Pārliecinieties, ka tas ir instalēts.

## Ruby on Rails uzstādīšana

1. Klonējiet repozitoriju uz savu datoru:
```javascript
git clone https://github.com/yaBoiRv/app_lec.git
```
2. Pārejiet uz lietotnes mapi:
```javascript
 cd ceļš/uz/app_lec
```
3. Instalējiet nepieciešamos gem - Bundle install
```javascript
bundle install
```
## Datubāzes uzstādīšana

Lai sagatavotu PostgreSQL datubāzi:

1. Pārejiet uz lietotnes mapi:
```javascript
cd ceļš/uz/app_lec
```
2. Izveidojiet datubāzi, ja tā vēl nepastāv:
```javascript
rails db:create.
```
Datubāzes konfigurāciju apskatīt config/database.yaml
3. Veiciet datubāzes migrāciju, lai ielādētu sākotnējo datu struktūru: 
```javascript
rails db:migrate
```

## Palaišana

Lai palaistu Ruby on Rails lietotni:

1. Atveriet termināli un pārejiet uz lietotnes mapi:
```javascript
cd ceļš/uz/app_lec
```
2. Sāciet Rails serveri:
```javascript
bin/dev
```
4. Atveriet pārlūkprogrammu un ievadiet šādu adresi, lai piekļūtu vietnei - http://127.0.0.1:3000/

## Potenciālie labojumi

~~1. Pārvieot datubāzi uz docker konteineri~~
2. Iekļaut Javascript bibliotēkas iekš rails pipeline(pašlaik tiek izmantota CDN metode)
3. Izveidot rspec testus

## Papildu piezīmes

Ja jums rodas problēmas, pārbaudiet, vai visi priekšnosacījumi ir izpildīti, un pārliecinieties, ka PostgreSQL serveris darbojas. Lai iegūtu vairāk informācijas par Ruby on Rails, Tailwind CSS, un PostgreSQL, skatiet oficiālo dokumentāciju.

## Atbalsts un palīdzība

Ja jums nepieciešama palīdzība vai atbalsts, apskatiet šos resursus:

[Ruby on Rails dokumentācija](https://guides.rubyonrails.org)
[PostgreSQL dokumentācija](https://www.postgresql.org/docs/)
[Tailwind CSS dokumentācija](https://tailwindcss.com/docs/installation)


# EN
## Introduction
This README provides instructions on launching a website built using Ruby on Rails with Tailwind CSS and PostgreSQL.

## Prerequisites
To successfully run this Ruby on Rails application, the following prerequisites are required:

## Using docker container:
Required docker versions
```bash
# docker -v                                                                 
Docker version 20.10.11, build dea9396

# docker-compose -v                                                                  
Docker Compose version v2.13.0

```

1. Clone the repository to your computer:
```javascript
git clone https://github.com/yaBoiRv/app_lec.git
```
2. Move to the application's folder:
```javascript
  cd path/to/app_lec
```
3. Run the command:
```javascript
 docker compose build
 docker compose up
```
4. 4. Open a web browser and enter the following address to access the website - http://127.0.0.1:3000/

## Izveidot izmantojot lokālu atmiņu: 
1. Ruby: Download and install Ruby version '3.2.2'. Ensure Ruby is installed correctly by running ruby -v.
2. Bundler: Install the bundler gem, which is used for dependency management. Run gem install bundler -v 2.5.3.
3. PostgreSQL: Install the PostgreSQL database. Make sure it is running and the user has appropriate permissions.
   - For Windows users: If you're using Windows, consider using a virtual environment or the Windows Subsystem for Linux.
4. Git: For cloning and version control. Ensure it's installed.

## Installing Ruby on Rails

1. Clone the repository to your computer:
```javascript
git clone https://github.com/yaBoiRv/app_lec.git
```
2. Move to the application's folder:
```javascript
  cd path/to/app_lec
```
3. Install the required gems:
```javascript
bundle install
```
## Setting Up the Database

To prepare the PostgreSQL database:

1. Go to the application's folder:
```javascript
cd path/to/app_lec
```
2. Create the database if it doesn't already exist:
```javascript
rails db:create.
```
You can find the database configuration in config/database.yaml.
3. Perform the database migration to load the initial data structure:
```javascript
rails db:migrate
```

## Launching the Application

To run the Ruby on Rails application:

1. Open a terminal and move to the application's folder:
```javascript
cd path/to/app_lec
```
2. Start the Rails server:
```javascript
bin/dev
```
4. Open a web browser and enter the following address to access the website - http://127.0.0.1:3000/

## Potential Improvements

~~1. Migrate the database to a Docker container.~~
2. Include JavaScript libraries in the Rails pipeline (currently using the CDN method).
3. Create rspec tests.

## Additional Notes

If you encounter problems, check that all prerequisites are met, and ensure the PostgreSQL server is running. For more information about Ruby on Rails, Tailwind CSS, and PostgreSQL, see the official documentation.

## Support and Help

If you need help or support, check these resources:

[Ruby on Rails Documentation](https://guides.rubyonrails.org)
[PostgreSQL Documentation](https://www.postgresql.org/docs/)
[Tailwind CSS Documentation](https://tailwindcss.com/docs/installation)
