== Zabbix Database Cleanup

This repo contains a few useful queries to cleanup old orphaned data in a Zabbix database. While Zabbix does Housekeeping, it does not clear orphaned data very well. Especially if you come from a long upgrade-line (1.x to 1.6 to 1.8 to 2.x), chances are your database is riddled with orphaned data that is consuming disk space.

Use the queries above on your won risk. Take *backups* first.
