-- Delete all orphaned acknowledge entries 
DELETE FROM acknowledges WHERE NOT userid IN (SELECT userid FROM users);
DELETE FROM acknowledges WHERE NOT eventid IN (SELECT eventid FROM events);

-- Delete orphaned alerts entries 
DELETE FROM alerts WHERE NOT actionid IN (SELECT actionid FROM actions);
DELETE FROM alerts WHERE NOT eventid IN (SELECT eventid FROM events);
DELETE FROM alerts WHERE NOT userid IN (SELECT userid FROM users);
DELETE FROM alerts WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);

-- Delete orphaned application entries that no longer map back to a host 
DELETE FROM applications WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Delete orphaned auditlog details (such as logins) 
DELETE FROM auditlog_details WHERE NOT auditid IN (SELECT auditid FROM auditlog);
DELETE FROM auditlog WHERE NOT userid IN (SELECT userid FROM users);

-- Delete orphaned conditions 
DELETE FROM conditions WHERE NOT actionid IN (SELECT actionid FROM actions);

-- Delete orphaned functions 
DELETE FROM functions WHERE NOT itemid IN (SELECT itemid FROM items);
DELETE FROM functions WHERE NOT triggerid IN (SELECT triggerid FROM triggers);

-- Delete orphaned graph items 
DELETE FROM graphs_items WHERE NOT graphid IN (SELECT graphid FROM graphs);
DELETE FROM graphs_items WHERE NOT itemid IN (SELECT itemid FROM items);

-- Delete orphaed host_profiles 
DELETE FROM hosts_profiles WHERE NOT hostid IN (SELECT hostid FROM hosts);
DELETE FROM hosts_profiles_ext WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Delete orphaned host macro's 
DELETE FROM hostmacro WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Delete orphaned item data 
DELETE FROM items WHERE hostid NOT IN (SELECT hostid FROM hosts);
DELETE FROM items_applications WHERE applicationid NOT IN (SELECT applicationid FROM applications);
DELETE FROM items_applications WHERE itemid NOT IN (SELECT itemid FROM items);

-- Delete orphaned HTTP check data 
DELETE FROM httpstep WHERE NOT httptestid IN (SELECT httptestid FROM httptest);
DELETE FROM httpstepitem WHERE NOT httpstepid IN (SELECT httpstepid FROM httpstep);
DELETE FROM httpstepitem WHERE NOT itemid IN (SELECT itemid FROM items);
DELETE FROM httptest WHERE applicationid NOT IN (SELECT applicationid FROM applications);

-- Delete orphaned maintenance data 
DELETE FROM maintenances_groups WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
DELETE FROM maintenances_groups WHERE groupid NOT IN (SELECT groupid FROM groups);
DELETE FROM maintenances_hosts WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
DELETE FROM maintenances_hosts WHERE hostid NOT IN (SELECT hostid FROM hosts);
DELETE FROM maintenances_windows WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
DELETE FROM maintenances_windows WHERE timeperiodid NOT IN (SELECT timeperiodid FROM timeperiods);

-- Delete orphaned mappings 
DELETE FROM mappings WHERE NOT valuemapid IN (SELECT valuemapid FROM valuemaps);

-- Delete orphaned media / user items 
DELETE FROM media WHERE NOT userid IN (SELECT userid FROM users);
DELETE FROM media WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);
DELETE FROM rights WHERE NOT groupid IN (SELECT usrgrpid FROM usrgrp);
DELETE FROM rights WHERE NOT id IN (SELECT groupid FROM groups);
DELETE FROM sessions WHERE NOT userid IN (SELECT userid FROM users);
DELETE FROM user_history WHERE NOT userid IN (SELECT userid FROM users);

-- Screens 
DELETE FROM screens_items WHERE screenid NOT IN (SELECT screenid FROM screens);

-- Events & triggers 
DELETE FROM trigger_depends WHERE triggerid_down NOT IN (SELECT triggerid FROM triggers);
DELETE FROM trigger_depends WHERE triggerid_up NOT IN (SELECT triggerid FROM triggers);

-- Count the amount of records in the history/trends table for items that no longer exist
DELETE FROM history WHERE itemid NOT IN (SELECT itemid FROM items);
DELETE FROM history_uint WHERE itemid NOT IN (SELECT itemid FROM items);
DELETE FROM history_log WHERE itemid NOT IN (SELECT itemid FROM items);
DELETE FROM history_str WHERE itemid NOT IN (SELECT itemid FROM items);
DELETE FROM history_sync WHERE itemid NOT IN (SELECT itemid FROM items);
DELETE FROM history_text WHERE itemid NOT IN (SELECT itemid FROM items);

DELETE FROM trends WHERE itemid NOT IN (SELECT itemid FROM items);
DELETE FROM trends_uint WHERE itemid NOT IN (SELECT itemid FROM items);
