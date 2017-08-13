#!/bin/bash
export CONF
CONF="$(mktemp)"

cleanup_conf(){ rm "$CONF"; }
trap cleanup_conf SIGINT SIGTERM EXIT

echo -n "MySQL username: " ; read -r username
echo -n "MySQL password: " ; stty -echo ; read -r password ; stty echo ; echo
echo -n "MySQL database: " ; read -r database

{
    echo [client]
    echo user     = "$username"
    echo password = "$password"
    echo database = "$database"
} > "$CONF"

mysql_w(){
    [ ! -f "$CONF" ] && exit 1
    mysql --defaults-file="$CONF" -NBe "${*} SELECT ROW_COUNT();"
}


echo "Delete orphaned alerts entries"
echo -n "Table: alerts orphaned actions: "
mysql_w "DELETE FROM alerts WHERE NOT actionid IN (SELECT actionid FROM actions);"

echo -n "Table: alerts orphaned events: "
mysql_w "DELETE FROM alerts WHERE NOT eventid IN (SELECT eventid FROM events);"

echo -n "Table: alerts orphaned users: "
mysql_w "DELETE FROM alerts WHERE NOT userid IN (SELECT userid FROM users);"

echo -n "Table: alerts orphaned media_types: "
mysql_w "DELETE FROM alerts WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);"

echo "Delete orphaned application entries that no longer map back to a host"
echo -n "Table: applications orphaned hosts: "
mysql_w "DELETE FROM applications WHERE NOT hostid IN (SELECT hostid FROM hosts);"


echo "Delete orphaned auditlog details (such as logins)"
echo -n "Table: auditlog_details orphaned audits: "
mysql_w "DELETE FROM auditlog_details WHERE NOT auditid IN (SELECT auditid FROM auditlog);"

echo -n "Table: auditlog orphaned users: "
mysql_w "DELETE FROM auditlog WHERE NOT userid IN (SELECT userid FROM users);"


echo "Delete orphaned conditions"
echo -n "Table: conditions orphaned actions: "
mysql_w "DELETE FROM conditions WHERE NOT actionid IN (SELECT actionid FROM actions);"


echo "Delete orphaned functions"
echo -n "Table: functions orphaned items: "
mysql_w "DELETE FROM functions WHERE NOT itemid IN (SELECT itemid FROM items);"

echo -n "Table: functions orphaned triggers: "
mysql_w "DELETE FROM functions WHERE NOT triggerid IN (SELECT triggerid FROM triggers);"


echo "Delete orphaned graph items"
echo -n "Table: graphs_items orphaned graphs: "
mysql_w "DELETE FROM graphs_items WHERE NOT graphid IN (SELECT graphid FROM graphs);"

echo -n "Table: graphs_items orphaned items: "
mysql_w "DELETE FROM graphs_items WHERE NOT itemid IN (SELECT itemid FROM items);"


echo "Delete orphaned host macro's"
echo -n "Table: hostmacro orphaned hosts: "
mysql_w "DELETE FROM hostmacro WHERE NOT hostid IN (SELECT hostid FROM hosts);"


echo "Delete orphaned item data"
echo -n "Table: items orphaned hosts: "
mysql_w "DELETE FROM items WHERE hostid NOT IN (SELECT hostid FROM hosts);"

echo -n "Table: items_applications orphaned applications: "
mysql_w "DELETE FROM items_applications WHERE applicationid NOT IN (SELECT applicationid FROM applications);"

echo -n "Table: items_applications orphaned items: "
mysql_w "DELETE FROM items_applications WHERE itemid NOT IN (SELECT itemid FROM items);"


echo "Delete orphaned HTTP check data"
echo -n "Table: httpstep orphaned httptests: "
mysql_w "DELETE FROM httpstep WHERE NOT httptestid IN (SELECT httptestid FROM httptest);"

echo -n "Table: httpstepitem orphaned httpsteps: "
mysql_w "DELETE FROM httpstepitem WHERE NOT httpstepid IN (SELECT httpstepid FROM httpstep);"

echo -n "Table: httpstepitem orphaned items: "
mysql_w "DELETE FROM httpstepitem WHERE NOT itemid IN (SELECT itemid FROM items);"

echo -n "Table: httptest orphaned applications: "
mysql_w "DELETE FROM httptest WHERE applicationid NOT IN (SELECT applicationid FROM applications);"


