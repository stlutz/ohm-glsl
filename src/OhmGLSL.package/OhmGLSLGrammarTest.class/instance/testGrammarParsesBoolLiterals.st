tests
testGrammarParsesBoolLiterals

	startRule := #boolLiteral.
	
	self shouldParseAll: #(
		'true'
		'false' ).
	
	self shouldntParseAny: #(
		'trueValue'
		'falsehood'
		'0' ).