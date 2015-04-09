# Zabbix SQL repo

This repo contains a few useful queries for Zabbix database, mostly to cleanup old and/or orphaned data.

- [Important notes] (#important-notes)
- [Usage] (#usage)
  * Check orphaned rows (#check-orphaned-rows)
  * Delete orphaned rows (#delete-orphaned-rows)

### Important notes

If you have a large database please note that these can take a while (read: a few hours is normal).

Use the queries on your own risk. Take **backups** first. The queries were tested against Zabbix 1.8-2.2. 

Some scripts are Mysql or Postgresql specific, they're named *.my.sql and *.pg.sql, respectively. Some are also Zabbix version specific. Filenames are self-explaining.

### Usage

#### Check orphaned rows

    # mysql zabbix < check-orphaned-data.sql

#### Delete orphaned rows

    # mysql zabbix < delete-orphaned-data.sql

#### Delete old data (1 week for history, 3 months for trends - edit sql at your own discretion)

    # psql -A -R ' : ' -P 'footer=off' zabbix < delete-old-data.pg.sql

#### Delete all history for disabled items

    # psql -A -R ' : '  -P 'footer=off' zabbix < delete-unused-data.sql

#### Stop zabbix email flood (mysql, pgsql)

(Use stop-and-delete-email-alerts.sql if you're not interested in alert history)

    # sudo service zabbix-server stop
    # psql zabbix < stop-email-alerts.sql
    # sudo service zabbix-server start
