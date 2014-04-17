update alerts set status=2,error='' where status=0 and alerttype=0;
truncate escalations;
