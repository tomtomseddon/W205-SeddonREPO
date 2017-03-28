# Script to get the final results from the database created by the stream
# processing topology.
#
# If no words passed as arguments on the command line, will return all words in the stream
# sorted alphabetically
#
# If a word is passed as an argument, it will only return the number of occurences of that word
#
# Assumes table of results and word to search for ARE case-sensitive.
#
# MIDS W205 Exercise 2 Tom Seddon March 27 2017


import psycopg2
import sys
from operator import itemgetter

# Check whether an optional argument was passed
if len(sys.argv) == 1:
    show_all = True
else:
    show_all = False
    single_word = sys.argv[1]

# Connect to Tcount database and get either all results or just for single word
conn = psycopg2.connect(database="Tcount", user="postgres", password="pass", host="localhost", port="5432")

if show_all:
    with conn.cursor() as curs:
        curs.execute('SELECT word, count FROM "Tweetwordcount"')
        records = curs.fetchall()
else:
    with conn.cursor() as curs:
        curs.execute('SELECT word, count FROM "Tweetwordcount" WHERE word=%s', (single_word,))
        records = curs.fetchall()
        if curs.rowcount == 0:
            count = 0
        else:
            count = records[0][1]

# Display results
if show_all:
    # sort the tuples by alphabetical order (uppercase and lowercase together)
    records.sort(key = lambda x: x[0].lower())
    for rec in records:
        print rec[0], rec[1]
else:
    print "Total number of occurences of", single_word, ":", count

# Close connection at the end
conn.close()
