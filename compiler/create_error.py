#!/usr/bin/env python2

import re,inspect,sys,getopt
scriptname = inspect.getfile(inspect.currentframe())
bison_start = False
debug = False
infilename  = 'parser.ypp'
outfilename = 'parser_gen.yyp'
worker = []

def proc_line(line):
	global bison_start,worker
	if re.match(r"%%\W+", line):	
		bison_start = not bison_start
		return [line]
	elif bison_start == False: return [line.strip("\n")]
	elif bison_start == True:
		if "empty" in line: return [line]
		if not "error" in line:
			start_index = 0
			try:
				start_index = line.index("|")
			except ValueError:
				try:
					start_index = line.index(":")
				except ValueError:
					return [line]
			end_index = line.index("{")
			line_start = line[:start_index+1]
			line_end = line[end_index:]
			worker = []
			worker += [line]
			words = line[start_index:end_index]
			words_list = words.split()
			if len(words_list) > 0:
				for x in xrange(len(words_list)):
					tmp = words_list
					tmp[x] = "error"
					s = reduce(lambda x,y: x+" "+y, tmp)
					s = "/* error */ | " + s
					s += " {std::cerr << yytext << std::endl;}"
					#if debug: print s
					worker += [s]
				return worker

try:
	opts, args = getopt.getopt(sys.argv[1:],"hi:o:d",["infile=","outfile=", "debug"])
except getopt.GetoptError:
	print "%s -i <inputfile> -o <outputfile>" % scriptname
	sys.exit(2)
for opt, arg in opts:
	if opt == '-h':
		print "%s -i <inputfile> -o <outputfile>" % scriptname
		sys.exit()
	elif opt in ("-i", "--infile"):
		infilename = arg
	elif opt in ("-o", "--outfile"):
		outfilename = arg
	elif opt in ("-d", "--debug"):
		debug = True

with open(infilename) as infile:
	nested_lines = map(proc_line,infile)

nested_lines = filter(lambda x: x != None, nested_lines)

with open(outfilename,'w') as outfile:
	for lines in nested_lines:
		lines = filter(lambda x: x != None, lines)
		for line in lines:
			if debug: print line
			print >> outfile, line
