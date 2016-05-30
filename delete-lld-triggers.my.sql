DELETE FROM triggers
WHERE description LIKE 'Free disk space is less than 20|%%'
ESCAPE '|'
AND NOT description LIKE '%{#FSNAME}%';
