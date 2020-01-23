library(DBI)
library(RSQLite)

# Connect to the database
con <- dbConnect(SQLite(), dbname = "dataset_2.db")

# Create the table A
dbGetQuery(con, '
CREATE TABLE A (
  x INT, 
  y VARCHAR(1)
);
           ')

# Insert records into table A
dbGetQuery(con, '
INSERT INTO A 
VALUES (1, \'a\'), 
       (2, \'a\'), 
       (2, \'b\');
           ')

# Create a View
dbGetQuery(con,'
CREATE VIEW B AS 
SELECT * FROM A 
  WHERE y = \'a\';           
           ')

# Extract the content of the view as
dbGetQuery(con,'
SELECT * FROM B;           
           ')

# 1. Let insert another record (3, 'a') into table A
# Then look at view B. What happens?
dbGetQuery(con, '
           INSERT INTO A
           VALUES (3, \'a\')
           ')

# 2. Delete all records in A where x equals 2.
# What happens to the view B?
dbSendQuery(con,'
   DELETE FROM A
  WHERE x = 2;
           ')

# 3. What happens if we update B by increasing x by 1 unit?
dbSendQuery(con, '
          UPDATE B
          SET x = x + 1;
            ')
#cannot modify B because it is a view