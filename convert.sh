#!/usr/bin/env bash
set -o errexit
set -o pipefail

echo "Deleting old generated files"
rm -f data_unix.txt input.txt db.sqlite3 data.csv

echo "Converting Windows-1252 to UTF-8"
iconv -f Windows-1252 -t UTF-8 data.txt > data_unix.txt
dos2unix data_unix.txt

echo "Adding CSV Header"
echo 'tbnr^tdb1^tdb2^tdb3^tdb4^tdb5^pdb1^pdb2^fap^p^euro^cent^klt1^klt2^klt3^von^bis^kr1^kr2^kl1^kl2^kl3^kl4^tdr1^tdr2^tdr3^tdr4^tdr5^pdr1^pdr2' | cat - data_unix.txt > input.txt
rm data_unix.txt

echo "Parsing and converting to CSV"
cat convert.sql | sqlite3 db.sqlite3

echo -e "\nWrote data to data.csv!"
