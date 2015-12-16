/** C/C++ Imports **/
#include <string>
#include "visitor.h"

typedef enum
{
	assign,
	unary_minus,
	unary_not,
	if_statement,
	while_loop,
	super_call,
	call,
	instantiation,
	braced_block,
	par_expr,
	obj_call,
	match_cases,
	cmp_lteq,
	cmp_lt,
	cmp_eq,
	multiplication,
	division,
	addition,
	subtraction,
	null,
	unit,
	identifier,
	lit_int,
	lit_string,
	lit_bool,
	this_reference
} exprType;

class StringNode;
class IntNode;
class BoolNode;
class programNode;
class classdeclsNode;
class classdeclNode;
class varformalsNode;
class varformNode;
class classbodyNode;
class featuresNode;
class formalsNode;
class formNode;
class actualsNode;
class actualNode;
class blockNode;
class blockptNode;
class idNode;
class typeNode;
class exprNode;
class casesNode;
class casNode;

/** A Node, used to build the GrammarTree **/
class Node
{
	friend class Visitor;
public:
	/** Constructor & Destructor **/
	Node() {}
	virtual ~Node() {}
};
/** A node with a string value, used to build the GrammarTree **/
class StringNode : Node
{
	friend class Visitor;
public:
	/** Constructor & Destructor **/
	StringNode(std::string s) : val(s) {}
	~StringNode(){}

private:
	/** Declaration of the string value **/
	std::string val;
};
/** A node with an int value, used to build the GrammarTree **/
class IntNode : Node
{
	friend class Visitor;
public:
	/** Constructor & Destructor **/
	IntNode(int i) : val(i) {}
	~IntNode() {}
private:
	/** Declaration of the int value **/
	int val;
};
/** A node with a bool value, used to build the GrammarTree **/
class BoolNode : Node
{
	friend class Visitor;
public:
	/** Constructor *& Destructor **/
	BoolNode(bool b) : val(b) {}
	~BoolNode() {}
private:
	/** Declaration of the bool value **/
	bool val;
};

class programNode : public Node
{
	friend class Visitor;
public:
	programNode() {}
	programNode(classdeclsNode*&);
	~programNode(){
		delete classdecls;
	}
private:
	classdeclsNode* classdecls;
};

class classdeclsNode : public Node
{
	friend class Visitor;
public:
	classdeclsNode() {}
	classdeclsNode(classdeclNode*&);
	classdeclsNode(classdeclNode*&, classdeclsNode*&);
	~classdeclsNode() {
		delete classdecl;
		delete classdecls;
	}
private:
	classdeclNode* classdecl;
	classdeclsNode* classdecls;
};

class classdeclNode : public Node
{
	friend class Visitor;
public:
	classdeclNode() {}
	classdeclNode(typeNode*&, varformalsNode*&, classbodyNode*&);
	classdeclNode(typeNode*&, varformalsNode*&, typeNode*, actualsNode*&, classbodyNode*&);
	~classdeclNode() {
		delete type;
		delete extendType;
		delete varformals;
		delete classbody;
		delete extendActuals;
	}
private:
	typeNode* type;
	typeNode* extendType;
	varformalsNode* varformals;
	classbodyNode* classbody;
	actualsNode* extendActuals;
};

class varformalsNode : public Node
{
	friend class Visitor;
public:
	varformalsNode() {}
	varformalsNode(varformNode*&);
	~varformalsNode() {
		delete varform;
	}
private:
	varformNode* varform;
};

class varformNode : public Node
{
	friend class Visitor;
public:
	varformNode() {}
	varformNode (idNode*&, typeNode*&);
	varformNode (varformNode*&, idNode*&, typeNode*&);
	~varformNode () {
		delete varform;
		delete id;
		delete type;
	}
private:
	varformNode* varform;
	idNode* id;
	typeNode* type;
};

class classbodyNode : public Node
{
	friend class Visitor;
public:
	classbodyNode() {}
	classbodyNode(featuresNode*&);
	~classbodyNode() {
		delete features;
	}
private:
	featuresNode* features;
};

class featuresNode : public Node
{
	friend class Visitor;
public:
	featuresNode() {}
	featuresNode(bool, featuresNode*&, idNode*&, formalsNode*&, typeNode*&, exprNode*&);
	featuresNode(featuresNode*&, idNode*&); // var id = native;
	featuresNode(featuresNode*&, idNode*&, typeNode*&, exprNode*&);
	featuresNode(featuresNode*&, blockNode*&);
	~featuresNode() {
		delete features;
		delete id;
		delete formals;
		delete type;
		delete expr;
		delete block;
	}
private:
	bool isOverride;
	featuresNode* features;
	idNode* id;
	formalsNode* formals;
	typeNode* type;
	exprNode* expr;
	blockNode* block;
};

