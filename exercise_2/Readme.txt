W205 Exercise 2 Tom Seddon March 2017

Instructions to run the Twitter streaming application.

($ denotes a command line instruction)

0. Installation
   These instructions assume the application is being run on a copy of
   the AWS UCB AMI.  AMI Name: UCB MIDS W205 EX2-FULL
                     AMI ID  : ami-d4dd4ec3

   This AMI require installation of psycopg2 and tweepy packages
   before application can be run.


   As root, install the packages
   $ pip install psycopg2==2.6.2
   $ pip install tweepy



1. Start Postgres

   On UCB AMI, as root, run the setup script:

   $ /data/start_postgres.sh script


2. Create the database and table to hold the results

   Switch to user w205 for remainder of instructions

   $ su - w205

   Make sure that exercise_2 is the working directory.

   a) If running application for the first time:

      Run the script to set up the database and the table and
      continue to step 3.

      $ python create_Tcount.py

   b) If you've already run it once or more, you have a choice:

    Option 1 - to process tweets and add the new counts to the existing
               counts from previous runs, just continue to step 3.

    Option 2 - to reset the database and start all the counts fresh
               from this run, first use the cleanup script and then
               rerun the script to set up the database/table:

               $ python drop_Tcount.py
               $ python create_Tcount.py


3. Run the streaming application to capture and parse tweets

   Change to the directory that contains all the streamparse components
   and then start streamparse.

   $ cd extweetwordcount
   $ sparse run

   Processes will take a bit of time to start, then a stream of words
   and counts will be printed on the screen to show the stream is
   running.

   Use Ctrl-C to stop processing when you have gathered enough tweets.


4. Serve final results

   Change back up to the exercise_2 directory

   $ cd ..

   There are three options for viewing results:

   a) To get a list of all words and their counts:

   Run the final results script

   $ python final_results.py


   b) To get results for a single word:

   Run the final_results script followed by the word to search for.

   $ python final_results.py example


   c) To get all the words that have a total count of occurrences
      between two numbers (inclusive):

   Run the histogram script.  Numbers need to be separated by a comma
   as shown below:

   $ python histogram.py 10,20


5. Clean up (optional)

   To remove the database of results

   $ python drop_Tcount
