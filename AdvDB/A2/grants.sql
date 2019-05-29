;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with C-x C-f and enter text in its buffer.

limit user1 to all privilege
sonly w/in lis3781database

imit user2 to select privileges
only w/in lis3781database,table store


mysql> Grant all privileges on lis3781 to user1@"localhost" identified by 'test1'
    -> ;
Query OK, 0 rows affected (0.00 sec)

mysql> Grant select on lis3781.store to user2@"localhost" identified by 'test2';
Query OK, 0 rows affected (0.00 sec)


mysql> mysql> show grants;
+---------------------------------------------------------------------------+
| Grants for user1@localhost                                                |
+---------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'user1'@'localhost' IDENTIFIED BY PASSWORD <secret> |
| GRANT ALL PRIVILEGES ON `lis3781`.`lis3781` TO 'user1'@'localhost'        |
+---------------------------------------------------------------------------+
2 rows in set (0.00 sec)

mysql> 


mysql> show grants;
+---------------------------------------------------------------------------+
| Grants for user2@localhost                                                |
+---------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'user2'@'localhost' IDENTIFIED BY PASSWORD <secret> |
| GRANT SELECT ON `lis3781`.`store` TO 'user2'@'localhost'                  |
+---------------------------------------------------------------------------+
2 rows in set (0.00 sec)
