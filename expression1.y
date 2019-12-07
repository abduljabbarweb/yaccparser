%{
#include<stdio.h>
#include <stdlib.h>
%}

%token DIGIT
%%
S    : E '\n' {printf("%d\n",$1);return 1;}
    ;
E    : E '+'    T    { $$ = $1 + $3 ; }
    | T
    ;
T    : T '*'    F    { $$ = $1 * $3; }
    | F
    ;
F    : '(' E    ')'    { $$=$2; }
    | DIGIT
    ;
%%
yylex(){
int c;
c=getchar();
if(isdigit(c))
{
    yylval=c-'0';
    return DIGIT;
}

return c;
}
main()
{
printf("Enter the exp:");
yyparse();   
return 0;
}
yyerror(char *s)
{
  fprintf(stderr, "%s\n",s);
}
yywrap()
{
  return(1);
}