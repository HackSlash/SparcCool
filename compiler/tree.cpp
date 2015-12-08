#include "tree.h"

programNode::programNode(classdeclsNode c) {
	classdecls = new classdeclsNode;
	*classdecls = c;
}

classdeclsNode::classdeclsNode(classdeclNode c) {
	classdecl = new classdeclNode;
	*classdecl = c;
}
classdeclsNode::classdeclsNode(classdeclNode c1, classdeclsNode c2) {
	classdecl = new classdeclNode;
	*classdecl = c1;
	classdecls = new classdeclsNode;
	*classdecls = c2;
}

classdeclNode::classdeclNode(typeNode t, varformalsNode v, classbodyNode c) {
	type = new typeNode;
	*type = t;
	varformals = new varformalsNode;
	*varformals = v;
	classbody = new classbodyNode;
	*classbody = c;
}
classdeclNode::classdeclNode(typeNode t, varformalsNode v, typeNode et, actualsNode ea, classbodyNode c) {
 	type = new typeNode;
 	*type = t;
 	varformals = new varformalsNode;
 	*varformals = v;
 	extendType = new typeNode;
 	*extendType = et;
 	extendActuals = new actualsNode;
 	*extendActuals = ea;
 	classbody = new classbodyNode;
	*classbody = c;
 }

varformalsNode::varformalsNode(varformNode v) {
	varform = new varformNode;
	*varform = v;
}

varformNode::varformNode (idNode i, typeNode t) {
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
}
varformNode::varformNode (varformNode v, idNode i, typeNode t) {
	varform = new varformNode;
	*varform = v;
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
}

classbodyNode::classbodyNode(featuresNode f) {
	features = new featuresNode;
	*features = f;
}

featuresNode::featuresNode(bool o, featuresNode fe, idNode i, formalsNode fo, typeNode t, exprNode e) {
	bool isOverride = o;
	features = new featuresNode;
	*features = fe;
	id = new idNode;
	*id = i;
	formals = new formalsNode;
	*formals = fo;
	type = new typeNode;
	*type = t;
	expr = new exprNode;
	*expr = e;
}
featuresNode::featuresNode(featuresNode fe, idNode i) {
	features = new featuresNode;
	*features = fe;
	id = new idNode;
	*id = i;
} // var id = native;
featuresNode::featuresNode(featuresNode fe, idNode i, typeNode t, exprNode e) {
	features = new featuresNode;
	*features = fe;
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
	expr = new exprNode;
	*expr = e;
}
featuresNode::featuresNode(featuresNode fe, blockNode b) {
	features = new featuresNode;
	*features = fe;
	block = new blockNode;
	*block = b;
}

formalsNode::formalsNode(formNode f) {
	form = new formNode;
	*form = f;
}

formNode::formNode(idNode i, typeNode t) {
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
}	
formNode::formNode(formNode f, idNode i, typeNode t) {
	form = new formNode;
	*form = f;
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
}

actualsNode::actualsNode(actualNode a) {
	actual = new actualNode;
	*actual = a;
}

actualNode::actualNode(exprNode e) {
	expr = new exprNode;
	*expr = e;
}
actualNode::actualNode(actualNode a, exprNode e) {
	actual = new actualNode;
	*actual = a;
	expr = new exprNode;
	*expr = e;
}

blockNode::blockNode(exprNode e) {
	expr = new exprNode;
	*expr = e;
}
blockNode::blockNode(blockptNode b) {
	blockpt =  new blockptNode;
	*blockpt = b;
}

blockptNode::blockptNode(exprNode e1, exprNode e2) {
	expr1 = new exprNode;
	*expr1 = e1;
	expr2 = new exprNode;
	*expr2 = e2;
} 
blockptNode::blockptNode(exprNode e, blockptNode b) {
	expr1 = new exprNode;
	*expr1 = e;
	blockpt =  new blockptNode;
	*blockpt = b;
}
blockptNode::blockptNode(idNode i, typeNode t, exprNode e1, exprNode e2) {
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
	expr1 = new exprNode;
	*expr1 = e1;
	expr2 = new exprNode;
	*expr2 = e2;
}
blockptNode::blockptNode(idNode i, typeNode t, exprNode e, blockptNode b) {
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
	expr1 = new exprNode;
	*expr1 = e;
	blockpt = new blockptNode;
	*blockpt = b;
}

exprNode::exprNode(exprType et) {
	eType = et;
}
exprNode::exprNode(exprType et, idNode i, exprNode e) {
	eType = et;
	id = new idNode;
	*id = i;
	expr = new exprNode;
	*expr = e;
}
exprNode::exprNode(exprType et, exprNode e) {
	eType = et;
	expr = new exprNode;
	*expr = e;
}
exprNode::exprNode(exprType et, exprNode e, exprNode e1, exprNode e2) {
	eType = et;
	expr = new exprNode;
	*expr = e;
	expr1 = new exprNode;
	*expr1 = e1;
	expr2 = new exprNode;
	*expr2 = e2;
}
exprNode::exprNode(exprType et, exprNode e, exprNode e1) {
	eType = et;
	expr = new exprNode;
	*expr = e;
	expr1 = new exprNode;
	*expr1 = e1;
}
exprNode::exprNode(exprType et, idNode i, actualsNode a) {
	eType = et;
	id = new idNode;
	*id = i;
	actuals = new actualsNode;
	*actuals = a;
}
exprNode::exprNode(exprType et, typeNode t, actualsNode a) {
	eType = et;
	type = new typeNode;
	*type = t;
	actuals = new actualsNode;
	*actuals = a;
}
exprNode::exprNode(exprType et, blockNode b) {
	eType = et;
	block = new blockNode;
	*block = b;
}
exprNode::exprNode(exprType et, exprNode e, idNode i, actualsNode a) {
	eType = et;
	expr = new exprNode;
	*expr = e;
	id = new idNode;
	*id = i;
	actuals = new actualsNode;
	*actuals = a;
}
exprNode::exprNode(exprType et, exprNode e, casesNode c) {
	eType = et;
	expr = new exprNode;
	*expr = e;
	cases = new casesNode;
	*cases = c;
}
exprNode::exprNode(exprType et, idNode i) {
	eType = et;
	id = new idNode;
	*id = i;
}

casesNode::casesNode(casNode c) {
	cas = new casNode;
	*cas = c;
}

casNode::casNode(idNode i, typeNode t, blockNode b) {
	id = new idNode;
	*id = i;
	type = new typeNode;
	*type = t;
	block = new blockNode;
	*block = b;
}
casNode::casNode(casNode c, idNode i, typeNode t, blockNode b) {
	cas = new casNode;
	*cas = c;
	*id = i;
	type = new typeNode;
	*type = t;
	block = new blockNode;
	*block = b;
}
casNode::casNode(blockNode b) {
	block = new blockNode;
	*block = b;
}
casNode::casNode(casNode c, blockNode b) {
	cas = new casNode;
	*cas = c;
	block = new blockNode;
	*block = b;
}
