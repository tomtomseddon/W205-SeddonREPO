# Script to get the final results from the database created by the stream
# processing topology.
#
# If no words passed as arguments on the command line, will return all words in the stream
# sorted alphabetically
#
# If a word is passed as an argument, it will only return the number of occurences of that word
#
# MIDS W205 Exercise 2 Tom Seddon March 27 2017


import psycopg2
import sys
from operator import itemgetter

print "Program arguments", sys.argv

if len(sys.argv) == 1:
    show_all = True
else:
    show_all = False
    single_word = sys.argv[1]

print "Show all?", show_all

if not show_all:
    print "Single word: ", single_word

#Connecting to Tcount

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
            no_match = True
        else:
            no_match = False

# have to sort the tuples by lower otherwise get uppercase and lowercase sorted separately

records.sort(key = lambda x: x[0].lower())

if show_all:
    for rec in records:
        print rec[0], rec[1]
else:
    if no_match:
        count = 0
    else:
        count  = records[0][1]
    print "Total number of occurences of", single_word, ":", count


# Close connection at the end
conn.close()
