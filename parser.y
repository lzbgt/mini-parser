/* Mini Parser */
/* parser.y */

%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
  string*       path;
  string*       value;
  string*       op_val;
  string*       logi_val;
  int           result;
}

%start    input 

%token    <path>       PATH
%token    <value>      VALUE
%type     <result>     exp
%left     <op_val>     EQ NEQ NL NG G L
%left     <logi_val>   AND OR

%%

input:        /* empty */
        | exp    { cout << "Result: " << $1 << endl; }
        ;

exp:    PATH EQ VALUE      { $$ = 0; cout << *$1 << *$2 << *$3; char c = 'A';cout<<char(c+$$); delete $1,$2,$3;}
        | PATH NEQ VALUE   { $$ = 1; cout << *$1 << *$2 << *$3; char c = 'A';cout<<char(c+$$); delete $1,$2,$3;}
        | PATH G VALUE     { $$ = 2; cout << *$1 << *$2 << *$3; char c = 'A';cout<<char(c+$$); delete $1,$2,$3;}
        | PATH L VALUE     { $$ = 3; cout << *$1 << *$2 << *$3; char c = 'A';cout<<char(c+$$); delete $1,$2,$3;}
        | PATH NG VALUE    { $$ = 4; cout << *$1 << *$2 << *$3; char c = 'A';cout<<char(c+$$); delete $1,$2,$3;}
        | PATH NL VALUE    { $$ = 5; cout << *$1 << *$2 << *$3; char c = 'A';cout<<char(c+$$); delete $1,$2,$3;}
        | exp AND exp      { $$ = 6; cout << $1 << " AND " << $3; char c = 'A';cout<<char(c+$$); delete $2;}
        | exp OR exp       { $$ = 7; cout << $1 << " OR " << $3; char c = 'A';cout<<char(c+$$); delete $2;}
        ;

%%

int yyerror(string s)
{
  extern int yylineno;    // defined and maintained in lex.c
  extern char *yytext;    // defined and maintained in lex.c  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}