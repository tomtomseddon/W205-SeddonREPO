from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2


class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

    def process(self, tup):
        word = tup.values[0]

        conn = psycopg2.connect(database="Tcount", user="postgres", password="pass", host="localhost", port="5432")
 
        # First try to increment count by 1 for this word in the database
        with conn:
            with conn.cursor() as curs:
                curs.execute('UPDATE "Tweetwordcount" SET count=count + 1 WHERE word=%s', (word,))
        # Then do an insert instead if the previous UPDATE command didn't find the word
        if curs.rowcount == 0:
            with conn:
                with conn.cursor() as curs:
                    curs.execute('INSERT INTO "Tweetwordcount" (word,count) VALUES (%s, %s)', (word, 1))

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
        
        # close the connection to the database
        conn.close()
