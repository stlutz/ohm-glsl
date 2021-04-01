serialized grammar
serializedGrammar
^ 'GLSL {
	TranslationUnit
		= ExternalDeclaration+
	
	ExternalDeclaration
		= FunctionDefinition
		// | Declaration
		// | semicolon
	
	FunctionDefinition
		= FunctionPrototype CompoundStatementNoNewScope
	
	CompoundStatementNoNewScope
		= "{" StatementList? "}"
	
	CompoundStatement
		= "{" StatementList? "}"
	
	StatementList
		= Statement+
	
	Statement
		= CompoundStatement
		| SimpleStatement
	
	SimpleStatement
		= ExpressionStatement
	/*
		= DeclarationStatement
		| ExpressionStatement
		| SelectionStatement
		| SwitchStatement
		| CaseLabel
		| IterationStatement
		| JumpStatement */
	
	ExpressionStatement
		= Expression? ";"
	
	Expression
		= NonemptyListOf<AssignmentExpression, ",">
	
	AssignmentExpression
		= SimpleAssignmentExpression
		| AugmentedAssignmentExpression
		| SelectionExpression
	
	SimpleAssignmentExpression
		= UnaryExpression "=" AssignmentExpression
	
	AugmentedAssignmentExpression
		= UnaryExpression "+=" AssignmentExpression -- add
		| UnaryExpression "-=" AssignmentExpression -- subract
		| UnaryExpression "*=" AssignmentExpression -- multiply
		| UnaryExpression "/=" AssignmentExpression -- divide
		| UnaryExpression "%=" AssignmentExpression -- modulo
		| UnaryExpression "<<=" AssignmentExpression -- leftShift
		| UnaryExpression ">>=" AssignmentExpression -- rightShift
		| UnaryExpression "&=" AssignmentExpression -- bitwiseAnd
		| UnaryExpression "|=" AssignmentExpression -- bitwiseOr
		| UnaryExpression "^=" AssignmentExpression -- bitwiseXor
	
	SelectionExpression
		= LogicalOrExpression "?" Expression ":" AssignmentExpression -- op
		| LogicalOrExpression
	
	LogicalOrExpression
		= LogicalOrExpression "^" LogicalXorExpression -- op
		| LogicalXorExpression
	
	LogicalXorExpression
		= LogicalXorExpression "^^" LogicalAndExpression -- op
		| LogicalAndExpression
	
	LogicalAndExpression
		= LogicalAndExpression "&&" BitwiseOrExpression -- op
		| BitwiseOrExpression
	
	BitwiseOrExpression
		= BitwiseOrExpression "|" BitwiseXorExpression -- op
		| BitwiseXorExpression
	
	BitwiseXorExpression
		= BitwiseXorExpression "^" BitwiseAndExpression -- op
		| BitwiseAndExpression
	
	BitwiseAndExpression
		= BitwiseAndExpression "&" EqualityExpression -- op
		| EqualityExpression
	
	EqualityExpression
		= EqualityExpression "==" RelationalExpression -- equal
		| EqualityExpression "!=" RelationalExpression -- notEqual
		| RelationalExpression
	
	RelationalExpression
		= RelationalExpression "<=" ShiftExpression -- lessEqual
		| RelationalExpression ">=" ShiftExpression -- greaterEqual
		| RelationalExpression "<" ShiftExpression -- less
		| RelationalExpression ">" ShiftExpression -- greater
		| ShiftExpression
	
	ShiftExpression
		= ShiftExpression "<<" AdditiveExpression -- left
		| ShiftExpression ">>" AdditiveExpression -- right
		| AdditiveExpression
	
	AdditiveExpression
		= AdditiveExpression "+" MultiplicativeExpression -- add
		| AdditiveExpression "-" MultiplicativeExpression -- subtract
		| MultiplicativeExpression
	
	MultiplicativeExpression
		= MultiplicativeExpression "*" UnaryExpression -- multiply
		| MultiplicativeExpression "/" UnaryExpression -- divide
		| MultiplicativeExpression "%" UnaryExpression -- modulo
		| UnaryExpression
	
	UnaryExpression
		= "++" UnaryExpression -- increment
		| "--" UnaryExpression -- decrement
		| "+" UnaryExpression -- positive
		| "-" UnaryExpression -- negation
		| "!" UnaryExpression -- logicalNegation
		| "~" UnaryExpression -- onesComplement
		| PostfixExpression
	
	PostfixExpression
		= FunctionCall
		| PostfixExpression "." fieldIdentifier -- fieldAccess
		| PostfixExpression "[" IntegerExpression "]" -- arraySubscript
		| PostfixExpression "++" -- increment
		| PostfixExpression "--" -- decrement
		| PrimaryExpression
	
	IntegerExpression
		= Expression
	
	fieldIdentifier
		= identifier
	
	FunctionPrototype
		= ""
	
	FunctionCall
		= FunctionIdentifier "(" voidType? ")" -- withoutParams
		| FunctionIdentifier "(" FunctionCallParameterList ")" -- withParams
	
	FunctionIdentifier
		= PostfixExpression
		| TypeSpecifier
	
	FunctionCallParameterList
		= NonemptyListOf<AssignmentExpression, ",">
	
	PrimaryExpression
		= variableIdentifier
		| literal
		| "(" Expression ")" -- paren
	
	literal
		= boolLiteral
		| floatLiteral
		| integerLiteral
	
	StructSpecifier
		= "struct" identifier? "{" StructDeclarationList "}"
	
	StructDeclarationList
		= StructDeclaration+
	
	StructDeclaration
		= TypeQualifier* TypeSpecifier StructDeclaratorList ";"
	
	StructDeclaratorList
		= NonemptyListOf<StructDeclarator, ",">
	
	StructDeclarator
		= identifier arraySpecifier?
	
	TypeQualifier
		= storageQualifier
	
	boolLiteral
		= "true"
		| "false"
	
	floatLiteral
		= fractionalLiteral exponentPart? floatSuffix?
		| digit+ exponentPart floatSuffix?
	
	exponentPart
		= ("e" | "E") sign? digit+
	
	floatSuffix
		= "f" | "F" | "lf" | "LF"
	
	fractionalLiteral
		= digit+ "." digit*
		| digit* "." digit+
	
	integerLiteral
		= (decimalLiteral | hexadecimalLiteral | octalLiteral) integerSuffix?
	
	integerSuffix
		= "u"
		| "U"
	
	decimalLiteral
		= nonzeroDigit digit*
	
	octalLiteral
		= "0" octalDigit*
	
	hexadecimalLiteral
		= ("0x" | "0X") hexDigit+
	
	octalDigit
		= "0".."7"
	
	nonzeroDigit
		= "1".."9"
	
	variableIdentifier
		= identifier
	
	identifier
		= nondigit (nondigit | digit)*
	
	nondigit
		= "a".."z"
		| "A".."Z"
		| "_"
	
	sign
		= "+"
		| "-"
	
	unaryOperator
		= "+" | "-" | "!" | "~"
	
	TypeSpecifier
		= TypeSpecifierNonArray ArraySpecifier?
	
	TypeSpecifierNonArray
		= basicType
		| StructSpecifier
		| identifier //this will probably break something
	
	ArraySpecifier
		= ("[" ConditionalExpression? "]")+
	
	LayoutQualifier
		= "layout" "(" LayoutQualifierIdList ")"
	
	LayoutQualifierIdList
		= NonemptyListOf<LayoutQualifierId, ",">
	
	LayoutQualifierId
		= layoutQualifierName ("=" IntegerConstantExpression)?
	
	layoutQualifierName
		= identifier // we could define an exhaustive list here, but different shader stages allow for different layout qualifier names
	
	IntegerConstantExpression
		= IntegerExpression
	
	basicType
		= transparentType
		| opaqueType
	
	opaqueType
		= floatOpaqueType
		| signedIntegerOpaqueType
		| unsignedIntegerOpaqueType
		| samplerOpaqueType
	
	storageQualifier
		= "const" | "in" | "out" | "attribute" | "uniform" | "varying" | "buffer" | "shared"
	
	parameterQualifier
		= "const" | "inout" | "in" | "out"
	
	precisionQualifier
		= "highp" | "mediump" | "lowp"
	
	preciseQualifier
		= "precise"
	
	invariantQualifier
		= "invariant"
	
	memoryQualifier
		= "coherent" | "volatile" | "restrict" | "readonly" | "writeonly"
	
	interpolationQualifier
		= "smooth" | "flat" | "noperspective"
	
	transparentType
		= voidType
		| scalarType
		| vectorType
		| matrixType
	
	voidType
		= "void"
	
	scalarType
		=  "bool" | "int" | "uint" | "float" | "double"
	
	vectorType
		= "vec2" | "vec3" | "vec4" | "dvec2" | "dvec3" | "dvec4" | "bvec2" | "bvec3" | "bvec4" | "ivec2" | "ivec3" | "ivec4" | "uvec2" | "uvec3" | "uvec4"
	
	matrixType
		=  "mat2" | "mat3" | "mat4" | "mat2x2" | "mat2x3" | "mat2x4" | "mat3x2" | "mat3x3" | "mat3x4" | "mat4x2" | "mat4x3" | "mat4x4" | "dmat2" | "dmat3" | "dmat4" | "dmat2x2" | "dmat2x3" | "dmat2x4" | "dmat3x2" | "dmat3x3" | "dmat3x4" | "dmat4x2" | "dmat4x3" | "dmat4x4"
	
	floatOpaqueType
		= "sampler1D" | "texture1D" | "image1D" | "sampler1DShadow" | "sampler1DArray" | "texture1DArray" | "image1DArray" | "sampler1DArrayShadow" | "sampler2D" | "texture2D" | "image2D" | "sampler2DShadow" | "sampler2DArray" | "texture2DArray" | "image2DArray" | "sampler2DArrayShadow" | "sampler2DMS" | "texture2DMS" | "image2DMS" | "sampler2DMSArray" | "texture2DMSArray" | "image2DMSArray" | "sampler2DRect" | "texture2DRect" | "image2DRect" | "sampler2DRectShadow" | "sampler3D" | "texture3D" | "image3D" | "samplerCube" | "textureCube" | "imageCube" | "samplerCubeShadow" | "samplerCubeArray" | "textureCubeArray" | "imageCubeArray" | "samplerCubeArrayShadow" | "samplerBuffer" | "textureBuffer" | "imageBuffer" | "subpassInput" | "subpassInputMS"
	
	signedIntegerOpaqueType
		= "isampler1D" | "itexture1D" | "iimage1D" | "isampler1DArray" | "itexture1DArray" | "iimage1DArray" | "isampler2D" | "itexture2D" | "iimage2D" | "isampler2DArray" | "itexture2DArray" | "iimage2DArray" | "isampler2DMS" | "itexture2DMS" | "iimage2DMS" | "isampler2DMSArray" | "itexture2DMSArray" | "iimage2DMSArray" | "isampler2DRect" | "itexture2DRect" | "iimage2DRect" | "isampler3D" | "itexture3D" | "iimage3D" | "isamplerCube" | "itextureCube" | "iimageCube" | "isamplerCubeArray" | "itextureCubeArray" | "iimageCubeArray" | "isamplerBuffer" | "itextureBuffer" | "iimageBuffer" | "isubpassInput" | "isubpassInputMS"
	
	 unsignedIntegerOpaqueType
		= "usampler1D" | "utexture1D" | "uimage1D" | "usampler1DArray" | "utexture1DArray" | "uimage1DArray" | "usampler2D" | "utexture2D" | "uimage2D" | "usampler2DArray" | "utexture1DArray" | "uimage2DArray" | "usampler2DMS" | "utexture2DMS" | "uimage2DMS" | "usampler2DMSArray" | "utexture2DMSArray" | "uimage2DMSArray" | "usampler2DRect" | "utexture2DRect" | "uimage2DRect" | "usampler3D" | "utexture3D" | "uimage3D" | "usamplerCube" | "utextureCube" | "uimageCube" | "usamplerCubeArray" | "utextureCubeArray" | "uimageCubeArray" | "usamplerBuffer" | "utextureBuffer" | "uimageBuffer" | "atomic_uint" | "usubpassInput" | "usubpassInputMS"
	
	samplerOpaqueType
		= "sampler" | "samplerShadow"
}'