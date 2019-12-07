%{
#include<stdio.h>
#include<stdlib.h>
extern FILE * yyin;
%}

%token ID NUM SWITCH CASE DEFAULT BREAK LE GE EQ NE AND OR IF THEN WHILE
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'

%%

S    :    ST{printf("Input accepted.\n");exit(0);};
      ;
ST  :    SWITCH'('ID')''{'B'}'
      ;
B    :    C
      |    C D
      ;
C  :    C C
    |    CASE NUM':'ST1 BREAK';'
    ;
D  :    DEFAULT':'ST1 BREAK';'
    |    DEFAULT':'ST1
    ;
ST1    :    WHILE'('E2')' E';'
    |    IF'('E2')'THEN E';'
    |    ST1 ST1
    |    E';'
    ;
E2    :    E'<'E
    |    E'>'E
    |    E LE E
    |    E GE E
    |    E EQ E
    |    E NE E
    |    E AND E
    |    E OR E
    ;
E    :    ID'='E
    |    E'+'E
    |    E'-'E
    |    E'*'E
    |    E'/'E
    |    E'<'E
    |    E'>'E
    |    E LE E
    |    E GE E
    |    E EQ E
    |    E NE E
    |    E AND E
    |    E OR E
    |    ID
    |    NUM
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