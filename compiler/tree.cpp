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
classdeclNode::classdeclNode(typeNode t, varformalsNode v, typeNode et, actualsNode ea, classbodyNode c) : type(t), varformals(v), extendType(et), extendActuals(ea), classbody(c) {}

varformalsNode::varformalsNode(varformNode v) : varform(v) {}

varformNode::varformNode (idNode i, typeNode t) : id(i), type(t) {}
varformNode::varformNode (varformNode v, idNode i, typeNode t) : varform(v), id(i), type(t) {}

classbodyNode::classbodyNode(featuresNode f) : features(f) {}

featuresNode::featuresNode(bool o, featuresNode fe, idNode i, formalsNode fo, typeNode t, exprNode e) : isOverride(o) features(fe), id(i), formals(f), type(t), expr(e) {}
featuresNode::featuresNode(featuresNode fe, idNode i) : features(fe), id(i) {} // var id = native;
featuresNode::featuresNode(featuresNode fe, idNode i, typeNode t, exprNode e) : features(fe), id(i), type(t), expr(e) {}
featuresNode::featuresNode(featuresNode fe, blockNode b) : features(fe), block(b) {}

formalsNode::formalsNode(formNode f) : form(f) {}

formNode::formNode(idNode i, typeNode t) : id(i), type(t) {}	
formNode::formNode(formNode f, idNode i, typeNode t) : form(f), id(i), type(t) {}

actualsNode::actualsNode(actualNode a) : actual(a) {}

actualNode::actualNode(exprNode e) : expr(e) {}
actualNode::actualNode(actualNode a, exprNode e) : actual(a), expr(e) {}

blockNode::blockNode(exprNode e) : expr(e) {}
blockNode::blockNode(blockptNode b) : blockpt(b) {}

blockptNode::blockptNode(exprNode e1, exprNode e2) : expr1(e1), expr2(e2) {} 
blockptNode::blockptNode(exprNode e, blockptNode b) : expr1(e), blockpt(b) {}
blockptNode::blockptNode(idNode i, typeNode t, exprNode e1, exprNode e2) : id(i), type(t), expr1(e1), expr2(e2) {}
blockptNode::blockptNode(idNode i, typeNode t, exprNode e, blockptNode b) : id(i), type(t), expr1(e), blockpt(b) {}

exprNode::exprNode(exprType et) : eType(et) {}
exprNode::exprNode(exprType et, idNode i, exprNode e) : id(i), expr(e) {}
exprNode::exprNode(exprType et, exprNode e) : eType(et), expr(e) {}
exprNode::exprNode(exprType et, exprNode e, exprNode e1, exprNode e2) : eType(et), expr(e), expr(e1), expr(e2) {}
exprNode::exprNode(exprType et, exprNode e, exprNode e1) : eType(et), expr(e), expr(e1) {}
exprNode::exprNode(exprType et, idNode i, actualsNode a) : eType(et), id(i), actuals(a) {}
exprNode::exprNode(exprType et, typeNode t, actualsNode a) : eType(et), type(t), actuals(a) {}
exprNode::exprNode(exprType et, blockNode b) : eType(et), block(b) {}
exprNode::exprNode(exprType et, exprNode e, idNode i, actualsNode a) : eType(et), expr(e), id(i), actuals(a) {}
exprNode::exprNode(exprType et, exprNode e, casesNode c) : eType(et), expr(e), cases(c) {}
exprNode::exprNode(exprType et, idNode i) : eType(et), id(i) {}

casesNode::casesNode(casNode c) : cas(c) {}

casNode::casNode(idNode i, typeNode t, blockNode b) : id(i), type(t), block(b) {}
casNode::casNode(casNode c, idNode i, typeNode t, blockNode b) : cas(c), id(i), type(t), block(b) {}
casNode::casNode(blockNode b) : block(b) {}
casNode::casNode(casNode c, blockNode b) : cas(c), block(b) {}
