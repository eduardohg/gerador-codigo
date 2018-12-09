%{
  #include <stdio.h>
  #include<string.h>
  #include<stdlib.h>
  extern int yylex();
  #define tamanho 100000
  extern char* yytext;
  extern int lines;
  extern int chars;
  extern char vet[tamanho];
  extern char vet2[tamanho];
  extern int erro_sint;
  int linha,coluna;
  char tok[tamanho];
  char *string;
  extern int end;
  extern int varcoluna;
  int yyerror(char *s);

%}

%token VOID
%token INT
%token CHAR
%token RETURN
%token DO
%token WHILE
%token FOR
%token IF
%token ELSE
%token PLUS
%token MINUS
%token MULTIPLY
%token DIV
%token REMAINDER
%token INC
%token DEC
%token BITWISE_AND
%token BITWISE_OR
%token BITWISE_NOT
%token BITWISE_XOR
%token NOT
%token LOGICAL_AND
%token LOGICAL_OR
%token EQUAL
%token NOT_EQUAL
%token LESS_THAN
%token GREATER_THAN
%token LESS_EQUAL
%token GREATER_EQUAL
%token R_SHIFT
%token L_SHIFT
%token ASSIGN
%token ADD_ASSIGN
%token MINUS_ASSIGN
%token SEMICOLON
%token COMMA
%token COLON
%token L_PAREN
%token R_PAREN
%token L_CURLY_BRACKET
%token R_CURLY_BRACKET
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token TERNARY_CONDITIONAL
%token NUMBER_SIGN
%token PRINTF
%token SCANF
%token DEFINE
%token EXIT
%token COMMENT
%token INITIAL
%token NUM_OCTAL
%token NUM_HEXA
%token NUM_INTEGER
%token IDENTIFIER
%token CHARACTER
%token STRING
%token BREAK
%token SWITCH
%token CASE
%token DEFAULT
%token TYPEDEF
%token STRUCT
%token POINTER
%token END_FILE

%start inicio

