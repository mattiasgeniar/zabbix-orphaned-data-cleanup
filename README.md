# Zabbix SQL repo

This repo contains a few useful queries for Zabbix database, mostly to cleanup old and/or orphaned data.

### Important notes

If you have a large database please note that these can take a while (read: a few hours is normal).

Use the queries on your own risk. Take **backups** first. The queries were tested against Zabbix 1.8-2.2. 

Some scripts are Mysql or Postgresql specific, they're named *.my.sql and *.pg.sql, respectively. Some are also Zabbix version specific. Filenames are self-explaining.

### Usage

#### Check how many orphaned rows do you have

    user@host-$ mysql zabbix < check-orphaned-data.sql

#### Delete orphaned rows

    user@host-$ mysql zabbix < delete-orphaned-data.sql

#### Delete old data (1 week for history, 3 months for trends - edit sql at your own discretion)

    user@host-$ psql -A -R ' : ' -P 'footer=off' zabbix < delete-old-data.pg.sql

#### Delete all history for disabled items

    user@host-$ psql -A -R ' : '  -P 'footer=off' zabbix < delete-unused-data.sql

#### Stop zabbix email flood (mysql, pgsql)

(Use stop-and-delete-email-alerts.sql if you're not interested in alert history)

    user@host-$ sudo service zabbix-server stop
    user@host-$ psql zabbix < stop-email-alerts.sql
    user@host-$ sudo service zabbix-server start
