class Constructor(object):
	"""docstring for Constructor"""

	args = set()

	def __init__(self, cl):
		super(Constructor, self).__init__()
		self.cl = cl
		# self.args = args
		
	def addArg(self, arg):
		if arg not in self.args:
			self.args.add(arg)

	def __str__(self):
		return "%s() : %s {}" % (self.cl.name, ','.join(["_%s(%s)" % (str(x),str(x)) for x in self.args]))

class Class(object):
	"""docstring for Class"""

	constructors = set()
	properties = set()
	name = ""

	def __init__(self, name):
		super(Class, self).__init__()
		self.name = name
		# self.constructors = constructors
		# self.properties = properties
		
	def addConstructor(self, constructor):
		if constructor not in self.constructors:
			self.constructors.add(constructor)

	def addProperty(self, prop):
		if prop not in self.properties:
			self.properties.add(prop)

	def __str__(self):
		ret = """class %s : public Node {
public:\n""" % self.name
		for c in self.constructors:
			ret += "\t%s\n" % str(c)
		ret += "\t~%s() {}\n" % self.name
		ret += "private:\n"
		for p in self.properties:
			ret += "\t_%s;\n" % str(p)
		ret += "};"
		return ret

class ClassContainer(object):
	"""docstring for ClassContainer"""

	classes = set()

	def __init__(self):
		super(ClassContainer,self).__init__()

	def addClass(self, c, debug=False):
		self.classes.add(c)
		if debug: print len(self.classes)

	def getByName(self, name):
		for c in self.classes:
			if name == c.name: return c

	def count(self):
		return len(self.classes)

	def __str__(self):
		ret = ""
		for c in self.classes:
			ret += "%s\n" % str(c)
		return ret
