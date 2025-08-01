# MariaDB

## Deploy

* Navigate to the `mariadb` directory
* Make a copy of `example.env` and name it `.env`
* Change the default usernames and passwords in the `.env` file
* Bring up the container by running `sudo docker compose up -d`

Use [HeidiSQL](https://www.heidisql.com/) as GUI.

## User management
In HeidiSQL:
* Tools -> User Manager:
    * `ro` (read-only):
        * User name: `ro`
        * From host: `%`
        * Privileges: `SELECT`, `SHOW DATABASES`, `SHOW VIEW`
    * `rw`:
        * Username: `rw`
        * From host: `192.168.123.%`
        * Privileges: `EXECUTE`, `SELECT`, `SHOW VIEW`, `CREATE`, `CREATE VIEW`, `INSERT`

## Database schema

* Create a new database, e.g. named `atominterferometer2022` and select it

* Restore the database schema by running the `ai*.sql` file via File -> Run SQL file