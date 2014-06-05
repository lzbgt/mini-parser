/* Mini parser */
/* parser.lex */

%{
#include "heading.h"
#include "tok.h"
int yyerror(char *s);
%}

path        \.{0,2}[-a-zA-Z0-9\_]+(\.{1,2}[-a-zA-Z0-9_]+)*
%x STR OPR LOGIC NL_IN_STR STR_S
%%
    #define MAX_STR_CONST 512
    char string_buf[MAX_STR_CONST];
    char *string_buf_ptr;

<INITIAL,STR_S,OPR,LOGIC>[\n\t ]+               {}
<INITIAL>{path}                                 { BEGIN(OPR); yylval.path = new std::string(yytext); return PATH; }
<STR_S>\"                                       { string_buf_ptr = string_buf; BEGIN(STR); }
<STR_S>.                                        {
                                                    std::cerr << "SCANNER "; 
                                                    yyerror("expecting value quoted string as VALUE"); 
                                                    exit(1); 
                                                }

<STR>\"                                         {
                                                     BEGIN(LOGIC);
                                                     *string_buf_ptr = '\0';
                                                     yylval.value = new std::string(string_buf);
                                                     return VALUE;
                                                }
<STR>\n                                         { *string_buf_ptr++ = '\n'; }
<STR>\\n                                        { *string_buf_ptr++ = '\n'; }
<STR>\\t                                        { *string_buf_ptr++ = '\t'; }
<STR>"\\r"                                      { *string_buf_ptr++ = '\r'; }
<STR>"\\b"                                      { *string_buf_ptr++ = '\b'; }
<STR>"\\f"                                      { *string_buf_ptr++ = '\f'; }
<STR>[^\\\"]+                                   {
                                                    char *yptr = yytext;
                                                    while ( *yptr )
                                                        *string_buf_ptr++ = *yptr++;
                                                }

<OPR>"!="                                       { BEGIN(STR_S); yylval.op_val = new std::string(yytext); return NEQ; }
<OPR>"=="                                       { BEGIN(STR_S); yylval.op_val = new std::string(yytext); return EQ; }
<OPR>">="                                       { BEGIN(STR_S); yylval.op_val = new std::string(yytext); return NL; }
<OPR>"<="                                       { BEGIN(STR_S); yylval.op_val = new std::string(yytext); return NG; }
<OPR>">"                                        { BEGIN(STR_S); yylval.op_val = new std::string(yytext); return G; }
<OPR>"<"                                        { BEGIN(STR_S); yylval.op_val = new std::string(yytext); return L; }
<OPR>.                                          { 
                                                    std::cerr << "SCANNER "; 
                                                    yyerror("expecting one of != == >= <= > <"); exit(1); 
                                                }

<LOGIC>(?i:and)                              { BEGIN(INITIAL); yylval.logi_val = new std::string(yytext); return AND; }
<LOGIC>(?i:or)                               { BEGIN(INITIAL); yylval.logi_val = new std::string(yytext); return OR; }
.                                               { std::cerr << "SCANNER "; yyerror("mini-parser"); exit(1);}
