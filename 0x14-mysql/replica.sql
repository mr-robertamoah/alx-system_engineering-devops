CREATE USER 'replica_user'@'%' IDENTIFIED WITH mysql_native_password BY 'replica1234';

GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';

GRANT SELECT ON mysql.user TO 'holberton_user'@'localhost';
