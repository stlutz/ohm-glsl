tests
testGrammarParsesIntegerLiterals

	startRule := #integerLiteral.
	
	self shouldParseAll: #(
		'42'
		'1u'
		'077'
		'0'
		'000'
		'0xABcdEF00'
		'0x0' ).
	
	self shouldntParseAny: #(
		'-1'
		'1.0'
		'00xff' ).

	"self shouldParse: '042' to: #(integerConstant (octalConstant '042'))"