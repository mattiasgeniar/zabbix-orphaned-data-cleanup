#!/bin/bash
export CONF
CONF="$(mktemp)"

cleanup_conf(){ rm -f "$CONF"; stty echo; exit;}
trap cleanup_conf SIGINT SIGTERM EXIT

if [ ! -z "$1" ] && [ -f "$1" ]; then
    echo "Use cnf file: $1"
    for val in user password database; do
        grep -q "$val" "$1" || {
            echo "Missing $val field in $1"
            exit 1
        }
    done
    cp "$1" "$CONF"
else
    echo -n "MySQL username: " ; read -r username
    echo -n "MySQL password: " ; stty -echo ; read -r password ; stty echo ; echo
    echo -n "MySQL database: " ; read -r database

    {
        echo [client]
        echo user     = "$username"
        echo password = "$password"
        echo database = "$database"
    } > "$CONF"
fi

mysql_w(){
    [ ! -f "$CONF" ] && exit 1
    mysql --defaults-file="$CONF" -NBe "$*"
}


echo "Count the amount of rows that would be deleted for orphaned alerts entries"
echo -n "Table: alerts orphaned actions: "
mysql_w "SELECT COUNT(*) FROM alerts WHERE NOT actionid IN (SELECT actionid FROM actions);"

echo -n "Table: alerts orphaned events: "
mysql_w "SELECT COUNT(*) FROM alerts WHERE NOT eventid IN (SELECT eventid FROM events);"

echo -n "Table: alerts orphaned users: "
mysql_w "SELECT COUNT(*) FROM alerts WHERE NOT userid IN (SELECT userid FROM users);"

echo -n "Table: alerts orphaned media_types: "
mysql_w "SELECT COUNT(*) FROM alerts WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);"


echo "Count the amount of rows that would be deleted for orphaned application entries that no longer map back to a host"
echo -n "Table: applications orphaned hosts: "
mysql_w "SELECT COUNT(*) FROM applications WHERE NOT hostid IN (SELECT hostid FROM hosts);"


echo "Count the amount of rows that would be deleted for orphaned auditlog details (such as logins)"
echo -n "Table: auditlog_details orphaned audits: "
mysql_w "SELECT COUNT(*) FROM auditlog_details WHERE NOT auditid IN (SELECT auditid FROM auditlog);"

echo -n "Table: auditlog orphaned users: "
mysql_w "SELECT COUNT(*) FROM auditlog WHERE NOT userid IN (SELECT userid FROM users);"


echo "Count the amount of rows that would be deleted for orphaned conditions"
echo -n "Table: conditions orphaned actions: "
mysql_w "SELECT COUNT(*) FROM conditions WHERE NOT actionid IN (SELECT actionid FROM actions);"


echo "Count the amount of rows that would be deleted for orphaned functions"
echo -n "Table: functions orphaned items: "
mysql_w "SELECT COUNT(*) FROM functions WHERE NOT itemid IN (SELECT itemid FROM items);"

echo -n "Table: functions orphaned triggers: "
mysql_w "SELECT COUNT(*) FROM functions WHERE NOT triggerid IN (SELECT triggerid FROM triggers);"


echo "Count the amount of rows that would be deleted for orphaned graph items"
echo -n "Table: graphs_items orphaned graphs: "
mysql_w "SELECT COUNT(*) FROM graphs_items WHERE NOT graphid IN (SELECT graphid FROM graphs);"

echo -n "Table: graphs_items orphaned items: "
mysql_w "SELECT COUNT(*) FROM graphs_items WHERE NOT itemid IN (SELECT itemid FROM items);"


echo "Count the amount of rows that would be deleted for orphaned host macro's"
echo -n "Table: hostmacro orphaned hosts: "
mysql_w "SELECT COUNT(*) FROM hostmacro WHERE NOT hostid IN (SELECT hostid FROM hosts);"


echo "Count the amount of rows that would be deleted for orphaned item data"
echo -n "Table: items orphaned hosts: "
mysql_w "SELECT COUNT(*) FROM items WHERE hostid NOT IN (SELECT hostid FROM hosts);"

echo -n "Table: items_applications orphaned applications: "
mysql_w "SELECT COUNT(*) FROM items_applications WHERE applicationid NOT IN (SELECT applicationid FROM applications);"

echo -n "Table: items_applications orphaned items: "
mysql_w "SELECT COUNT(*) FROM items_applications WHERE itemid NOT IN (SELECT itemid FROM items);"


echo "Count the amount of rows that would be deleted for orphaned HTTP check data"
echo -n "Table: httpstep orphaned httptests: "
mysql_w "SELECT COUNT(*) FROM httpstep WHERE NOT httptestid IN (SELECT httptestid FROM httptest);"

echo -n "Table: httpstepitem orphaned httpsteps: "
mysql_w "SELECT COUNT(*) FROM httpstepitem WHERE NOT httpstepid IN (SELECT httpstepid FROM httpstep);"

echo -n "Table: httpstepitem orphaned items: "
mysql_w "SELECT COUNT(*) FROM httpstepitem WHERE NOT itemid IN (SELECT itemid FROM items);"

