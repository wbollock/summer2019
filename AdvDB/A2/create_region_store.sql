/*
A character set is a set of symbols and encodings. 
A collation is a set of rules for comparing characters in a character set.

Suppose that we have an alphabet with four letters: "A", "B", "a", "b". 
We give each letter a number: "A" = 0, "B" = 1, "a" = 2, "b" = 3. 
The letter "A" is a symbol, the number 0 is the encoding for "A", and the combination of all four letters and their encodings is a character set. 

http://dev.mysql.com/doc/refman/5.5/en/charset.html
http://www.go4expert.com/forums/showthread.php?t=21166
*/

SHOW WARNINGS;
-- Table region
-- following line will show warning (no region table)
DROP TABLE IF EXISTS region;
CREATE  TABLE IF NOT EXISTS region 
(
  region_code INT NOT NULL AUTO_INCREMENT,
  region_descript VARCHAR(45) NULL,
  PRIMARY KEY (region_code)
)
ENGINE = InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

SHOW WARNINGS;

-- Table store
-- following line will show warning (no store table)
DROP TABLE IF EXISTS store;
CREATE  TABLE IF NOT EXISTS store
(
  store_code INT NOT NULL AUTO_INCREMENT,
  store_name VARCHAR(45) NULL COMMENT 'comments go here',
  store_ytd_sales DECIMAL(10,2) NULL,
  region_code INT NULL,
  PRIMARY KEY (store_code),

  -- create index for foreign key
  INDEX idx_store_region (region_code ASC),

  -- create foreign key	
  CONSTRAINT fk_store_region
    FOREIGN KEY (region_code)
    REFERENCES region (region_code)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
ENGINE = InnoDB CHARACTER SET utf8 COLLATE utf8_general_ci;

SHOW WARNINGS;

-- Data for table region
-- following line not necessary, only for demo purposes (MySQL auto commits by default)
SET AUTOCOMMIT=0;
INSERT INTO region
(region_code, region_descript)
VALUES
(NULL, 'East'),
(NULL, 'West');
COMMIT;

-- Data for table store
-- following line not necessary, only for demo purposes (MySQL auto commits by default)
SET AUTOCOMMIT=0;
INSERT INTO store
(store_code, store_name, store_ytd_sales, region_code)
VALUES
(NULL, 'Access Junction', 1003455.76, 2),
(NULL, 'Database Corner', 1421987.39, 2),
(NULL, 'Tuple Charge', 986783.22, 1),
(NULL, 'Attribute Alley', 944568.56, 2),
(NULL, 'Primary Key Point', 2930098.45, 1);
COMMIT;
