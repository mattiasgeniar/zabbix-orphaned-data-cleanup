SELECT count(itemid) AS history FROM history WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
SELECT count(itemid) AS history_uint FROM history_uint WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
SELECT count(itemid) AS history_str FROM history_str WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
SELECT count(itemid) AS history_text FROM history_text WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
SELECT count(itemid) AS history_log FROM history_log WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');

SELECT count(itemid) AS trends FROM trends WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
SELECT count(itemid) AS trends_uint FROM trends_uint WHERE itemid NOT IN (SELECT itemid FROM items WHERE status='0');
