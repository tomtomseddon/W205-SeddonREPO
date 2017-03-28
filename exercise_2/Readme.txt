W205 Exercise 2 Tom Seddon March 2017

Instructions to run the Twitter streaming application.

($ denotes a command line instruction)


1. Start Postgres

   On UCB AMI, run the setup script:

   $ /data/start_postgres.sh script 


2. Create the database and table to hold the results
   
   Make sure that exercise_2 is the working directory.
   Then run the script to set up the database and the table.

   $ python create_Tcount.py

   If database exists, script will stop.

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
   
   Run the final results script to get a list of all words and their counts

   $ python final_results.py
   
   To get results for a single word, run the final results script followed
   by the word to search for.

   $ python final_results.py example

   Run the script to get all the words that have a total count of occurences
   between two numbers (inclusive).  Numbers need to be separated by a comma
   as shown below:

   $ python histogram.py 10,20


5. Clean up (optional)

   To remove the database of results

   $ python drop_Tcount   