## Zabbix Database Cleanup

This repo contains a few useful queries to cleanup old orphaned data in a Zabbix database. While Zabbix does Housekeeping, it does not clear orphaned data very well. Especially if you come from a long upgrade-line (1.x to 1.6 to 1.8 to 2.x), chances are your database is riddled with orphaned data that is consuming disk space.
If you have a large database please note that these can take a while (read: a few hours is normal).
Use the queries above on your won risk. Take *backups* first. Once you have back-ups, go ahead and be brave.
"Orphaned" queries are the same for Mysql and Postgresql. "Old" are not, so pay attention.

##### NOTE
The queries are tested against Zabbix 1.8 and 2.0. Aplly with caution to other version. Consider reporting the results, whether succesful or not.


#### Check how many orphaned rows you have

    user@host-$ psql zabbix < orphaned/check.sql

#### Delete the orphaned rows

    user@host-$ psql zabbix < orphaned/clean.sql

#### Delete old data (1 week for history, 3 months for trends - edit sql at your own discretion)

    user@host-$ psql zabbix < old/postgresql/clean.sql

#### Delete all history for disabled items

    user@host-$ psql zabbix < unused/postgresql/clean.sql
