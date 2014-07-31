cat complex_tokenize/predictions.100.dat | sed 's/ *$//'| awk '{print NR,$0}' | tr ' ' ',' | gzip -c > /Volumes/Saurabh6312584318/michelin/predictions.100.csv.gz
