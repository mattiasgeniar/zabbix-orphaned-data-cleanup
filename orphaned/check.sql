-- Count the amount of rows that would be deleted for all orphaned acknowledge entries
SELECT COUNT(*) AS ACK_MISSING_UID FROM acknowledges WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) AS ACK_MISSING_EID FROM acknowledges WHERE NOT eventid IN (SELECT eventid FROM events);

-- Count the amount of rows that would be deleted for orphaned alerts entries
SELECT COUNT(*) AS ALERTS_MISSING_AID FROM alerts WHERE NOT actionid IN (SELECT actionid FROM actions);
SELECT COUNT(*) AS ALERTS_MISSING_EID FROM alerts WHERE NOT eventid IN (SELECT eventid FROM events);
SELECT COUNT(*) AS ALERTS_MISSING_UID FROM alerts WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) AS ALERTS_MISSING_MID FROM alerts WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);

-- Count the amount of rows that would be deleted for orphaned application entries that no longer map back to a host
SELECT COUNT(*) AS APPS_MISSING_HID FROM applications WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned auditlog details (such as logins)
SELECT COUNT(*) AS AUDITLOG_MISSING_AID FROM auditlog_details WHERE NOT auditid IN (SELECT auditid FROM auditlog);
SELECT COUNT(*) AS AUDITLOG_MISSING_UID FROM auditlog WHERE NOT userid IN (SELECT userid FROM users);

-- Count the amount of rows that would be deleted for orphaned conditions
SELECT COUNT(*) AS COND_MISSING_AID FROM conditions WHERE NOT actionid IN (SELECT actionid FROM actions);

-- Count the amount of rows that would be deleted for orphaned functions
SELECT COUNT(*) AS FUNC_MISSING_IID FROM functions WHERE NOT itemid IN (SELECT itemid FROM items);
SELECT COUNT(*) AS FUNC_MISSING_TID FROM functions WHERE NOT triggerid IN (SELECT triggerid FROM triggers);

-- Count the amount of rows that would be deleted for orphaned graph items
SELECT COUNT(*) AS GRAPHS_MISSING_GID FROM graphs_items WHERE NOT graphid IN (SELECT graphid FROM graphs);
SELECT COUNT(*) AS GRAPHS_MISSING_IID FROM graphs_items WHERE NOT itemid IN (SELECT itemid FROM items);

-- Count the amount of rows that would be deleted for orphaned host_profiles
SELECT COUNT(*) AS HOSTPROFS_MISSING_HID FROM hosts_profiles WHERE NOT hostid IN (SELECT hostid FROM hosts);
SELECT COUNT(*) AS HOSTPROFEXT_MISSING_HID FROM hosts_profiles_ext WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned host macro's
SELECT COUNT(*) AS HOSTMACRO_MISSING_HID FROM hostmacro WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned item data
SELECT COUNT(*) AS ITEMS_MISSING_HID FROM items WHERE hostid NOT IN (SELECT hostid FROM hosts);
SELECT COUNT(*) AS ITEMSAPP_MISSING_AID FROM items_applications WHERE applicationid NOT IN (SELECT applicationid FROM applications);
SELECT COUNT(*) AS ITEMSAPP_MISSING_IID FROM items_applications WHERE itemid NOT IN (SELECT itemid FROM items);

-- Count the amount of rows that would be deleted for orphaned HTTP check data
SELECT COUNT(*) AS HTTPST_MISSING_HID FROM httpstep WHERE NOT httptestid IN (SELECT httptestid FROM httptest);
SELECT COUNT(*) AS HTTPSTI_MISSING_HSID FROM httpstepitem WHERE NOT httpstepid IN (SELECT httpstepid FROM httpstep);
SELECT COUNT(*) AS ITEMSSTI_MISSING_IID FROM httpstepitem WHERE NOT itemid IN (SELECT itemid FROM items);
SELECT COUNT(*) AS HTTPT_MISSING_AID FROM httptest WHERE applicationid NOT IN (SELECT applicationid FROM applications);

-- Count the amount of rows that would be deleted for orphaned maintenance data
SELECT COUNT(*) FROM maintenances_groups WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) FROM maintenances_groups WHERE groupid NOT IN (SELECT groupid FROM groups);
SELECT COUNT(*) FROM maintenances_hosts WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) FROM maintenances_hosts WHERE hostid NOT IN (SELECT hostid FROM hosts);
SELECT COUNT(*) FROM maintenances_windows WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) FROM maintenances_windows WHERE timeperiodid NOT IN (SELECT timeperiodid FROM timeperiods);

-- Count the amount of rows that would be deleted for orphaned mappings
SELECT COUNT(*) FROM mappings WHERE NOT valuemapid IN (SELECT valuemapid FROM valuemaps);

-- Count the amount of rows that would be deleted for orphaned media / user items
SELECT COUNT(*) FROM media WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) FROM media WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);
SELECT COUNT(*) FROM rights WHERE NOT groupid IN (SELECT usrgrpid FROM usrgrp);
SELECT COUNT(*) FROM rights WHERE NOT id IN (SELECT groupid FROM groups);
SELECT COUNT(*) FROM sessions WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) FROM user_history WHERE NOT userid IN (SELECT userid FROM users);

-- Count the amount of rows that would be deleted for orphaned screens
SELECT COUNT(*) FROM screens_items WHERE screenid NOT IN (SELECT screenid FROM screens);

-- Count the amount of rows that would be deleted for orphaned events & triggers
SELECT COUNT(*) FROM trigger_depends WHERE triggerid_down NOT IN (SELECT triggerid FROM triggers);
SELECT COUNT(*) FROM trigger_depends WHERE triggerid_up NOT IN (SELECT triggerid FROM triggers);

-- Count the amount of records in the history/trends table for items that no longer exist
SELECT COUNT(itemid) FROM history WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) FROM history_uint WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) FROM history_log WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) FROM history_str WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) FROM history_sync WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) FROM history_text WHERE itemid NOT IN (SELECT itemid FROM items);

SELECT COUNT(itemid) FROM trends WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) FROM trends_uint WHERE itemid NOT IN (SELECT itemid FROM items);
