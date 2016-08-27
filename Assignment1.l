%{
#include<cstdio>
#include<iostream>
#include <fstream>
    using namespace std;
#define YY_DECL extern "C" int yylex()
int error_count = 0;
ofstream flexoutfile;

%}

%%
[ \t\n] ;
\/\/(.*?)\n    ;
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]
[0-9]+\.[0-9]+ {flexoutfile << "Float" << endl << yytext << endl;}
[0-9]+ {flexoutfile << "Integer" << endl << yytext << endl;}
if {flexoutfile << "Keyword" << endl << yytext << endl;}
else {flexoutfile << "Keyword" << endl << yytext << endl;}
while {flexoutfile << "Keyword" << endl << yytext << endl;}
for {flexoutfile << "Keyword" << endl << yytext << endl;}
int {flexoutfile << "Keyword" << endl << yytext << endl;}
float {flexoutfile << "Keyword" << endl << yytext << endl;}
[a-zA-z][_a-zA-Z0-9]*    { flexoutfile << "Identifier" << endl << yytext << endl;}
\= {flexoutfile << "Assignment" << endl << yytext << endl;}
\=\= {flexoutfile << "Comparison" << endl << yytext << endl;}
\>\= {flexoutfile << "Comparison" << endl << yytext << endl;}
\<\= {flexoutfile << "Comparison" << endl << yytext << endl;}
\> {flexoutfile << "Comparison" << endl << yytext << endl;}
\< {flexoutfile << "Comparison" << endl << yytext << endl;}
\+ {flexoutfile << "Operator" << endl << yytext << endl;}
\- {flexoutfile << "Operator" << endl << yytext << endl;}
\* {flexoutfile << "Operator" << endl << yytext << endl;}
\/ {flexoutfile << "Operator" << endl << yytext << endl;}
\{ {flexoutfile << "Open-bracket" << endl << yytext << endl;}
\} {flexoutfile << "Close-bracket" << endl << yytext << endl;}
\( {flexoutfile << "Open-paren" << endl << yytext << endl;}
\) {flexoutfile << "Close-paren" << endl << yytext << endl;}
; {flexoutfile << "Semicolon" << endl << yytext << endl;}
. {++error_count;}
%%
int main(int argc, char* argv[])
{
	//  if( argc > 2 ) /* argc should be 2 for correct execution */
    //  {
    //     /* We print argv[0] assuming it is the program name */
    //     cout << "Usage: " << argv[0] << " filename" << endl;
    //     return -1;
    //  }
     if(argc == 2)
     {
        // We assume argv[1] is a filename to open

        FILE *myfile = fopen( argv[1], "r" );
        if (!myfile) {
            cout << "Can't open file: " << argv[1] << endl;
            return -1;
        }

        // set lex to read from it instead of defaulting to STDIN:
        yyin = myfile;
        flexoutfile.open("flex_output.txt");
        yylex();

        if(error_count) {
            cout << "Syntax error" << endl;
        }
        else {
            cout << "Success" << endl;
        }
        flexoutfile.close();
    }


    return 0;
}
