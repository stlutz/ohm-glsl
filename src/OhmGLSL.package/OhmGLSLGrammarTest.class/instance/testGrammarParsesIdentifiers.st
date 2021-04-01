tests
testGrammarParsesIdentifiers

	startRule := #identifier.
	
	self shouldParseAll: #(
		'aTexCoords'
		'gl_Position'
		'abc123'
		'x'
		'_var'
		'_' ).
	
	self shouldntParseAny: #(
		'2dPosition'
		'tür'
		'my-var' ).