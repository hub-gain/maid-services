# MariaDB

Set `MARIADB_ROOT_PASSWORD` environment variable in Portainer!

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

To restore the database schema, load the `ai*.sql` file via File -> Run SQL file