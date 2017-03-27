# Creates the database and tables to store words and counts from the Tweet
# streaming processing topology
# MIDS W205 Exercise 2 Tom Seddon March 27 2017

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to the database
conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

#Create the Database

try:
    # CREATE DATABASE can't run inside a transaction
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute('CREATE DATABASE "Tcount"')
    cur.close()
    conn.close()
except:
    print "Could not create Tcount"

#Connecting to Tcount

conn = psycopg2.connect(database="Tcount", user="postgres", password="pass", host="localhost", port="5432")

#Create the table to store words and counts
#The first step is to create a cursor. 

with conn:
    with conn.cursor() as curs:
        curs.execute('''CREATE TABLE "Tweetwordcount"
           (word TEXT PRIMARY KEY     NOT NULL,
            count INT     NOT NULL);''')

# Close connection at the end
conn.close()
