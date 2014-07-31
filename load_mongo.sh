echo " add  --drop to all"
mongoimport --db michelin --collection topics --type json --file topics.100.json
mongoimport --db michelin --collection vocab --type csv --fields _id,word --file wordidx.txt
for i in `seq 1 100`; do echo -n $i, ; done
cp header predictions.100.csv
zcat predictions.100.csv.gz >>predictions.100.csv
mongoimport --db michelin --collection predictions --type csv --headerline --file predictions.100.csv
mongoimport --db michelin --collection tweets --type csv --fields tweetid,tweet --file tweetidx.txt
mongoimport --db michelin --collection tweettext --type csv --fields tweet,text,screen_name --file tweettext.txt 
mongoimport --db michelin --collection urls --type csv --fields tweetid,url --file urls.txt 
