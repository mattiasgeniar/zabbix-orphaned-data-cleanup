-- keep 1 week of history and 3 months of trends
\set history_interval 7
\set trends_interval 90

DELETE FROM alerts where age(to_timestamp(alerts.clock)) > (:history_interval * interval '1 day');

DELETE FROM acknowledges where age(to_timestamp(acknowledges.clock)) > (:history_interval * interval '1 day');

DELETE FROM events where age(to_timestamp(events.clock)) > (:history_interval * interval '1 day');

DELETE FROM history where age(to_timestamp(history.clock)) > (:history_interval * interval '1 day');
DELETE FROM history_uint where age(to_timestamp(history_uint.clock)) > (:history_interval * interval '1 day') ;
DELETE FROM history_str where age(to_timestamp(history_str.clock)) > (:history_interval * interval '1 day') ;
DELETE FROM history_text where age(to_timestamp(history_text.clock)) > (:history_interval * interval '1 day') ;
DELETE FROM history_log where age(to_timestamp(history_log.clock)) > (:history_interval * interval '1 day') ;

DELETE FROM trends where age(to_timestamp(trends.clock)) > (:trends_interval * interval '1 day');
DELETE FROM trends_uint where age(to_timestamp(trends_uint.clock)) > (:trends_interval * interval '1 day') ;
