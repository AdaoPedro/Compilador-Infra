%{
	#include <stdio.h>
	#include <string.h>
	#include "common.h"
	char mensagem_final[100];
	#define YYDEBUG 1
%}

%token PROGRAM FUNCTION END_FUNCTION END_PROCEDURE PROCEDURE CONSTANT MAIN READ
%token  PRINT CONTINUE BREAK EXIT FOR END_FOR
%token IDENTIFICADOR NUMERO TIPO PRODUCE DECLARE TEXTO BINARIO CARACTER
%token END_WHILE WHILE END_IF THEN ELSE IF 

%token OP_AND OP_OR
%token OP_CONCATENACAO
%token OP_DEC OP_INC

%right OP_ATRIBUICAO
%left OP_IGUAL OP_DIFERENTE OP_MAIORQUE OP_MENORQUE OP_MAIORIGUALQUE OP_MENORIGUALQUE
%left OP_SOMA OP_SUBTRACAO 
%left OP_MULTIPLICACAO OP_DIVISAO 
%right OP_MODULO

%error-verbose
%start program

%%

declaracoes_locais
	: declaracoes_locais declaracao_local
	|
	;

declaracao_local
	: declarar_variaveis_locais
	| declarar_constantes_locais
	| declaracao_if
	| declaracao_while
	| declaracao_for
	| atribuir_dado
	| chamar_bloco
	| chamar_print
	| chamar_read
	| chamar_exit
	| declarar_saltos
	;
	
declarar_variaveis_locais
	: DECLARE IDENTIFICADOR ':' TIPO ';'
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_numerica ';'
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_literal ';'
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO BINARIO ';'
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO chamar_bloco
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO chamar_read
	| declaracao_multipla { /* 1º parser.y: conflitos: 1 de deslocamento/redução */ }
	;
	
declaracao_multipla
	: DECLARE lista_identificadores ':' TIPO ';'
	;
	
lista_identificadores
	: IDENTIFICADOR lista_idents
	;

lista_idents
	: ',' IDENTIFICADOR lista_idents
	|
	;
	
declarar_constantes_locais
	: DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_numerica ';'
	| DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_literal ';'
	| DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO BINARIO ';'
	| DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO chamar_bloco
	| DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO chamar_read
	;

declaracoes_globais
	: declaracoes_globais declaracao_global
	|
	;
	
declaracao_global
	: declarar_variaveis_globais
	| declarar_constantes_globais
	;
	
declarar_variaveis_globais
	: DECLARE IDENTIFICADOR ':' TIPO ';'
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_numerica ';'
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_literal ';'
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO BINARIO ';'
	| declaracao_multipla { /* 2º parser.y: conflitos: 2 de deslocamento/redução */ }
	;
	
declarar_constantes_globais
	: DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_numerica ';'
	| DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_literal ';'
	| DECLARE CONSTANT IDENTIFICADOR ':' TIPO OP_ATRIBUICAO BINARIO ';'
	;
	
declarar_saltos
	: CONTINUE ';'
	| BREAK ';'
	| retorno
	;
	
retorno
	: PRODUCE expressao_numerica ';'
	| PRODUCE expressao_literal ';'
	| PRODUCE BINARIO ';'
	| PRODUCE chamar_bloco
	;
	
expressao_numerica
	: NUMERO
	| IDENTIFICADOR { /* 3º parser.y: conflitos: 2 de deslocamento/redução, 10 de redução/redução */ }
	| operacao
	| '(' expressao_numerica ')'
	;
	
operacao
	: expressao_numerica OP_DIVISAO expressao_numerica
	| expressao_numerica OP_MODULO expressao_numerica
	| expressao_numerica OP_MULTIPLICACAO expressao_numerica
	| expressao_numerica OP_SUBTRACAO expressao_numerica
	| expressao_numerica OP_SOMA expressao_numerica
	;
	
expressao_comparacao
	: expressao_numerica OP_DIFERENTE expressao_numerica
	| expressao_numerica OP_MAIORIGUALQUE expressao_numerica
	| expressao_numerica OP_MAIORQUE expressao_numerica
	| expressao_numerica OP_MENORIGUALQUE expressao_numerica
	| expressao_numerica OP_MENORQUE expressao_numerica
	| expressao_numerica OP_IGUAL expressao_numerica
	| expressao_comparacao OP_AND exps_comparacao
	| expressao_comparacao OP_OR exps_comparacao
	| '(' expressao_comparacao ')'
	;
	
