UPDATE person
SET photo_url = CASE 
    WHEN id > 0 THEN 'https://t3.ftcdn.net/jpg/02/98/52/16/360_F_298521630_B1PqOqRpWyGYWLzacrBfVPkbK6qhUUvW.jpg'
    ELSE photo_url
END
WHERE id <= 18;
