tests
testGrammarParsesFunctionCall

	startRule := #FunctionCall.
	self flag: #todo. "with parameters"
	self shouldParseAll: #(
		'foo()'
		'bar( void )'
		'foobar2 ( )' ).
	
	self shouldntParseAny: #(
		'func(,)' ).