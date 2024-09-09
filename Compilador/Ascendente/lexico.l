%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}
digito [0-9]

letra [a-zA-Z]

identificador {letra}({letra}|{digito})*

constEntera {digito}({digito})*
%%
":=" {return ASIGNACION;}
{constEntera} {yylval.num=atoi(yytext);return CONSTANTE;}
"inicio" {return INICIO;}
"fin" {return FIN;}
"leer" {return LEER;}
"escribir" {return ESCRIBIR;}
{identificador} {sscanf(yytext, "%s", yylval.cadena); return ID;}
"," {return COMA;}
";" {return PYCOMA;}
"(" {return PARENIZQUIERDO;}
")" {return PARENDERECHO;}
"+" {return SUMA;}
"-" {return RESTA;}
%%