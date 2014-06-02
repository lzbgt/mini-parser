/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
  string*		path;
  string*	    value;
  string*	    op_val;
  string*       space;
  int           result
}

%start	input 

%token	<path>	    PATH
%token	<value>	    VALUE
%token  <space>     SPACE
%type	<result>     exp
%left	<op_val> EQ NEQ NL NG G L
%left	<op_val> AND OR

%%

input:		/* empty */
		| exp	{ cout << "Result: " << $1 << endl; }
		;

exp:    PATH SPACE EQ SPACE VALUE	  { $$ = 0; cout << *$1 << *$2 << *$3 << *$4 << *$5;}
		| PATH SPACE NEQ SPACE VALUE  { $$ = 1; cout << *$1 << *$2 << *$3 << *$4 << *$5;}
		| PATH SPACE G SPACE VALUE	  { $$ = 2; cout << *$1 << *$2 << *$3 << *$4 << *$5;}
        | PATH SPACE L SPACE VALUE	  { $$ = 3; cout << *$1 << *$2 << *$3 << *$4 << *$5;}
        | exp SPACE AND SPACE exp	  { $$ = 4; cout << $1 << *$2 << *$3 << *$4 << $5;}
        | exp SPACE OR SPACE exp	  { $$ = 5; cout << $1 << *$2 << *$3 << *$4 << $5;}
		;

%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}


