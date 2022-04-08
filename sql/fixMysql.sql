## this will fix the permissions so that you can access mysql
## using the default account and default password for your VM
##
## after executing this, you will be able to access mysql
## in "super user" mode with the cscstudent account in the
## following manner:
##
##  mysql -u cscstudent -pcscst*dent
##
###############################################################
GRANT ALL ON *.* TO 'cscstudent'@'localhost' WITH GRANT OPTION;
ALTER USER 'cscstudent'@'localhost' IDENTIFIED BY 'cscst*dent';
FLUSH TABLES;
FLUSH PRIVILEGES;
