%{
#include <stdio.h>
%}

%%

[0-9]+              { printf("NÚMERO: %s\n", yytext); }


si                  { printf("PALABRA RESERVADA: SI\n"); }
entonces            { printf("PALABRA RESERVADA: ENTONCES\n"); }
mientras            { printf("PALABRA RESERVADA: MIENTRAS\n"); }
repetir             { printf("PALABRA RESERVADA: REPETIR\n"); }
hasta               { printf("PALABRA RESERVADA: HASTA\n"); }
inicio              { printf("PALABRA RESERVADA: INICIO\n"); }
fin                 { printf("PALABRA RESERVADA: FIN\n"); }


[a-z_][a-z0-9_]*    { printf("IDENTIFICADOR MINUSCULA: %s\n", yytext); }


[A-Z_][A-Z0-9_]*    { printf("IDENTIFICADOR EN MAYUSCULA: %s\n", yytext); }


"+"                 { printf("SUMA: %s\n", yytext); }
"-"                 { printf("RESTA: %s\n", yytext); }
"*"                 { printf("MULTIPLICACIÓN: %s\n", yytext); }
"/"                 { printf("DIVISIÓN: %s\n", yytext); }


[ \t\n]+            { /* Ignorar espacios en blanco */ }


.                   { printf("CARÁCTER DESCONOCIDO: %s\n", yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            printf("No se pudo abrir el archivo %s\n", argv[1]);
            return 1;
        }
        yyin = f;
        yylex();
        fclose(f);
    } else {
        printf("No se proporcionó archivo de entrada\n");
    }
    return 0;
}