%%

  inicio: programa END_FILE {printf("SUCCESSFUL COMPILATION."); return 0;}
  ;

  programa: declaracoes prog {}
          | funcao prog {}
  ;

  prog: programa {}
      | {}
  ;

  declaracoes: NUMBER_SIGN DEFINE IDENTIFIER expressao {}
             | declaracao_variavel {}
             | declaracao_prototipo {}
  ;

  funcao: tipo funcao2 {}
  ;

  funcao2: MULTIPLY funcao2 {}
         | IDENTIFIER parametros L_CURLY_BRACKET funcao3 {}
  ;

  funcao3: comandos R_CURLY_BRACKET {}
         | declaracao_variavel funcao3 {}
  ;

  declaracao_variavel: tipo decvar2 {}

  ;

  decvar2: MULTIPLY decvar2 {}
         | IDENTIFIER decvar3 {}
  ;

  decvar3: L_SQUARE_BRACKET expressao R_SQUARE_BRACKET decvar3 {}
         | ASSIGN exp_atrib decvar4 {}
         | decvar4 {}

  ;

  decvar4: SEMICOLON {}
         | COMMA decvar2 {}
  ;

  declaracao_prototipo: tipo decprot2 {}

  ;

  decprot2: MULTIPLY decprot2 {}
          | IDENTIFIER parametros SEMICOLON {}
  ;

  parametros: L_PAREN param2 {}

  ;

  param2: R_PAREN {}
        | param3 {}
  ;

  param3: tipo param4 {}

  ;

  param4: MULTIPLY param4 {}
        | IDENTIFIER param5 {}
  ;

  param5: COMMA param3 {}
        | R_PAREN {}
        | L_SQUARE_BRACKET expressao R_SQUARE_BRACKET param5 {}
  ;

  tipo: INT {}
      | CHAR {}
      | VOID {}
  ;

  bloco: L_CURLY_BRACKET comandos R_CURLY_BRACKET {}

  ;

  comandos: lista_comandos comandos2 {}

  ;

  comandos2: comandos {}
           | {}
  ;

  lista_comandos: DO bloco WHILE L_PAREN expressao R_PAREN SEMICOLON {}
                | IF L_PAREN expressao R_PAREN bloco lista_comandos2 {}
                | WHILE L_PAREN expressao R_PAREN bloco {}
                | FOR L_PAREN lista_comandos3 {}
                | PRINTF L_PAREN STRING lista_comandos4 {}
                | SCANF L_PAREN STRING COMMA BITWISE_AND IDENTIFIER R_PAREN SEMICOLON {}
                | EXIT L_PAREN expressao R_PAREN SEMICOLON {}
                | RETURN lista_comandos5 {}
                | expressao SEMICOLON {}
                | SEMICOLON {}
                | bloco {}
  ;

  lista_comandos2: ELSE bloco {}
                 | {}
  ;

  lista_comandos3: expressao SEMICOLON ldc1 {}
                 | SEMICOLON ldc1 {}
  ;

  ldc1: expressao SEMICOLON ldc2 {}
      | SEMICOLON ldc2 {}
  ;

  ldc2: expressao R_PAREN ldc3 {}
      | R_PAREN ldc3 {}
  ;

  ldc3: bloco {}

  ;

  lista_comandos4: COMMA expressao R_PAREN SEMICOLON {}
                 | R_PAREN SEMICOLON {}
  ;

  lista_comandos5: expressao SEMICOLON {}
                 | SEMICOLON {}
  ;

  expressao: exp_atrib expressao2 {}

  ;

  expressao2: COMMA exp_atrib expressao2 {}
            | {}
  ;

  exp_atrib: exp_cond {}
           | exp_unaria exp_atrib2 {}
  ;

  exp_atrib2: ASSIGN exp_atrib {}
            | ADD_ASSIGN exp_atrib {}
            | MINUS_ASSIGN exp_atrib {}
  ;

  exp_cond: exp_or_lgc exp_cond2 {}

  ;

  exp_cond2: TERNARY_CONDITIONAL expressao COLON {}
           | {}
  ;

  exp_or_lgc: exp_and_lgc exp_or_lgc2 {}

  ;

  exp_or_lgc2: LOGICAL_OR exp_and_lgc exp_or_lgc2 {}
             | {}
  ;

  exp_and_lgc: exp_or exp_and_lgc2 {}

  ;

  exp_and_lgc2: LOGICAL_AND exp_or exp_and_lgc2 {}
              | {}
  ;

  exp_or: exp_xor exp_or2 {}

  ;

  exp_or2: BITWISE_OR exp_xor exp_or2 {}
         | {}
  ;

  exp_xor: exp_and exp_xor2 {}

  ;

  exp_xor2: BITWISE_XOR exp_and exp_xor2 {}
          | {}
  ;

  exp_and: exp_igualdade exp_and2 {}

  ;

  exp_and2: BITWISE_AND exp_igualdade exp_and2 {}
          | {}
  ;

  exp_igualdade: exp_relacional exp_igualdade2 {}

  ;

  exp_igualdade2: EQUAL exp_relacional exp_igualdade2 {}
                | NOT_EQUAL exp_relacional exp_igualdade2 {}
                | {}
  ;

  exp_relacional: exp_shift exp_relacional2 {}

  ;

  exp_relacional2: LESS_THAN exp_shift exp_relacional2 {}
                 | LESS_EQUAL exp_shift exp_relacional2 {}
                 | GREATER_THAN exp_shift exp_relacional2 {}
                 | GREATER_EQUAL exp_shift exp_relacional2 {}
                 | {}
  ;

  exp_shift: exp_aditiva exp_shift2 {}

  ;

  exp_shift2: L_SHIFT exp_aditiva exp_shift2 {}
            | R_SHIFT exp_aditiva exp_shift2 {}
            | {}
  ;

  exp_aditiva: exp_mult exp_aditiva2 {}

  ;

  exp_aditiva2: MINUS exp_mult exp_aditiva2 {}
              | PLUS exp_mult exp_aditiva2 {}
              | {}
  ;

  exp_mult: exp_cast exp_mult2 {}

  ;

  exp_mult2: MULTIPLY exp_cast exp_mult2 {}
           | DIV exp_cast exp_mult2 {}
           | REMAINDER exp_cast exp_mult2 {}
           | {}
  ;

  exp_cast: exp_unaria {}
          | L_PAREN tipo exp_cast2 {}
  ;

  exp_cast2: MULTIPLY exp_cast2 {}
           | R_PAREN exp_cast {}
  ;

  exp_unaria: exp_pos_fixa {}
            | INC exp_unaria {}
            | DEC exp_unaria {}
            | BITWISE_AND exp_cast {}
            | MULTIPLY exp_cast {}
            | PLUS exp_cast {}
            | MINUS exp_cast {}
            | BITWISE_NOT exp_cast {}
            | NOT exp_cast {}
  ;

  exp_pos_fixa: exp_primaria {}
              | exp_pos_fixa exp_pos_fixa2 {}
  ;

  exp_pos_fixa2: L_SQUARE_BRACKET expressao R_SQUARE_BRACKET {}
               | INC {}
               | DEC {}
               | L_PAREN R_PAREN {}
               | L_PAREN exp_pos_fixa3 {}
  ;

  exp_pos_fixa3: exp_atrib R_PAREN {}
               | exp_atrib COMMA exp_pos_fixa3 {}
  ;

  exp_primaria: IDENTIFIER {}
              | numero {}
              | CHARACTER {}
              | STRING {}
              | L_PAREN expressao R_PAREN {}
  ;

  numero: NUM_INTEGER {}
        | NUM_HEXA {}
        | NUM_OCTAL {}
  ;

%%

int yyerror(char *s){
  int i=1,j=0;
  char *strlinha;
  strlinha = (char *)calloc(10000, sizeof(char));
  if(end){
    linha = lines;
    coluna = varcoluna+1;

    while(i<lines-1){
      if(string[j]=='\n'){
        i++;
      }
      j++;
    }
    i=0;
    while(string[j]!='\n'){
      strlinha[i] = string[j];
      i++;
      j++;
    }
    if(i!=0){
      strlinha[i] = '\0';
    }
    linha--;
    printf("error:syntax:%d:%d: expected declaration or statement at end of input\n%s\n%*s",linha,coluna,strlinha,coluna,"^");
    exit(0);
  }

  if(!erro_sint){
    while(i<lines){
      if(string[j]=='\n'){
        i++;
      }
      j++;
    }
    i=0;
    while(string[j]!='\n'){
      strlinha[i] = string[j];
      i++;
      j++;
    }
    strlinha[i] = '\0';

    erro_sint = 1;
    linha = lines;
    strcpy(tok,vet);
    coluna = chars - strlen(tok)+1;

    printf("error:syntax:%d:%d: %s\n%s\n%*s",linha,coluna,tok,strlinha,coluna, "^");
    exit(0);
  }


}

char *getString(FILE *stdin) {
	char *cadeia, ch;
	int i;

	cadeia = (char *) calloc(10000, sizeof(char));

	i = 0;
	while (fscanf(stdin, "%c", &ch) != EOF) {
		cadeia[i] = ch;
		i++;
	}
	cadeia[i] = '\0';
	rewind(stdin);

	return cadeia;
}

int main(){
  string = (char *) calloc(10000, sizeof(char));
  string = getString(stdin);
	yyparse();


}
