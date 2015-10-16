import re

def main():
	bison_start = False
	nondets = []
	with open('cool.y') as infile:
		for line in infile:
			if re.match(r"%%\W+", line):
				print "syntax found!"
				bison_start = not bison_start
			elif bison_start == True:
				match = re.search(r'(\w*)(?=\s+:)',line)
				if match:
					nd = match.group(0)
					nondets += [nd]
	print nondets
	with open('tree_gen.h','w') as outfile:
		for nd in nondets:
			print >> outfile, """class %s : Node {
public:
	%s() : Node() {}
	~%s() {}
};""" % (nd,nd,nd)

if __name__ == '__main__':
	main()