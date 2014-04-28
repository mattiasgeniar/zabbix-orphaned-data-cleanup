UPDATE alerts SET status=2,error='' WHERE status=0 AND alerttype=0;
TRUNCATE escalations;
