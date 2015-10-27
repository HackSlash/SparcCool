template<class T> Node::Node(T value) {
	//create pointer to table entry
	left = right = NULL;
}

template<class T> Node::~Node() {
	delete val;
}

template<class T> bool Node::addChild(Node c, bool r) {
	if (r) {
		if (right!=NULL) return false;
		right = &c;
	}
	else {
		if (left!=NULL) return false;
		left = &c;
	}
}