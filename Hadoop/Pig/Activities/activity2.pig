-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/radhika/input.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
totalcount = FOREACH grpd GENERATE group, COUNT(words);
--Remove the old results folder 
rmf hdfs:///user/radhika/PigResult;                  
-- Store the result in HDFS
STORE totalcount INTO 'hdfs:///user/radhika/PigResult';
