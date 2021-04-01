tests
testGrammarParsesFloatLiterals

	startRule := #floatLiteral.
	
	self shouldParseAll: #(
		'1.0'
		'.5'
		'5.'
		'1.0lf'
		'.3LF'
		'1.0f'
		'.3F'
		'1e10'
		'1.0e-10'
		'.75E07'
		'5.e+3lf' ).
	
	self shouldntParseAny: #(
		'-1.0'
		'.'
		'1e+-3'
		'1 . 0'
		'1.0l'
		'1.0 f'
		'42' ).