exps_comparacao
	: expressao_numerica OP_DIFERENTE expressao_numerica
	| expressao_numerica OP_MAIORIGUALQUE expressao_numerica
	| expressao_numerica OP_MAIORQUE expressao_numerica
	| expressao_numerica OP_MENORIGUALQUE expressao_numerica
	| expressao_numerica OP_MENORQUE expressao_numerica
	| expressao_numerica OP_IGUAL expressao_numerica
	| '(' exps_comparacao ')'
	;
	
expressao_literal
	: TEXTO
	| CARACTER
	| IDENTIFICADOR
	| expressao_literal OP_CONCATENACAO exps_literal
	| '(' expressao_literal ')'
	;

exps_literal
	: TEXTO
	| CARACTER
	| IDENTIFICADOR
	;
	
declaracao_if
	: IF '(' expressao_comparacao ')' THEN declaracoes_locais END_IF
	| IF '(' expressao_comparacao ')' THEN declaracoes_locais ELSE declaracoes_locais END_IF
	;
	
declaracao_while
	: WHILE '(' expressao_comparacao ')' declaracoes_locais END_WHILE
	;
	
declaracao_for
	: FOR '(' expr_inicializacao ';' expressao_comparacao ';' expr_dec_inc ')' declaracoes_locais END_FOR
	;
	
expr_inicializacao
	: IDENTIFICADOR OP_ATRIBUICAO expressao_numerica
	| DECLARE IDENTIFICADOR ':' TIPO OP_ATRIBUICAO expressao_numerica
	;

expr_dec_inc
	: IDENTIFICADOR OP_INC
	| OP_INC IDENTIFICADOR 
	| IDENTIFICADOR OP_DEC
	| OP_DEC IDENTIFICADOR 
	;
	
atribuir_dado
	: IDENTIFICADOR OP_ATRIBUICAO expressao_literal ';'
	| IDENTIFICADOR OP_ATRIBUICAO expressao_numerica ';'
	| IDENTIFICADOR OP_ATRIBUICAO BINARIO ';'
	| IDENTIFICADOR OP_ATRIBUICAO chamar_bloco
	| IDENTIFICADOR OP_ATRIBUICAO chamar_read
	;
	
chamar_print
	: PRINT '(' expressao_comparacao ')' ';'
	| PRINT '(' expressao_literal ')' ';'
	| PRINT '(' expressao_numerica ')' ';'
	| PRINT '(' BINARIO ')' ';'
	| PRINT '(' IDENTIFICADOR '(' argumentos ')' ')' ';' { /* imprimir funcao 4º parser.y: conflitos: 2 de deslocamento/redução, 11 de redução/redução */ }
	;
	
chamar_exit
	: EXIT '(' ')' ';'
	;
	
chamar_read
	: READ '('')' ';'
	;
	
chamar_bloco
	: IDENTIFICADOR '(' argumentos ')' ';'
	;
	
argumentos
	: argumentos argumento
	|
	;
	
argumento
	: expressao_literal
	| expressao_numerica
	| BINARIO
	| IDENTIFICADOR '(' argumentos ')' { /* 5º passar argumento vindo de funcao parser.y: conflitos: 3 de deslocamento/redução, 12 de redução/redução */ }
	| argumento ',' outros_argumentos
	;
	
outros_argumentos
	: expressao_literal
	| expressao_numerica
	| BINARIO
	| IDENTIFICADOR '(' argumentos ')' { /* 6º parser.y: conflitos: 4 de deslocamento/redução, 20 de redução/redução */ }
	;
	
blocos
	: blocos bloco
	|
	;
	
bloco 
	: FUNCTION IDENTIFICADOR '(' parametros ')' ':' TIPO declaracoes_locais END_FUNCTION
	| PROCEDURE IDENTIFICADOR '(' parametros ')' declaracoes_locais END_PROCEDURE
	;
	
parametros
	: parametros parametro
	| 
	;
	
parametro
	: IDENTIFICADOR ':' TIPO
	| parametro ',' outros_parametros
	;
	
outros_parametros
	: IDENTIFICADOR ':' TIPO
	;
	
bloco_main
	: PROCEDURE MAIN '(' ')' declaracoes_locais END_PROCEDURE
	;

program
	: PROGRAM IDENTIFICADOR ';' declaracoes_globais blocos bloco_main
	;
	
%%

void yyerror(const char *s)
{
	fflush(stdout);
	printf("\nME%sLE%d", s, line);
	strcpy(mensagem_final,"\nMFFFalha, compilacao sem exito.");
}

int yywrap()
{
	return 1;
}

int main( int argc, char *argv[] )
{
	strcpy(mensagem_final, "\nMFOExito, codigo compilado com sucesso.");
	
	yyparse();
	
	printf("\n\t%s", mensagem_final);
	return 0;
}

