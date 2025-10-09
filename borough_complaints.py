#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#borough_complaints.py -i <the input csv file> -s <start date> -e <end date> [-o <output file>]
#If the output argument isn’t specified, then just print the results (to stdout).
#If “-h”: print(“help message”)
#Commit your script, but not the data to your git repo.
import argparse

import subprocess

import sys

import argparse
import subprocess
import csv


parser = argparse.ArgumentParser()
parser.add_argument("-i", "--input", required=True, help="Input CSV file")
parser.add_argument("-s", "--start", required=True, help="Start date (YYYY-MM-DD)")
parser.add_argument("-e", "--end", required=True, help="End date (YYYY-MM-DD)")
parser.add_argument("-o", "--output", help="Optional output CSV file")
args = parser.parse_args()

if args.input and args.start and args.end:
    # Open input and output CSVs
    if args.output:
        outfile = open(args.output, "w", newline='')
    else:
        outfile = sys.stdout
        
    with open(args.input, newline='') as infile, outfile as out:
        reader = csv.reader(infile)
        writer = csv.writer(out)
    
        # Read header
        header = next(reader)
        writer.writerow(header)
    
        # Filter rows by created date (MM/DD/YYYY)
        for row in reader:
            created_date = row[1]  # Column 2
            if args.start <= created_date[:10] <= args.end:  # compare first 10 chars
                writer.writerow(row)


    




# In[ ]:




