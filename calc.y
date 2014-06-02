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
}

%start	input 

%token	<path>	    PATH
%token	<value>	    VALUE
%token  <space>     SPACE
%type	<value>     exp
%left	<op_val> EQ NEQ NL NG G L
%left	<op_val> AND OR

%%

input:		/* empty */
		| exp	{ cout << "Result: " << $1 << endl; }
		;

exp:    PATH SPACE EQ SPACE VALUE	  { cout<<$1<<" eq "<<$2;}
		| PATH SPACE NEQ SPACE VALUE  { cout<<$1<<" eq "<<$2;}
		| PATH SPACE G SPACE VALUE	  { cout<<$1<<" eq "<<$2;}
        | PATH SPACE L SPACE VALUE	  { cout<<$1<<" eq "<<$2;}
        | exp SPACE AND SPACE exp	  { cout<<$1<<" eq "<<$2;}
        | exp SPACE OR SPACE exp	  { cout<<$1<<" eq "<<$2;}
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


