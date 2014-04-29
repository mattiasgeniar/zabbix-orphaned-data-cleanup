## Zabbix SQL repo

This repo contains a few useful queries for Zabbix database, mostly to cleanup old and/or orphaned data.

If you have a large database please note that these can take a while (read: a few hours is normal).

Use the queries above on your own risk. Take *backups* first.

Some scripts are Mysql or Postgresql specific, they're named *.my.sql and *.pg.sql, respectively. Pay attention.

#### NOTE
The queries were tested against Zabbix 1.8 and 2.0. Apply with caution to other versions. Consider reporting the results, whether succesful or not.


#### Check how many orphaned rows do you have

    user@host-$ mysql zabbix < check-orphaned-data.sql

#### Delete orphaned rows

    user@host-$ mysql zabbix < delete-orphaned-data.sql

#### Delete old data (1 week for history, 3 months for trends - edit sql at your own discretion)

    user@host-$ psql zabbix < delete-old-data.pg.sql

#### Delete all history for disabled items

    user@host-$ psql zabbix < delete-unused-data.sql

#### Stop zabbix email flood (mysql, pgsql)

    user@host-$ sudo service zabbix-server stop
    user@host-$ psql zabbix < stop-email-alerts.sql (use stop-and-delete-email-alerts.sql if you're not interested in alert history)
    user@host-$ sudo service zabbix-server start
