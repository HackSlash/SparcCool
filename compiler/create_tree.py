import re

bison_start = False

def proc_line(line):
	global bison_start
	if re.match(r"%%\W+", line): bison_start = not bison_start
	elif bison_start == True:
		match = re.search(r'(\w*)(?=\s+:)',line)
		if match: return match.group(0)

with open('cool.y') as infile:
	nondets = map(proc_line,infile)
	nondets = filter(lambda x: x != None, nondets)

with open('tree_gen.h','w') as outfile:
	for nd in nondets:
		print >> outfile, """template <class T>
class %sNode : public Node<T> {
public:
	using Node<T>::Node;
};""" % nd

print "done!"