echo -n "Table: httptest orphaned applications: "
mysql_w "SELECT COUNT(*) FROM httptest WHERE applicationid NOT IN (SELECT applicationid FROM applications);"


echo "Count the amount of rows that would be deleted for orphaned maintenance data"
echo -n "Table: maintenances_groups orphaned maintenances: "
mysql_w "SELECT COUNT(*) FROM maintenances_groups WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);"

echo -n "Table: maintenances_groups orphaned groups: "
mysql_w "SELECT COUNT(*) FROM maintenances_groups WHERE groupid NOT IN (SELECT groupid FROM groups);"

echo -n "Table: maintenances_hosts orphaned maintenances: "
mysql_w "SELECT COUNT(*) FROM maintenances_hosts WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);"

echo -n "Table: maintenances_hosts orphaned hosts: "
mysql_w "SELECT COUNT(*) FROM maintenances_hosts WHERE hostid NOT IN (SELECT hostid FROM hosts);"

echo -n "Table: maintenances_windows orphaned maintenances: "
mysql_w "SELECT COUNT(*) FROM maintenances_windows WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);"

echo -n "Table: maintenances_windows orphaned timeperiods: "
mysql_w "SELECT COUNT(*) FROM maintenances_windows WHERE timeperiodid NOT IN (SELECT timeperiodid FROM timeperiods);"

echo "Count the amount of rows that would be deleted for orphaned mappings"
echo -n "Table: mappings orphaned valuemaps: "
mysql_w "SELECT COUNT(*) FROM mappings WHERE NOT valuemapid IN (SELECT valuemapid FROM valuemaps);"


echo "Count the amount of rows that would be deleted for orphaned media items"
echo -n "Table: media orphaned users: "
mysql_w "SELECT COUNT(*) FROM media WHERE NOT userid IN (SELECT userid FROM users);"

echo -n "Table: media orphaned media_types: "
mysql_w "SELECT COUNT(*) FROM media WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);"

echo -n "Table: rights orphaned user groups: "
mysql_w "SELECT COUNT(*) FROM rights WHERE NOT groupid IN (SELECT usrgrpid FROM usrgrp);"

echo -n "Table: rights orphaned groups: "
mysql_w "SELECT COUNT(*) FROM rights WHERE NOT id IN (SELECT groupid FROM groups);"

echo -n "Table: sessions orphaned users: "
mysql_w "SELECT COUNT(*) FROM sessions WHERE NOT userid IN (SELECT userid FROM users);"


echo "Count the amount of rows that would be deleted for orphaned screens"
echo -n "Table: screens_items orphaned screens: "
mysql_w "SELECT COUNT(*) FROM screens_items WHERE screenid NOT IN (SELECT screenid FROM screens);"


echo "Count the amount of rows that would be deleted for orphaned events & triggers"
echo -n "Table: trigger_depends orphaned triggers(triggerid_down): "
mysql_w "SELECT COUNT(*) FROM trigger_depends WHERE triggerid_down NOT IN (SELECT triggerid FROM triggers);"

echo -n "Table: trigger_depends orphaned triggers(triggerid_up): "
mysql_w "SELECT COUNT(*) FROM trigger_depends WHERE triggerid_up NOT IN (SELECT triggerid FROM triggers);"


echo "Count the amount of records in the history/trends table for items that no longer exist"
TABLES=(history history_uint history_log history_str history_text trends trends_uint)
for table in "${TABLES[@]}"; do
        echo -n "Table: $table orphaned items: "
        mysql_w "SELECT COUNT(itemid) FROM $table WHERE itemid NOT IN (SELECT itemid FROM items);"
done


echo "Count the amount of records in the events table for triggers/items that no longer exist"
echo -n "Table: events orphaned triggers(src=0, obj=0): "
mysql_w "SELECT COUNT(eventid) FROM events WHERE source = 0 AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers);"

echo -n "Table: events orphaned triggers(src=3, obj=0): "
mysql_w "SELECT COUNT(eventid) FROM events WHERE source = 3 AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers);"

echo -n "Table: events orphaned items(src=3, obj=4): "
mysql_w "SELECT COUNT(eventid) FROM events WHERE source = 3 AND object = 4 AND objectid NOT IN (SELECT itemid FROM items);"


echo "Count the amount of acknowledges in the acknowledges table for events which would be deleted previously"
echo -n "Table: acknowledges orphaned events: "
mysql_w "SELECT COUNT(*) FROM acknowledges WHERE NOT eventid IN (SELECT eventid FROM events);"

echo -n "Table: acknowledges orphaned users: "
mysql_w "SELECT COUNT(*) FROM acknowledges WHERE NOT userid IN (SELECT userid FROM users);"

echo -n "Table: acknowledges orphaned events(src=0|3): "
mysql_w "SELECT COUNT(acknowledgeid) FROM acknowledges WHERE eventid IN (SELECT eventid FROM events WHERE (source = 0 OR source=3) AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers));"

echo -n "Table: acknowledges orphaned events(src=3, obj=4): "
mysql_w "SELECT COUNT(acknowledgeid) FROM acknowledges WHERE eventid IN (SELECT eventid FROM events WHERE source=3 AND object = 4 AND objectid NOT IN (SELECT itemid FROM items));"
