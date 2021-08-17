-- Count the amount of rows that would be deleted for orphaned alerts entries
SELECT COUNT(*) FROM alerts WHERE NOT EXISTS (SELECT 1 FROM actions WHERE alerts.actionid = actions.actionid);
SELECT COUNT(*) FROM alerts WHERE NOT EXISTS (SELECT 1 FROM events WHERE alerts.eventid = events.eventid);
SELECT COUNT(*) FROM alerts WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) FROM alerts WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);

-- Count the amount of rows that would be deleted for orphaned application entries that no longer map back to a host
SELECT COUNT(*) FROM applications WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned auditlog details (such as logins)
SELECT COUNT(*) FROM auditlog_details WHERE NOT auditid IN (SELECT auditid FROM auditlog);
SELECT COUNT(*) FROM auditlog WHERE NOT userid IN (SELECT userid FROM users);

-- Count the amount of rows that would be deleted for orphaned conditions
SELECT COUNT(*) FROM conditions WHERE NOT actionid IN (SELECT actionid FROM actions);

-- Count the amount of rows that would be deleted for orphaned functions
SELECT COUNT(*) FROM functions WHERE NOT itemid IN (SELECT itemid FROM items);
SELECT COUNT(*) FROM functions WHERE NOT triggerid IN (SELECT triggerid FROM triggers);

-- Count the amount of rows that would be deleted for orphaned graph items
SELECT COUNT(*) FROM graphs_items WHERE NOT graphid IN (SELECT graphid FROM graphs);
SELECT COUNT(*) FROM graphs_items WHERE NOT itemid IN (SELECT itemid FROM items);

-- Count the amount of rows that would be deleted for orphaned host macro's
SELECT COUNT(*) FROM hostmacro WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned item data
SELECT COUNT(*) FROM items WHERE hostid NOT IN (SELECT hostid FROM hosts);
SELECT COUNT(*) FROM items_applications WHERE applicationid NOT IN (SELECT applicationid FROM applications);
SELECT COUNT(*) FROM items_applications WHERE itemid NOT IN (SELECT itemid FROM items);

-- Count the amount of rows that would be deleted for orphaned HTTP check data
SELECT COUNT(*) FROM httpstep WHERE NOT httptestid IN (SELECT httptestid FROM httptest);
SELECT COUNT(*) FROM httpstepitem WHERE NOT httpstepid IN (SELECT httpstepid FROM httpstep);
SELECT COUNT(*) FROM httpstepitem WHERE NOT itemid IN (SELECT itemid FROM items);
SELECT COUNT(*) FROM httptest WHERE applicationid NOT IN (SELECT applicationid FROM applications);

-- Count the amount of rows that would be deleted for orphaned maintenance data
SELECT COUNT(*) FROM maintenances_groups WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) FROM maintenances_groups WHERE groupid NOT IN (SELECT groupid FROM groups);
SELECT COUNT(*) FROM maintenances_hosts WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) FROM maintenances_hosts WHERE hostid NOT IN (SELECT hostid FROM hosts);
SELECT COUNT(*) FROM maintenances_windows WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) FROM maintenances_windows WHERE timeperiodid NOT IN (SELECT timeperiodid FROM timeperiods);

-- Count the amount of rows that would be deleted for orphaned mappings
SELECT COUNT(*) FROM mappings WHERE NOT valuemapid IN (SELECT valuemapid FROM valuemaps);

-- Count the amount of rows that would be deleted for orphaned media items
SELECT COUNT(*) FROM media WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) FROM media WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);
SELECT COUNT(*) FROM rights WHERE NOT groupid IN (SELECT usrgrpid FROM usrgrp);
SELECT COUNT(*) FROM rights WHERE NOT id IN (SELECT groupid FROM groups);
SELECT COUNT(*) FROM sessions WHERE NOT userid IN (SELECT userid FROM users);

-- Count the amount of rows that would be deleted for orphaned screens
SELECT COUNT(*) FROM screens_items WHERE screenid NOT IN (SELECT screenid FROM screens);

-- Count the amount of rows that would be deleted for orphaned events & triggers
SELECT COUNT(*) FROM trigger_depends WHERE triggerid_down NOT IN (SELECT triggerid FROM triggers);
SELECT COUNT(*) FROM trigger_depends WHERE triggerid_up NOT IN (SELECT triggerid FROM triggers);

-- Count the amount of records in the history/trends table for items that no longer exist
SELECT COUNT(itemid) FROM history WHERE NOT EXISTS (SELECT 1 FROM items WHERE history.itemid = items.itemid);
SELECT COUNT(itemid) FROM history_uint WHERE NOT EXISTS (SELECT 1 FROM items WHERE history_uint.itemid = items.itemid);
SELECT COUNT(itemid) FROM history_log WHERE NOT EXISTS (SELECT 1 FROM items WHERE history_log.itemid = items.itemid);
SELECT COUNT(itemid) FROM history_str WHERE NOT EXISTS (SELECT 1 FROM items WHERE history_str.itemid = items.itemid);
SELECT COUNT(itemid) FROM history_text WHERE NOT EXISTS (SELECT 1 FROM items WHERE history_text.itemid = items.itemid);

SELECT COUNT(itemid) FROM trends WHERE NOT EXISTS (SELECT 1 FROM items WHERE trends.itemid = items.itemid);
SELECT COUNT(itemid) FROM trends_uint WHERE NOT EXISTS (SELECT 1 FROM items WHERE trends_uint.itemid = items.itemid);

-- Count the amount of records in the events table for triggers/items that no longer exist
SELECT COUNT(eventid) FROM events WHERE source = 0 AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers);
SELECT COUNT(eventid) FROM events WHERE source = 3 AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers);
SELECT COUNT(eventid) FROM events WHERE source = 3 AND object = 4 AND objectid NOT IN (SELECT itemid FROM items);

-- Count the amount of acknowledges in the acknowledges table for events which would be deleted previously
SELECT COUNT(*) FROM acknowledges WHERE NOT eventid IN (SELECT eventid FROM events);
SELECT COUNT(*) FROM acknowledges WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(acknowledgeid) FROM acknowledges WHERE eventid IN (SELECT eventid FROM events WHERE (source = 0 OR source=3) AND object = 0 AND objectid NOT IN (SELECT triggerid FROM triggers));
SELECT COUNT(acknowledgeid) FROM acknowledges WHERE eventid IN (SELECT eventid FROM events WHERE source=3 AND object = 4 AND objectid NOT IN (SELECT itemid FROM items));

-- Count the amount of records in the housekeep table for items that no longe exist

SELECT COUNT(*) FROM housekeeper WHERE NOT value IN (select itemid from items);
