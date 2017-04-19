# Getting And Cleaning Data Coursera course project

This is the course project for the Getting and Cleaning Data Coursera course. The purpose of this project is to demonstrate your ability to collect, work with, 
and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 


# Details of files in this repository:

## I. run_analysis.R script  to transform raw data to tidy data. Below are the steps performed using run_analysis.R script:

a) Sets the working directory
b) Downloads the dataset into the working directory
c) Reads all text files : X_test.txt, X_train.txt, test_subject_id, train_subject_id, test_activity_id, train_activity_id, activity_labels.txt, features.txt into different
data frames
d) Labels the columns in all data frames
e) Merges the test data sets  and training data set into one data frame
f) In the merged data set, keep only columns referring to mean and std deviation.
g) Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
h) The end result is shown in the file Tidy_data.txt.


## II. CodeBook.md

This is the code book which provides details about raw and tidy data set. It also gives the details to convert the raw data to tidy data.

## III. Tidy_data.txt

This file is the end result after conversion of raw data to tidy data

