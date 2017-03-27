# Test basic psycopg functionality

# Sample code snippets for working with psycopg


import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to the database
conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

#Create the Database

try:
    # CREATE DATABASE can't run inside a transaction
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute("CREATE DATABASE test_db")
    cur.close()
    conn.close()
except:
    print "Could not create test_db"


#Connecting to test_db

conn = psycopg2.connect(database="test_db", user="postgres", password="pass", host="localhost", port="5432")

#Create a Table
#The first step is to create a cursor. 

cur = conn.cursor()
cur.execute('''CREATE TABLE test_table
       (word TEXT PRIMARY KEY     NOT NULL,
       count INT     NOT NULL);''')
conn.commit()
print "Affected row first operation:", cur.rowcount
# Insert a record.  First create a cursor
cur = conn.cursor()

#Insert
cur.execute("INSERT INTO test_table (word,count) \
      VALUES ('test', 1)");
conn.commit()
print "Affected row second operation:", cur.rowcount

#Using variables to update
uCount=5
uWord="test"
cur.execute("UPDATE test_table SET count=%s WHERE word=%s", (uCount, uWord))
conn.commit()
print "Affected row third operation:", cur.rowcount

#Wrapping in a WITH context manager
with conn:
    with conn.cursor() as curs:
        curs.execute("INSERT INTO test_table (word,count) \
                      VALUES ('apple', 2)")
print "Affected row fourth operation:", curs.rowcount

# Now trying to update a non-existent value
uCount=5
uWord="panda"
cur.execute("UPDATE test_table SET count=%s WHERE word=%s", (uCount, uWord))
conn.commit()
print "Affected row fifth operation:", cur.rowcount

#Wrapping non-existent update using a WITH context manager
uCount=5
uWord="panda"
with conn:
    with conn.cursor() as curs:
        curs.execute("UPDATE test_table SET count=%s WHERE word=%s", (uCount, uWord))
print "Affected row sixth operation:", curs.rowcount

# Trying an UPDATE first and then doing an INSERT if that failed
uCount=5
uWord="panda"
with conn:
    with conn.cursor() as curs:
        curs.execute("UPDATE test_table SET count=%s WHERE word=%s", (uCount, uWord))
print "Affected row seventh operation:", curs.rowcount
if curs.rowcount == 0:
    with conn:
        with conn.cursor() as curs:
            curs.execute("INSERT INTO test_table (word,count) VALUES (%s, %s)", (uWord, uCount))
print "Affected row eighth operation:", curs.rowcount

# Incrementing an existing value by 1
uWord="panda"
with conn:
    with conn.cursor() as curs:
        curs.execute("UPDATE test_table SET count=count + 1 WHERE word=%s", (uWord,))
print "Affected row ninth operation:", curs.rowcount


# Close connection at the end
conn.close()
