/* Escreva uma analisador capaz de extrair os tokens de uma expressão
 * aritimética simples, incluindo parenteses.*/

%{

/* Código Global C que será copiado para o fonte */
/* #includes, variáveis globais e constantes vão aqui... */

#include "parser.tab.h"

%}



TIPO		    "int"|"float"|"string"
INTEIRO              [0-9]+
FLOAT	             [0-9]+\.?[0-9]+
STRING               \"([^\\\"]|\\.)*\"
IDENTIFICADOR        [_a-zA-Z][_a-zA-Z0-9]*  
OPERADOR_CONDICIONAL "se"|"senao"|"fim-se"|"para"|"de"|"ate"|"faca"|"fimpara"
/*OPERADOR_LOGICO     "||"|"&&"|"!" */
/*OPERADOR_COMPARATIVO ">"|"<"|">="|"<="|"=="*/
%%



{TIPO}        	        {return TIPO;}
{INTEIRO}        	{strncpy(yylval.simbolo, yytext, 50); return INTEIRO;}
{FLOAT}        	        {strncpy(yylval.simbolo, yytext, 50); return FLOAT;}
{STRING}        	{strncpy(yylval.simbolo, yytext, 50); return STRING;}
{OPERADOR_CONDICIONAL}  {return OPERADOR_CONDICIONAL;}
{IDENTIFICADOR}         {strncpy(yylval.simbolo, yytext, 50); return IDENTIFICADOR;}
"\*"        		{return MUL;}
"/"         		{return DIV;}
"\+"         		{return ADD;}
"\-"         		{return SUB;}
"\>"			{return GRE;}
"\>="			{return GRET;}
"\<"			{return LOW;}
"\<="			{return LOWT;}
"\=="			{return EQU;}
"\||"			{return OR;}
"\&&"			{return AND;}
"\!"			{return NOT;}
"\("         		{return APAR;}
"\)"         		{return FPAR;}
"\n"         		{return EOL;}

%%
/* Fim das Regras */
/* Código C abaixo será incluído nos fontes. */

int yywrap() {}

