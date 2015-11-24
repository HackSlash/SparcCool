#!/usr/bin/env python2

import re,inspect,sys,getopt
scriptname = inspect.getfile(inspect.currentframe())
bison_start = False
infilename  = 'parser.ypp'
outfilename = 'error.output'

def proc_line(line):
	global bison_start
	if re.match(r"%%\W+", line):
		bison_start = not bison_start
		return [line]
	elif bison_start == False: return [line]
	elif bison_start == True:
		lines = re.findall(r'(((?!error|empty).)*)', line)
		match = []
		for l in lines:
			match += re.findall(r'.*(\:|\|)(\s)* ((\w)+(\s*))*\{\}',l)
		if len(match) > 0:
			worker = []
			for x in xrange(len(match)):
				tmp = match
				tmp[x] = " error "
				worker += reduce(lambda x,y: x+y, tmp)
			return worker

try:
	opts, args = getopt.getopt(sys.argv[1:],"hi:o:",["infile=","outfile="])
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

with open(infilename) as infile:
	nested_lines = map(proc_line,infile)

nested_lines = filter(lambda x: x != None, nested_lines)

with open(outfilename,'w') as outfile:
	for lines in nested_lines:
		lines = filter(lambda x: x != None, lines)
		for line in lines:
			print >> outfile, line
