DECAF:
		#bison -d --verbose decaf.y -o decaf.tab.cc
		flex -o lex.yy.cc Assignment1.l
		g++ lex.yy.cc -ll -o decaf

