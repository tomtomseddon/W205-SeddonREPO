#!/bin/bash

# Get the current working directory and store it

MY_CWD=$(pwd)

# create overall staging directory if not present

mkdir -p ~/staging

# check for presence of exercise_1 directory and make it if not present
# otherwise terminate the script as I'll want to decide whether to
# run the whole script or not in that case

# Note for self.  Using the [ ] form of the 'test' command
# Note need for two [[]] around the test condition
# Choose to exit the script rather than continue here if the
# folder already exists

if [[ ! -e ~/staging/exercise_1 ]]; then
   mkdir ~/staging/exercise_1
else
   echo "The exercise_1 folder already exists in staging.  Stopping script."
   exit
fi

echo "Successfully created exercise_1 folder in staging"

# change to the exercise_1 staging directory we just created

cd ~/staging/exercise_1

# Pull the zipped data file from the medicare website
# Note to self.  Variable assignment statements can't have space around
# the = sign, or they won't work

TARGET_URL="https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"

# Note to self: the capital -O specifies an Output document for wget,
# in this case the medi_data.zip files
wget "$TARGET_URL" -O medi_data.zip

# Unzip the data files

unzip medi_data.zip

# Create a copy of each of the five files of interest, with a simpler name
# and the first Line of each file removed

# First specify the old and new file names

OLD_FILE1="Hospital General Information.csv"
NEW_FILE1="hospitals.csv"

OLD_FILE2="Timely and Effective Care - Hospital.csv"
NEW_FILE2="effective_care.csv"

OLD_FILE3="Readmissions and Deaths - Hospital.csv"
NEW_FILE3="readmissions.csv"

OLD_FILE4="Measure Dates.csv"
NEW_FILE4="measures.csv"

OLD_FILE5="hvbp_hcahps_11_10_2016.csv"
NEW_FILE5="survey_responses.csv"

# Then execute the copy and removal

echo "processing $OLD_FILE1..."
tail -n +2 "$OLD_FILE1" > $NEW_FILE1

echo "processing $OLD_FILE2..."
tail -n +2 "$OLD_FILE2" > $NEW_FILE2

echo "processing $OLD_FILE3..."
tail -n +2 "$OLD_FILE3" > $NEW_FILE3

echo "processing $OLD_FILE4..."
tail -n +2 "$OLD_FILE4" > $NEW_FILE4

echo "processing $OLD_FILE5..."
tail -n +2 "$OLD_FILE5" > $NEW_FILE5

# Now create the HDFS directories needed

hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses

# Put each of the new files into hdfs in the right directory

echo "adding $NEW_FILE1 to hdfs..."
hdfs dfs -put $NEW_FILE1 /user/w205/hospital_compare/hospitals

echo "adding $NEW_FILE2 to hdfs..."
hdfs dfs -put $NEW_FILE2 /user/w205/hospital_compare/effective_care

echo "adding $NEW_FILE3 to hdfs..."
hdfs dfs -put $NEW_FILE3 /user/w205/hospital_compare/readmissions

echo "adding $NEW_FILE4 to hdfs..."
hdfs dfs -put $NEW_FILE4 /user/w205/hospital_compare/measures

echo "adding $NEW_FILE5 to hdfs..."
hdfs dfs -put $NEW_FILE5 /user/w205/hospital_compare/survey_responses

# change directory back to original working directory when script started

cd $MY_CWD

# End script cleanly

exit
