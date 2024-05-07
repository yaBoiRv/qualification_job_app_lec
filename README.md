# README

## Ievads
Šis README sniedz instrukcijas par tīmekļa vietnes palaišanu, kas izveidota, izmantojot Ruby on Rails ar Tailwind CSS un PostgreSQL.

## Priekšnosacījumi
Lai veiksmīgi palaistu šo Ruby on Rails lietotni, ir nepieciešami šādi priekšnosacījumi:

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

1. Pārvieot datubāzi uz docker konteineri
2. Iekļaut Javascript bibliotēkas iekš rails pipeline(pašlaik tiek izmantota CDN metode)
3. Izveidot rspec testus

## Papildu piezīmes

Ja jums rodas problēmas, pārbaudiet, vai visi priekšnosacījumi ir izpildīti, un pārliecinieties, ka PostgreSQL serveris darbojas. Lai iegūtu vairāk informācijas par Ruby on Rails, Tailwind CSS, un PostgreSQL, skatiet oficiālo dokumentāciju.

## Atbalsts un palīdzība

Ja jums nepieciešama palīdzība vai atbalsts, apskatiet šos resursus:

[Ruby on Rails dokumentācija](https://guides.rubyonrails.org)
[PostgreSQL dokumentācija](https://www.postgresql.org/docs/)
[Tailwind CSS dokumentācija](https://tailwindcss.com/docs/installation)

Šis README nodrošina strukturētu veidu, kā iestatīt, konfigurēt, un palaist Ruby on Rails lietotni, sniedzot visus būtiskos soļus un piezīmes par priekšnosacījumiem. Tas ietver nepieciešamās komandas, lai izveidotu un konfigurētu PostgreSQL datubāzi, instalētu Ruby on Rails, un palaistu lietotni.
