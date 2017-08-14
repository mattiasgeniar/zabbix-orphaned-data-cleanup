Zabbix Database Cleanup
=======================

This repo contains a few useful queries to cleanup old orphaned data in a Zabbix database. While Zabbix does Housekeeping, it does not clear orphaned data very well. Especially if you come from a long upgrade-line (1.x to 1.6 to 1.8 to 2.x), chances are your database is riddled with orphaned data that is consuming disk space.


Usage: check how many orphaned rows you have
============================================

These queries are safe to run, but if you have a large database please note that these can take a while (read: a few hours is normal).

    user@host-$ mysql -f zabbix < checkscript.sql

or

    user@host-$ ./checkscript.sh
    user@host-$ ./checkscript.sh ./zbx_db_info.cnf

Usage: delete the orphaned rows
===============================

Use the queries above on your won risk. Take *backups* first. Once you have back-ups, go ahead and be brave.

     user@host-$ mysql -f zabbix < cleanup.sql

or

    user@host-$ ./cleanup.sh
    user@host-$ ./cleanup.sh ./zbx_db_info.cnf
