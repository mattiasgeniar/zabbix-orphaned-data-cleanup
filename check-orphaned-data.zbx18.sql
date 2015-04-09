-- Count the amount of rows that would be deleted for all orphaned acknowledge entries
SELECT COUNT(*) AS acknowedges_missing_user FROM acknowledges WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) AS acknowedges_missing_event FROM acknowledges WHERE NOT eventid IN (SELECT eventid FROM events);

-- Count the amount of rows that would be deleted for orphaned alerts entries
SELECT COUNT(*) AS alerts_missing_action FROM alerts WHERE NOT actionid IN (SELECT actionid FROM actions);
SELECT COUNT(*) AS alerts_missing_event FROM alerts WHERE NOT eventid IN (SELECT eventid FROM events);
SELECT COUNT(*) AS alerts_missing_user FROM alerts WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) AS alerts_missing_mediatype FROM alerts WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);

-- Count the amount of rows that would be deleted for orphaned application entries that no longer map back to a host
SELECT COUNT(*) AS applications_missing_host FROM applications WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned auditlog details (such as logins)
-- SELECT COUNT(*) AS auditlog_missing_details FROM auditlog_details WHERE NOT auditid IN (SELECT auditid FROM auditlog); -- This takes exponential time, disabled
SELECT COUNT(*) AS auditlog_missing_user FROM auditlog WHERE NOT userid IN (SELECT userid FROM users);

-- Count the amount of rows that would be deleted for orphaned conditions
SELECT COUNT(*) AS conditions_missing_acction FROM conditions WHERE NOT actionid IN (SELECT actionid FROM actions);

-- Count the amount of rows that would be deleted for orphaned functions
SELECT COUNT(*) AS functions_missing_item FROM functions WHERE NOT itemid IN (SELECT itemid FROM items);
SELECT COUNT(*) AS functions_missing_trigger FROM functions WHERE NOT triggerid IN (SELECT triggerid FROM triggers);

-- Count the amount of rows that would be deleted for orphaned graph items
SELECT COUNT(*) AS graph_items_missing_graphs FROM graphs_items WHERE NOT graphid IN (SELECT graphid FROM graphs);
SELECT COUNT(*) AS graph_items_missing_items FROM graphs_items WHERE NOT itemid IN (SELECT itemid FROM items);

-- Count the amount of records in the history/trends table for items that no longer exist
SELECT COUNT(itemid) AS history_missing_item FROM history WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) AS history_uint_missing_item FROM history_uint WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) AS history_log_missing_item FROM history_log WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) AS history_str_missing_item FROM history_str WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) AS history_sync_missing_item FROM history_sync WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) AS history_text_missing_item FROM history_text WHERE itemid NOT IN (SELECT itemid FROM items);

-- Count the amount of rows that would be deleted for orphaned host_profiles
SELECT COUNT(*) AS host_profiles_missing_hosts FROM hosts_profiles WHERE NOT hostid IN (SELECT hostid FROM hosts);
SELECT COUNT(*) AS host_profiles_external_missing_hosts FROM hosts_profiles_ext WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned host macro's
SELECT COUNT(*) AS host_macros_missing_hosts FROM hostmacro WHERE NOT hostid IN (SELECT hostid FROM hosts);

-- Count the amount of rows that would be deleted for orphaned item data
SELECT COUNT(itemid) AS items_missing_hosts FROM items WHERE hostid NOT IN (SELECT hostid FROM hosts);
SELECT COUNT(*) AS item_apps_missing_apps FROM items_applications WHERE applicationid NOT IN (SELECT applicationid FROM applications);
SELECT COUNT(*) AS item_apps_missing_items FROM items_applications WHERE itemid NOT IN (SELECT itemid FROM items);

-- Count the amount of rows that would be deleted for orphaned HTTP check data
SELECT COUNT(*) AS http_step_missing_tests FROM httpstep WHERE NOT httptestid IN (SELECT httptestid FROM httptest);
SELECT COUNT(*) AS http_step_items_missing_steps FROM httpstepitem WHERE NOT httpstepid IN (SELECT httpstepid FROM httpstep);
SELECT COUNT(*) AS http_step_items_missing_items FROM httpstepitem WHERE NOT itemid IN (SELECT itemid FROM items);
SELECT COUNT(*) AS http_test_missing_apps FROM httptest WHERE applicationid NOT IN (SELECT applicationid FROM applications);

-- Count the amount of rows that would be deleted for orphaned maintenance data
SELECT COUNT(*) AS maintenance_group_missing_maintenances FROM maintenances_groups WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) AS maintenance_group_missing_groups FROM maintenances_groups WHERE groupid NOT IN (SELECT groupid FROM groups);
SELECT COUNT(*) AS maintenances_hosts_missing_maintenances FROM maintenances_hosts WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) AS maintenances_hosts_missing_hosts FROM maintenances_hosts WHERE hostid NOT IN (SELECT hostid FROM hosts);
SELECT COUNT(*) AS maintenances_windows_missing_maintenances FROM maintenances_windows WHERE maintenanceid NOT IN (SELECT maintenanceid FROM maintenances);
SELECT COUNT(*) AS maintenances_windows_missing_windows FROM maintenances_windows WHERE timeperiodid NOT IN (SELECT timeperiodid FROM timeperiods);

-- Count the amount of rows that would be deleted for orphaned mappings
SELECT COUNT(*) AS mappings_missing_valuemap FROM mappings WHERE NOT valuemapid IN (SELECT valuemapid FROM valuemaps);

-- Count the amount of rows that would be deleted for orphaned media / user items
SELECT COUNT(*) AS media_missing_user FROM media WHERE NOT userid IN (SELECT userid FROM users);
SELECT COUNT(*) AS media_missing_type FROM media WHERE NOT mediatypeid IN (SELECT mediatypeid FROM media_type);
SELECT COUNT(*) AS rights_missing_user FROM rights WHERE NOT groupid IN (SELECT usrgrpid FROM usrgrp);
SELECT COUNT(*) AS rights_missing_group FROM rights WHERE NOT id IN (SELECT groupid FROM groups);

-- Count the amount of rows that would be deleted for orphaned screens
SELECT COUNT(*) AS screens_items_missing_screen FROM screens_items WHERE screenid NOT IN (SELECT screenid FROM screens);

SELECT COUNT(*) AS sessions_missing_user FROM sessions WHERE NOT userid IN (SELECT userid FROM users);

SELECT COUNT(itemid) AS trends_missing_item FROM trends WHERE itemid NOT IN (SELECT itemid FROM items);
SELECT COUNT(itemid) AS trends_uint_missing_item FROM trends_uint WHERE itemid NOT IN (SELECT itemid FROM items);

-- Count the amount of rows that would be deleted for orphaned events & triggers
SELECT COUNT(*) AS trigger_down_dependency_missing_trigger FROM trigger_depends WHERE triggerid_down NOT IN (SELECT triggerid FROM triggers);
SELECT COUNT(*) AS trigger_up_dependency_missing_trigger FROM trigger_depends WHERE triggerid_up NOT IN (SELECT triggerid FROM triggers);

SELECT COUNT(*) AS user_history_missing_user FROM user_history WHERE NOT userid IN (SELECT userid FROM users);
