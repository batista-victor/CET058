%{

/* Código C, use para #include, variáveis globais e constantes
 * este código ser adicionado no início do arquivo fonte em C
 * que será gerado.
 */

#include <stdio.h>
#include <stdlib.h>

typedef struct No {
    char token[50];
    struct No** filhos;
    int num_filhos;
} No;


No* allocar_no();
No** allocar_filhos();
void liberar_no(void* no);
void imprimir_arvore(No* raiz);
No* novo_no(char *, No**, int);

%}

/* Declaração de Tokens no formato %token NOME_DO_TOKEN */
%union 
{
    int number;
    char simbolo[50];
    struct No* no;
}
%token INTEIRO
%token FLOAT
%token STRING
%token IDENTIFICADOR
%token OPERADOR_CONDICIONAL
%token OPERADOR_LOGICO
%token OPERADOR_COMPARATIVO
%token TIPO
%token GRE
%token LOW
%token EQU
%token GRET
%token LOWT
%token NOT
%token AND
%token OR
%token ADD
%token SUB
%token MUL
%token DIV
%token APAR
%token FPAR
%token EOL

%type<no> calc
%type<no> termo
%type<no> fator
%type<no> exp
%type<no> operador

%type<simbolo>  TIPO
%type<simbolo>  INTEIRO
%type<simbolo>  FLOAT
%type<simbolo>  STRING
%type<simbolo>  IDENTIFICADOR
%type<simbolo>  OPERADOR_CONDICIONAL
%type<simbolo>  OPERADOR_LOGICO
%type<simbolo>  OPERADOR_COMPARATIVO
%type<simbolo> MUL
%type<simbolo> DIV
%type<simbolo> SUB
%type<simbolo> ADD
%type<simbolo> GRE
%type<simbolo> LOW
%type<simbolo> EQU
%type<simbolo> GRET
%type<simbolo> LOWT
%type<simbolo> NOT
%type<simbolo> AND
%type<simbolo> OR


%%
/* Regras de Sintaxe */

calc:
    | calc exp EOL { imprimir_arvore($2); }

exp: fator                
    | exp ADD fator {
        No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("+", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
    | exp SUB fator {
        No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("-", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }

     | exp GRE termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no(">", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
     | exp LOW termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("<", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
     | exp EQU termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("==", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
     | exp GRET termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no(">=", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
     | exp LOWT termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("<=", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
     | exp NOT termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("!", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
     | exp OR termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("||", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
     | exp AND termo {
	No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("&&", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("exp", filhos, 3);
    }
    ;


fator: termo
    | fator MUL termo {
        No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("*", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("fator", filhos, 3);
    }
    | fator DIV termo {
        No** filhos = allocar_filhos(3);
        filhos[0] = $1;
        filhos[1] = novo_no("/", NULL, 0);
        filhos[2] = $3;

        $$ = novo_no("fator", filhos, 3);
    }
    ;

//operador: OPERADOR_LOGICO { $$ = novo_no($1, NULL, 0); }
//	| OPERADOR_COMPARATIVO { $$ = novo_no($1, NULL, 0);}
//        | OPERADOR_CONDICIONAL {$$ = novo_no($1, NULL, 0);}
;

termo: IDENTIFICADOR { $$ = novo_no($1, NULL, 0);}
      | INTEIRO { $$ = novo_no($1, NULL, 0); }
      | FLOAT { $$ = novo_no($1, NULL, 0); }
      | STRING { $$ = novo_no($1, NULL, 0); }


%%

/* Código C geral, será adicionado ao final do código fonte 
 * C gerado.
 */

No* allocar_no() {
    return (No*) malloc(sizeof(No));
}

No** allocar_filhos(int num_filhos) {
    return (No**) malloc(num_filhos * sizeof(No*));
}

void liberar_no(void* no) {
    free(no);
}

No* novo_no(char* token, No** filhos, int num_filhos) {
   No* no = allocar_no();
   snprintf(no->token, 50, "%s", token);
   no->filhos = filhos;
   no->num_filhos = num_filhos;

   return no;
}

void imprimir_arvore(No* raiz) {
   if(raiz == NULL) { printf("***"); return; }
    printf("[%s", raiz->token);
    if (raiz->filhos != NULL)
    {
        
	imprimir_arvore(raiz->filhos[0]);
        imprimir_arvore(raiz->filhos[1]);
        imprimir_arvore(raiz->filhos[2]);

    }
    
    printf("]");

}

int main(int argc, char** argv) {
    yyparse();
}

yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}
