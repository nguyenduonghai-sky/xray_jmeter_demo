import csv;
import sys;
import operator;
from csv import reader;
dicta = {};
with open(sys.argv[2], "rt") as infile:
    reader = csv.reader(infile);
    headers = next(reader)[1:];
    for row in reader:
        dicta[row[0]] = {key: value for key, value in zip(headers, row[1:])};

# Write data to the csv file and replace the lines in the line_to_override dict.
with open(sys.argv[1]) as f:
    with open(sys.argv[3], "w") as f1:
    	f1.write("label,criteria,condition,value,result_value,result" + "\n");
    	csv_reader = csv.reader(f);
    	header = next(csv_reader);
    	if header != None:
    		for row in csv_reader:
    			result = "";row[3] = row[3].replace('%', '');dicta[row[0]][row[1]] = dicta[row[0]][row[1]].replace('%', '');
    			# print(row[3]);
    			if (row[2] == ">"):
    				result = float(dicta[row[0]][row[1]]) > float(row[3]);
    			elif (row[2] == "=="):
    				result = float(dicta[row[0]][row[1]]) == float(row[3]);
    			elif (row[2] == "!="):
    				result = float(dicta[row[0]][row[1]]) != float(row[3]);
    			elif (row[2] == "<"):
    				result = float(dicta[row[0]][row[1]]) < float(row[3]);
    			elif (row[2] == "<="):
    				result = float(dicta[row[0]][row[1]]) <= float(row[3]);
    			elif (row[2] == ">="):
    				result = float(dicta[row[0]][row[1]]) >= float(row[3]);
    			f1.write(row[0] + "," + row[1] + "," +row[2] + "," + row[3] + "," + dicta[row[0]][row[1]] + "," + str(result) + "\n");