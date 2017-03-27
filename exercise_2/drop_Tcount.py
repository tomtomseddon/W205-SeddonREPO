# Convenient script to remove the database that stores words and counts from the Tweet
# streaming processing topology
# MIDS W205 Exercise 2 Tom Seddon March 27 2017


import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to the database
conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

#Drop the Database

try:
    # DROP DATABASE can't run inside a transaction
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute('DROP DATABASE "Tcount"')
    cur.close()
    conn.close()
except:
    print "Could not drop Tcount"

# close connection at the end
conn.close()
