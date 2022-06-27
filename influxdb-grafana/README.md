# InfluxDB
## Backup and restore old influxdb database
### Backup old bucket

* Open terminal inside old container: `sudo docker exec -it influxdb bash`
    * Create backup folder `mkdir /home/influxdb/backup`
    * Run backup `influx backup /home/influxdb/backup/ -t <admin-token> -b gain`
* On old host:
    * Copy backup files: `docker cp influxdb:/home/influxdb/backup/. ./influxdb-backup` 
* On client:
    * Copy files: `scp -r maid@192.168.123.11:/home/maid/influxdb-backup .`

### Restore on new container
* On client:
    * Copy to new host: `scp -r ./influxdb-backup maid@192.168.123.4:/home/maid/influxdb-backup`
* On new host:
    * `sudo docker cp . influxdb:/home/influxdb/backup`
* Open terminal inside old container: `sudo docker exec -it influxdb bash`
    * `influx restore /home/influxdb/backup/ -t <admin-token>`
    * Might have to delete existing bucket in the GUI

## Create users
Two users `ro` (read-only) and `rw` (read-write)

# Grafana

## Add InfluxDB as data source
* Language: Flux
* URL: http://influxdb:8086
* Disable all options other than "Skip TSL authentication"
* Organization: gain
* Default bucket: gain
* Token: <ro-token>

## Backup and restore dashboards
### Backup
* In the Web GUI, go to a dashboard
* Click share button next to the dashboard name
* Export as JSON, with "Share externally" enabled

### Restore
Go to http://192.168.123.4:3000/dashboards and import JSON file

