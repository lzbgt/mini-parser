/* Mini parser */
/* parser.lex */

%{
#include "heading.h"
#include "tok.h"
int yyerror(char *s);
%}

path        @\.{0,2}[-a-zA-Z0-9\_]+(\.{1,2}[-a-zA-Z0-9_]+)*
value       (\"[- @\%\#\.\[\]\{\}\\\+\|\/\*\?\(\)a-zA-Z0-9\_]*\")
%%

{path}	    { yylval.path = new std::string(yytext); return PATH; }
{value}	    { yylval.value = new std::string(yytext); return VALUE; }
"!="		{ yylval.op_val = new std::string(yytext); return NEQ; }
"=="		{ yylval.op_val = new std::string(yytext); return EQ; }
">="		{ yylval.op_val = new std::string(yytext); return NL; }
"<="		{ yylval.op_val = new std::string(yytext); return NG; }
">"		    { yylval.op_val = new std::string(yytext); return G; }
"<"		    { yylval.op_val = new std::string(yytext); return L; }
"and"		{ yylval.op_val = new std::string(yytext); return AND; }
"or"		{ yylval.op_val = new std::string(yytext); return OR; }

[ \t]+		{ yylval.value = new std::string(" "); return SPACE;}
[\n]		{ yylineno++;	}

.		{ std::cerr << "SCANNER "; yyerror("abcde"); exit(1);	}

