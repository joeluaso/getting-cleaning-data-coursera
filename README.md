# getting-cleaning-data-coursera
my peer reviewed assignment for week 4 course 3 JHU

There's only one script i used here but with some separate sections.

1. we first downloaded our data using the given URL, which was in 
zip file archive format, we unzipped it into our newly created folder called data.
All the unzipped data was located in the folder called UCI HAR Dataset.

2. Then we created a list vector with the names of all the files.
6 files namely: y_test.txt, X_test.txt, subject_test.txt, y_train.txt,
X_train.txt, subject_train.txt were the ones we were interested in.

3. We read those 6 files each into a separate variable, so that means we ended up
with 6 new variables.

4. Next we merged the train and test variables using rbind() ending up with 3 dataframes.

5. We set new descriptive names into our 3 Dataframes i.e. subject, activity and features.

6. We then merged all the 3 dataframes into 1 Dataframe using cbind().

7. Extract and subset the Mean and STD Deviation for each measurement using
custom regex functions. Save it into one dataframe called "Data".

8. We replaced the labels in our new dataframe, "Data" with full word descriptive ones.

9. Lastly, we made a new tidy data set using the previous dataframe, "Data" by
use of the "plyr" package's various functions e.g aggregate() and calculated 
each mean by activity and subject.

10. wrote the new tidy data set into a file called "tidydata.txt"


**The codebook was formed using the "dataMaid" package's makeCodebook() function
on the dataframe called "Data".











