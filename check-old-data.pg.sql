-- intevals in days
\set history_interval 7
\set trends_interval 90

SELECT count(alertid) AS alerts FROM alerts WHERE age(to_timestamp(alerts.clock)) > (:history_interval * interval '1 day');

SELECT count(acknowledgeid) AS acknowledges FROM acknowledges WHERE age(to_timestamp(acknowledges.clock)) > (:history_interval * interval '1 day');

SELECT count(eventid) AS events FROM events WHERE age(to_timestamp(events.clock)) > (:history_interval * interval '1 day');

SELECT count(itemid) AS history FROM history WHERE age(to_timestamp(history.clock)) > (:history_interval * interval '1 day');
SELECT count(itemid) AS history_uint FROM history_uint WHERE age(to_timestamp(history_uint.clock)) > (:history_interval * interval '1 day') ;
SELECT count(itemid) AS history_str FROM history_str WHERE age(to_timestamp(history_str.clock)) > (:history_interval * interval '1 day') ;
SELECT count(itemid) AS history_text FROM history_text WHERE age(to_timestamp(history_text.clock)) > (:history_interval * interval '1 day') ;
SELECT count(itemid) AS history_log FROM history_log WHERE age(to_timestamp(history_log.clock)) > (:history_interval * interval '1 day') ;

SELECT count(itemid) AS trends FROM trends WHERE age(to_timestamp(trends.clock)) > (:trends_interval * interval '1 day');
SELECT count(itemid) AS trends_uint FROM trends_uint WHERE age(to_timestamp(trends_uint.clock)) > (:trends_interval * interval '1 day') ;
