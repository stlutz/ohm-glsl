tests
testGrammarParsesPostfixExpression

	startRule := #PostfixExpression.
	
	self shouldParseAll: #(
		'myVar.field'
		'x++'
		'var.field.field.field'
		'obj.method(true)'
		'5++++' ).
	
	self shouldntParseAny: #(
		'3+4' ).