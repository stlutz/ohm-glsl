tests
testGrammarParsesPrimaryExpressions

	startRule := #PrimaryExpression.
	
	self shouldParseAll: #(
		'true'
		'42'
		'1.0'
		'0'
		'myVar'
		'((42))' ).
	
	self shouldntParseAny: #(
		'3+4'
		'(3'
		'.' ).