CREATE DATABASE wordpress;

CREATE USER 'wpuser'@'%' IDENTIFIED BY 'password';
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;