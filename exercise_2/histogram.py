# Script to get a words from the database created by the stream
# processing topology that have more than or less than a certain count.
#
# Expects two numbers to be passed as arguments on the command line.
#
# MIDS W205 Exercise 2 Tom Seddon March 27 2017


import psycopg2
import sys

print "Program arguments", sys.argv

if len(sys.argv) != 2:
    print "Need to put two numbers separated by a comma as an argument e.g. python histogram.py 3,8"
    sys.exit()
else:
    try:
        entered = sys.argv[1].split(",")
        print entered
        k1 = int(entered[0])
        k2 = int(entered[1])
    except:
        print "Need to put two numbers separated by a comma as an argument e.g. python histogram.py 3,8"
        sys.exit()
if k1 > k2:
    print "Second number must be greater than or equal to the first e.g. python histogram.py 3,8"
    sys.exit()

k1 = max(0, k1)  # catch if a negative number is entered
k2 = max(0, k2)  # catch if a negative number is entered

#Connecting to Tcount

conn = psycopg2.connect(database="Tcount", user="postgres", password="pass", host="localhost", port="5432")

with conn.cursor() as curs:
    curs.execute('SELECT word, count FROM "Tweetwordcount" WHERE count>=%s AND count<=%s', (k1, k2))
    records = curs.fetchall()
    if curs.rowcount == 0:
        no_match = True
    else:
        no_match = False

# sort the tuples

records.sort(key = lambda x: x[0].lower())
records.sort(key = lambda x: x[1], reverse = True)

if no_match:
    print "No words have counts from ", k1, "to", k2, "(inclusive)"
else:
    for rec in records:
        print rec[1], rec[0]

# Close connection at the end
conn.close()
