/*

- Para gerar o fonte digite
$ lex ex01.l

- Para compilar o fonte me C gerado digite
$ gcc ex01.yy.c

- Para executar
$ ./a.out

*/   


/* SEÇÃO DE DEFINIÇÕES */

%{
    /*
        Definições que estarão disponíveis 
            - variáveis
            - constantes
        O que for aqui será copiado para o arquivo *.yy.c
    
        Variáveis declaradas aqui estarão acessível nas funções yylex() e 
        main().
    */
    int contador = 0;
%}

/* Definições de Nomes */

TIPO		    "int"|"float"|"string"
INTEIRO              [0-9]+
FLOAT	             [0-9]+\.?[0-9]+
STRING               \"([^\\\"]|\\.)*\"
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*  
OPERADOR_ARITMETICO "+"|"-"|"*"|"/"|"="
OPERADOR_CONDICIONAL "se"|"senao"|"fim-se"|"para"|"de"|"ate"|"faca"|"fimpara"
OPERADOR_LOGICO     "||"|"&&"|"!"
OPERADOR_COMPARATIVO ">"|"<"|">="|"<="|"=="

/* FIM DA SEÇÃO DE DEFINIÇÕES */

%%
    /* SEÇAO DE REGRAS 
        Uma entrada por linha no formato:
        
        padrão  ação

    */

{TIPO}        	       {printf("<tipo, %s>", yytext); contador++;}
{INTEIRO}        	{printf("<int, %s>", yytext); contador++;}
{FLOAT}        	       {printf("<float, %s>", yytext); contador++;}
{STRING}        	{printf("<str, %s>", yytext); contador++;}
{OPERADOR_ARITMETICO}  {printf("<op_ari, %s>", yytext); contador++;}
{OPERADOR_COMPARATIVO}  {printf("<op_comp, %s>", yytext); contador++;}
{OPERADOR_CONDICIONAL} {printf("<op_cond, %s>", yytext); contador++;}
{OPERADOR_LOGICO}      {printf("<op_log, %s>", yytext); contador++;}
{IDENTIFICADOR}        {printf("<identificador, %s>", yytext); contador++;}
<<EOF>>                return 0;
    
%%

/*
Seção de Código do Usuário
*/

int yywrap() {}
int main() {
    printf("Iniciando Análise Léxica...\n---\n");
    yylex();
    printf("Foram encontradas %d ocorrências de identificadores.\n", contador);
    printf("---\nÁnalise Finalizada!\n");
    
    return 0;
}