echo "Delete orphaned maintenance data"
echo -n "Table: maintenances_groups orphaned maintenances: "
mysql_w "DELETE FROM maintenances_groups WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);"

echo -n "Table: maintenances_groups orphaned groups: "
mysql_w "DELETE FROM maintenances_groups WHERE groupid NOT IN (SELECT groupid FROM groups);"

echo -n "Table: maintenances_hosts orphaned maintenances: "
mysql_w "DELETE FROM maintenances_hosts WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);"

echo -n "Table: maintenances_hosts orphaned hosts: "
mysql_w "DELETE FROM maintenances_hosts WHERE hostid NOT IN (SELECT hostid FROM hosts);"

echo -n "Table: maintenances_windows orphaned maintenances: "
mysql_w "DELETE FROM maintenances_windows WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);"

echo -n "Table: maintenances_windows orphaned timeperiods: "
mysql_w "DELETE FROM maintenances_windows WHERE timeperiodid NOT IN (SELECT timeperiodid FROM timeperiods);"


echo "Delete orphaned mappings"
echo -n "Table: mappings orphaned valuemaps: "
mysql_w "DELETE FROM mappings WHERE NOT valuemapid IN (SELECT valuemapid FROM valuemaps);"


echo "Delete orphaned media items"
echo -n "Table: media orphaned users: "
mysql_w "DELETE FROM media WHERE NOT userid IN (SELECT userid FROM users);"

echo -n "Table: media orphaned media_types: "
mysql_w "DELETE FROM media WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);"

echo -n "Table: rights orphaned user groups: "
mysql_w "DELETE FROM rights WHERE NOT groupid IN (SELECT usrgrpid FROM usrgrp);"

echo -n "Table: rights orphaned groups: "
mysql_w "DELETE FROM rights WHERE NOT id IN (SELECT groupid FROM groups);"

echo -n "Table: sessions orphaned users: "
mysql_w "DELETE FROM sessions WHERE NOT userid IN (SELECT userid FROM users);"


echo "Cleanup screens"
echo -n "Table: screens_items orphaned screens: "
mysql_w "DELETE FROM screens_items WHERE screenid NOT IN (SELECT screenid FROM screens);"


echo "Cleanup Events & triggers"
echo -n "Table: trigger_depends orphaned triggers(triggerid_down): "
mysql_w "DELETE FROM trigger_depends WHERE triggerid_down NOT IN (SELECT triggerid FROM triggers);"

echo -n "Table: trigger_depends orphaned triggers(triggerid_up): "
mysql_w "DELETE FROM trigger_depends WHERE triggerid_up NOT IN (SELECT triggerid FROM triggers);"


echo "Delete records in the history/trends table where items that no longer exist"
TABLES=(history history_uint history_log history_str history_text trends trends_uint)
for table in "${TABLES[@]}"; do
        echo -n "Table: $table orphaned items: "
        mysql_w "DELETE FROM $table WHERE itemid NOT IN (SELECT itemid FROM items);"
done


echo "Delete records in the events table where triggers/items no longer exist"
echo -n "Table: events orphaned triggers(src=0, obj=0): "
mysql_w "DELETE FROM events WHERE source = 0 AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers);"

echo -n "Table: events orphaned triggers(src=3, obj=0): "
mysql_w "DELETE FROM events WHERE source = 3 AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers);"

echo -n "Table: events orphaned items(src=3, obj=4): "
mysql_w "DELETE FROM events WHERE source = 3 AND object = 4 AND objectid NOT IN (SELECT itemid FROM items);"


echo "Delete all orphaned acknowledge entries"
echo -n "Table: acknowledges orphaned events: "
mysql_w "DELETE FROM acknowledges WHERE NOT eventid IN (SELECT eventid FROM events);"

echo -n "Table: acknowledges orphaned users: "
mysql_w "DELETE FROM acknowledges WHERE NOT userid IN (SELECT userid FROM users);"

echo -n "Table: acknowledges orphaned events(src=0|3): "
mysql_w "DELETE FROM acknowledges WHERE eventid IN (SELECT eventid FROM events WHERE (source = 0 OR source=3) AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers));"

echo -n "Table: acknowledges orphaned events(src=3, obj=4): "
mysql_w "DELETE FROM acknowledges WHERE eventid IN (SELECT eventid FROM events WHERE source=3 AND object = 4 AND objectid NOT IN (SELECT itemid FROM items));"
