delete from history where itemid not in (select itemid from items where status='0');
delete from history_uint where itemid not in (select itemid from items where status='0');
delete from history_str where itemid not in (select itemid from items where status='0');
delete from history_text where itemid not in (select itemid from items where status='0');
delete from history_log where itemid not in (select itemid from items where status='0');

delete from trends where itemid not in (select itemid from items where status='0');
delete from trends_uint where itemid not in (select itemid from items where status='0');
