# Script to change data files to csv format
import sys, csv

if len(sys.argv) != 3:
    print "ERROR: Missing args\nUsage: python [filename] filename1 filename2"
else:
    with open(sys.argv[1], "r") as inp, open(sys.argv[2], "w") as out:
        w = csv.writer(out, delimiter=",")
        w.writerows(x for x in csv.reader(inp, delimiter="\t"))
