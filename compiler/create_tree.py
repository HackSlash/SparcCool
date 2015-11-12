import re

bison_start = False

def proc_line(line):
	global bison_start
	if re.match(r"%%\W+", line): bison_start = not bison_start
	elif bison_start == True:
		match = re.search(r'(\w*)(?=\s+:)',line)
		if match: return match.group(0)

with open('parser.ypp') as infile:
	nondets = map(proc_line,infile)
	nondets = filter(lambda x: x != None, nondets)

with open('tree_gen.h','w') as outfile:
	print >> outfile, "#ifndef TREE_GEN_H\n#define TREE_GEN_H"
	for nd in nondets:
		print >> outfile, """class %sNode : public Node {
public:
	using Node::Node;
};""" % nd
	print >> outfile, "#endif //TREE_GEN_H"

print "done!"