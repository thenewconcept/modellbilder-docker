# Supported tags and respective `Dockerfile` links

- thenewconcept/mb:latest

## 1. Create Application directory.

- `$ mkdir modellbilder`
- `$ mkdir modellbilder/app`
- Pull the git repo into the `app` directory
- Create the `includes/settings.php` and `application/boostrap_data.php` from the example files.
- Follow the app README.

## 2. Create Database directory.

- `$ mkdir modellbilder/database/modeldb`
- Extract the database backup/dump files to the modeldb folder.
- You might need to repair the database. Execute the following command in the DB container:
- `$ mysqlcheck -h 127.0.0.1 -u root -p --auto-repair --check --all-databases`

## 3. Container setup

- Create the following `docker-compose.yml` file in the project root directory

```
version: '3.1'
services:
  db:
    image: mysql:5.5
    environment:
      - MYSQL_ROOT_PASSWORD=testpass
      - MYSQL_DATABASE=modeldb
    volumes:
      - ./database:/var/lib/mysql
  web:
    image: thenewconcept/modellbilder:latest
    depends_on:
      - db
    ports:
      - "8080:80"
    volumes:
      - ./app:/var/www/html
```

## 4. Spin up docker

- `$ docker login`
- `$ docker-compose up -d`
