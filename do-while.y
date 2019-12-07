%{
#include <stdio.h>
#include <stdlib.h>
extern FILE * yyin;
%}

%token ID NUM DO WHILE LE GE EQ NE OR AND
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'

%%

S : ST1 {printf("Input accepted.\n");exit(0);};
ST1    :    DO '{' ST '}' WHILE'(' E2 ')'';';
ST      :     ST ST
          | E';'
          ;
E       : ID'='E
         | E'+'E
         | E'-'E
         | E'*'E
         | E'/'E
         | E'<'E
         | E'>'E
         | E LE E
         | E GE E
         | E EQ E
         | E NE E
         | E OR E
         | E AND E
         | ID
         | NUM
         ;
E2     : E'<'E
         | E'>'E
         | E LE E
         | E GE E
         | E EQ E
         | E NE E
         | E OR E
         | E AND E
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