class formalsNode : public Node
{
	friend class Visitor;
public:
	formalsNode() {}
	formalsNode(formNode*&);
	~formalsNode() {
		delete form;
	}
private:
	formNode* form;
};

class formNode : public Node
{
	friend class Visitor;
public:
	formNode() {}
	formNode(idNode*&, typeNode*&);
	formNode(formNode*&, idNode*&, typeNode*&);
	~formNode() {
		delete form;
		delete id;
		delete type;
	}
private:
	formNode* form;
	idNode* id;
	typeNode* type;
};

class actualsNode : public Node
{
	friend class Visitor;
public:
	actualsNode() {}
	actualsNode(actualNode*&);
	~actualsNode() {
		delete actual;
	}
private:
	actualNode* actual;
};

class actualNode : public Node
{
	friend class Visitor;
public:
	actualNode() {}
	actualNode(exprNode*&);
	actualNode(actualNode*&, exprNode*&);
	~actualNode() {
		delete actual;
		delete expr;
	}
private:
	actualNode* actual;
	exprNode* expr;
};

class blockNode : public Node
{
	friend class Visitor;
public:
	blockNode() {}
	blockNode(exprNode*&);
	blockNode(blockptNode*&);
	~blockNode() {
		delete expr;
		delete blockpt;
	}
private:
	exprNode* expr;
	blockptNode* blockpt;
};

class blockptNode : public Node
{
	friend class Visitor;
public:
	blockptNode() {}
	blockptNode(exprNode*&, exprNode*&);
	blockptNode(exprNode*&, blockptNode*&);
	blockptNode(idNode*&, typeNode*&, exprNode*&, exprNode*&);
	blockptNode(idNode*&, typeNode*&, exprNode*&, blockptNode*&);
	~blockptNode() {
		delete expr1;
		delete expr2;
		delete id;
		delete type;
		delete blockpt;
	}
private:
	exprNode* expr1;
	exprNode* expr2;
	idNode* id;
	typeNode* type;
	blockptNode* blockpt;	
};

class idNode : public Node
{
	friend class Visitor;
public:
	idNode() {}
	idNode(int i) : id(i) {}
	~idNode() {}
private:
	int id;
};

class typeNode
{
	friend class Visitor;
public:
	typeNode() {}
	typeNode(int i) : id(i) {}
	~typeNode() {}
private:
	int id;
};

class exprNode : public Node
{
	friend class Visitor;
public:
	exprNode() {}
	exprNode(exprType);
	exprNode(exprType, idNode*&, exprNode*&);
	exprNode(exprType, exprNode*&);
	exprNode(exprType, exprNode*&, exprNode*&, exprNode*&);
	exprNode(exprType, exprNode*&, exprNode*&);
	exprNode(exprType, idNode*&, actualsNode*&);
	exprNode(exprType, typeNode*&, actualsNode*&);
	exprNode(exprType, blockNode*&);
	exprNode(exprType, exprNode*&, idNode*&, actualsNode*&);
	exprNode(exprType, exprNode*&, casesNode*&);
	exprNode(exprType, idNode*&);
	~exprNode() {
		delete id;
		delete expr;
		delete expr1;
		delete expr2;
		delete actuals;
		delete type;
		delete block;
		delete cases;
	}
private:
	exprType eType;
	idNode* id;
	exprNode* expr;
	exprNode* expr1;
	exprNode* expr2;
	actualsNode* actuals;
	typeNode* type;
	blockNode* block;
	casesNode* cases;
};

class casesNode : public Node
{
	friend class Visitor;
public:
	casesNode() {}
	casesNode(casNode*&);
	~casesNode() {
		delete cas;
	}
private:
	casNode* cas;
};

class casNode : public Node
{
	friend class Visitor;
public:
	casNode() {}
	casNode(idNode*&, typeNode*&, blockNode*&);
	casNode(casNode*&, idNode*&, typeNode*&, blockNode*&);
	casNode(blockNode*&);
	casNode(casNode*&, blockNode*&);
	~casNode() {
		delete cas;
		delete id;
		delete type;
		delete block;
	}
private:
	casNode* cas;
	idNode* id;
	typeNode* type;
	blockNode* block;
};