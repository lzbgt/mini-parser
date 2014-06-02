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
}

%start	input 

%token	<path>	    PATH
%token	<value>	    VALUE
%type	<value>     exp
%left	EQ NEQ NL NG G L
%left	AND OR

%%

input:		/* empty */
		| exp	{ cout << "Result: " << $1 << endl; }
		;

exp:    PATH EQ VALUE	  { printf("%s eq %s \n", $1,$2);}
		| PATH NEQ VALUE  { printf("%s neq %s \n", $1,$2);}
		| PATH G VALUE	  { printf("%s g %s \n", $1,$2);}
        | PATH L VALUE	  { printf("%s L %s \n", $1,$2);}
        | exp AND exp	  { printf("%s and %s \n", $1,$2);}
        | exp OR exp	  { printf("%s or %s \n", $1,$2);}
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


