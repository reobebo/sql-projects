INSERT INTO Customer ( name, address, city, state, zip ) VALUES ( 'Fred Flintstone' ,'123 Cobblestone Way', 'Bedrock', 'IL', '60106' );
SELECT * FROM Customer;

UPDATE Customer SET Address = '123 Music Avenue' , Zip='98808' WHERE id = 5;
SELECT * FROM Customer;

DELETE FROM Customer WHERE id=5;
SELECT * FROM Customer;

CREATE TABLE test (a INTEGER, b TEXT, c TEXT);
INSERT INTO test (a,b,c)  VALUES (1,'this','over here!');
SELECT * FROM test; 

INSERT INTO test (a,b,c) SELECT id, name, description FROM item;
SELECT * FROM test; 

DELETE FROM test WHERE a = 3;
SELECT * FROM test; 

DELETE FROM test WHERE a=1;
SELECT * FROM test;

SELECT * FROM test WHERE a IS NOT NULL;

INSERT INTO test (a, b, c) VALUES (0,NULL,'');
SELECT * FROM test;

SELECT * FROM test WHERE c='';

DROP TABLE test;
CREATE TABLE test(
a INTEGER NOT NULL,
b TEXT NOT NULL,
c TEXT 
);
INSERT INTO test VALUES (1, 'this', 'that');
SELECT * FROM test;

CREATE TABLE test (a TEXT, b TEXT, c TEXT);
INSERT INTO test VALUES ( 'one','two','three' );
INSERT INTO test VALUES ( 'two','three','four' );
INSERT INTO test VALUES ( 'three','four','five' );
SELECT * FROM test;

ALTER TABLE test ADD d TEXT;

SELECT * FROM test;

CREATE TABLE test (a INT, b INT); 
INSERT INTO test VALUES (1,1);
INSERT INTO test VALUES (2,1);
INSERT INTO test VALUES (3,1);
INSERT INTO test VALUES (4,1);
INSERT INTO test VALUES (5,1);
INSERT INTO test VALUES (6,2);
INSERT INTO test VALUES (7,2);
INSERT INTO test VALUES (8,2);
INSERT INTO test VALUES (9,2);
INSERT INTO test VALUES (10,2);
SELECT * FROM test;

SELECT DISTINCT b FROM test;
SELECT * FROM test;


CREATE TABLE left ( id INTEGER, description TEXT );
CREATE TABLE right ( id INTEGER, description TEXT );

INSERT INTO left VALUES ( 1, 'left 01' );
INSERT INTO left VALUES ( 2, 'left 02' );
INSERT INTO left VALUES ( 3, 'left 03' );
INSERT INTO left VALUES ( 4, 'left 04' );
INSERT INTO left VALUES ( 5, 'left 05' );
INSERT INTO left VALUES ( 6, 'left 06' );
INSERT INTO left VALUES ( 7, 'left 07' );
INSERT INTO left VALUES ( 8, 'left 08' );
INSERT INTO left VALUES ( 9, 'left 09' );

INSERT INTO right VALUES ( 6, 'right 06' );
INSERT INTO right VALUES ( 7, 'right 07' );
INSERT INTO right VALUES ( 8, 'right 08' );
INSERT INTO right VALUES ( 9, 'right 09' );
INSERT INTO right VALUES ( 10, 'right 10' );
INSERT INTO right VALUES ( 11, 'right 11' );
INSERT INTO right VALUES ( 11, 'right 12' );
INSERT INTO right VALUES ( 11, 'right 13' );
INSERT INTO right VALUES ( 11, 'right 14' );

SELECT l.description AS left, r.description AS right
FROM left AS l
JOIN right AS r
ON l.id = r.id
;
SELECT * FROM left;
SELECT * FROM right;

SELECT l.description AS left, r.description AS right
FROM left AS l
JOIN right AS r
ON l.id = r.id
;
SELECT * FROM left;
SELECT * FROM right;


CREATE TABLE widgetInventory (
  id INTEGER PRIMARY KEY,
  description TEXT,
  onhand INTEGER NOT NULL
);

CREATE TABLE widgetSales (
  id INTEGER PRIMARY KEY,
  inv_id INTEGER,
  quan INTEGER,
  price INTEGER
);

INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'rock', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'paper', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'scissors', 25 );

SELECT * FROM widgetInventory;

BEGIN TRANSACTION;
INSERT INTO widgetSales ( inv_id, quan, price ) VALUES ( 1, 5, 500 );
UPDATE widgetInventory SET onhand = ( onhand - 5 ) WHERE id = 1;
END TRANSACTION;

SELECT * FROM widgetInventory;
SELECT * FROM widgetSales;


BEGIN TRANSACTION;
INSERT INTO widgetInventory (description, onhand) VALUES ('toy', 25);
ROLLBACK;

SELECT * FROM widgetInventory;
SELECT * FROM widgetSales;

CREATE TABLE widgetCustomer ( id INTEGER PRIMARY KEY, name TEXT, last_order_id INT );
CREATE TABLE widgetSale ( id INTEGER PRIMARY KEY, item_id INT, customer_id INT, quan INT, price INT );

INSERT INTO widgetCustomer (name) VALUES ('Bob');
INSERT INTO widgetCustomer (name) VALUES ('Sally');
INSERT INTO widgetCustomer (name) VALUES ('Fred');

SELECT * FROM widgetCustomer;

SELECT * FROM widgetCustomer;

CREATE TRIGGER newWidgetSale AFTER INSERT ON widgetSale
    BEGIN
        UPDATE widgetCustomer SET last_order_id = NEW.id WHERE widgetCustomer.id = NEW.customer_id;
    END
;

DROP TABLE IF EXISTS widgetSale;

CREATE TABLE widgetSale ( id integer primary key, item_id INT, customer_id INTEGER, quan INT, price INT,
    reconciled INT );
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (1, 3, 5, 1995, 0);
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (2, 2, 3, 1495, 1);
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (3, 1, 1, 2995, 0);
SELECT * FROM widgetSale;

CREATE TRIGGER updateWidgetSale BEFORE UPDATE ON widgetSale
    BEGIN
        SELECT RAISE(ROLLBACK, 'cannot update table "widgetSale"') FROM widgetSale
            WHERE id = NEW.id AND reconciled = 1;
    END
;

BEGIN TRANSACTION;
UPDATE widgetSale SET quan = 9 WHERE id = 3;
END TRANSACTION;

SELECT * FROM widgetSale;

DROP TABLE IF EXISTS widgetSale;
DROP TABLE IF EXISTS widgetCustomer;

CREATE TABLE widgetCustomer ( id integer primary key, name TEXT, last_order_id INT, stamp TEXT );
CREATE TABLE widgetSale ( id integer primary key, item_id INT, customer_id INTEGER, quan INT, price INT, stamp TEXT );
CREATE TABLE widgetLog ( id integer primary key, stamp TEXT, event TEXT, username TEXT, tablename TEXT, table_id INT);

INSERT INTO widgetCustomer (name) VALUES ('Bob');
INSERT INTO widgetCustomer (name) VALUES ('Sally');
INSERT INTO widgetCustomer (name) VALUES ('Fred');
SELECT * FROM widgetCustomer;

CREATE TRIGGER stampSale AFTER INSERT ON widgetSale
    BEGIN
        UPDATE widgetSale SET stamp = DATETIME('now') WHERE id = NEW.id;
        UPDATE widgetCustomer SET last_order_id = NEW.id, stamp = DATETIME('now')
            WHERE widgetCustomer.id = NEW.customer_id;
        INSERT INTO widgetLog (stamp, event, username, tablename, table_id)
            VALUES (DATETIME('now'), 'INSERT', 'TRIGGER', 'widgetSale', NEW.id);
    END
;


INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (1, 3, 5, 1995);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (2, 2, 3, 1495);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (3, 1, 1, 2995);

SELECT * FROM widgetSale;
SELECT * FROM widgetCustomer;
SELECT * FROM widgetLog;



CREATE TABLE t ( a TEXT, b TEXT );
INSERT INTO t VALUES ( 'NY0123', 'US4567' );
INSERT INTO t VALUES ( 'AZ9437', 'GB1234' );
INSERT INTO t VALUES ( 'CA1279', 'FR5678' );
SELECT * FROM t;

