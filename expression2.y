%{
#include <stdio.h>
%}

%token DIGIT

%%
S       : E '\n' {printf("%d\n",$1);return 1;}
        ;
E       : E '+' T { $$ = $1 + $3 ;}
        | T
        ;
T       :T '-' FF { $$ = $1 - $3 ;}
        | FF
        ;
FF      :FF '/' FFF { $$ = $1 / $3 ;}
        |FFF;
FFF     :FFF '*' F { $$ =$1*$3 ;}
        |F
        ;
F       : '(' E ')' { $$ = $2 ;}
        |DIGIT
        ;
%%

yylex()
{
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
}
yyerror(char *s)
{
  fprintf(stderr, "%s\n",s);
}
yywrap()
{
  return(1);
}