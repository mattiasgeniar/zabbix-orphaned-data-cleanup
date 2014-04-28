DELETE FROM history WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
DELETE FROM history_uint WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
DELETE FROM history_str WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
DELETE FROM history_text WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
DELETE FROM history_log WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');

DELETE FROM trends WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
DELETE FROM trends_uint WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
