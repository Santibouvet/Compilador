%{
#include <stdio.h>
#include <stdlib.h> 
#include <math.h>
extern char *yytext;
extern int yyleng;
extern int yylex(void);
extern void yyerror(char*);
extern int yywrap();

%}
%union{
   char* cadena;
   int num;
} 
%token ASIGNACION INICIO FIN LEER ESCRIBIR COMA PYCOMA SUMA RESTA PARENIZQUIERDO PARENDERECHO FDT
%token <cadena> ID
%token <num> CONSTANTE
%%

objetivo: programa FDT

programa: INICIO listaSentencias FIN
;

listaSentencias: listaSentencias sentencia 
|sentencia
;

sentencia: ID {printf("el id es: %d",yyleng);if(yyleng>32) yyerror("ERROR SINTÁCTICO");} ASIGNACION expresion PYCOMA |
LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PYCOMA |
ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PYCOMA
;

listaIdentificadores: listaIdentificadores COMA ID |
ID
;

listaExpresiones: listaExpresiones COMA expresion |
expresion
;

expresion: primaria 
|expresion operadorAditivo primaria 
; 
primaria: ID
|CONSTANTE {printf("valores %d %d",atoi(yytext),$1); }
|PARENIZQUIERDO expresion PARENDERECHO
;
operadorAditivo: SUMA 
| RESTA
;
%%
int main() {
yyparse();
}
void yyerror (char *s){
printf ("mi error es %s\n",s);
}

int yywrap()
{
return 1;
}