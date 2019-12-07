%{
#include <stdio.h>
#include <stdlib.h>
extern FILE * yyin;
%}

%token TYPE RETURN ID NUM
%right "="
%left '+' '-'
%left '*' '/'
%right UMINUS
%left '!'

%%

S    : FUN {printf("Input accepted\n"); exit(0);}
FUN    : TYPE ID '(' PARAM ')' '{' BODY '}'     
      ;
PARAM    : PARAM ',' TYPE ID
    | TYPE ID
    |
    ;         
BODY    : BODY BODY
    | PARAM ';'
    | E ';'        
        | RETURN E ';'
        |
    ;              
E    : ID '=' E
    | E '+' E
    | E '-' E
    | E '*' E
    | E '/' E       
    | ID
    | NUM   
    ;
%%

int main(int argc, char* argv[])
{
	FILE *fh;
	printf("%s\n","Enter an Expression.");
	if (argc == 2 && (fh = fopen(argv[1], "r")))
        yyin = fh;

    yyparse();
}   
yyerror(char *s)
{
  fprintf(stderr, "%s\n",s);
}
yywrap()
{
  return(1);
}