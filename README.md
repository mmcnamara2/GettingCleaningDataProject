

The run_analysis script works by first pulling in data from the UCI HAR Dataset.  

The following files are read in:

Training set
Testing set
Training labels
Testing labels
Feature list
Activity Labels

The script assigns the variable names to the test and training sets based upon the feature list.  It then removes unwanted columns leaving only identification information and mean/std variables.  This data is merged with all the labels in order to provide readable information.

Lastly averages are taken for all metric grouping by subject and activity type.
