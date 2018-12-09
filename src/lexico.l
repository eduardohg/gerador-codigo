/*Eduardo Henrique Giroto*/
/* Nao usar a biblioteca do flex*/
%option noyywrap
%x COMMENT

%{
#include <stdio.h>
#include <string.h>
#include <main.tab.h>
#define tamanho 100000
char vet[tamanho];
char vet2[tamanho];
int chars = 0;
int words = 0;
int lines = 1;
int erro_sint = 0;
int comment_lines = 0;
int lgc = 0;
int end = 0;
int varcoluna = 0;
%}

%%
"break"                       {strcpy(vet,yytext); chars += strlen(yytext); return(BREAK);}
"switch"                      {strcpy(vet,yytext); chars += strlen(yytext); return(SWITCH);}
"case"                        {strcpy(vet,yytext); chars += strlen(yytext); return(CASE);}
"default"                     {strcpy(vet,yytext); chars += strlen(yytext); return(DEFAULT);}
"typedef"                     {strcpy(vet,yytext); chars += strlen(yytext); return(TYPEDEF);}
"struct"                      {strcpy(vet,yytext); chars += strlen(yytext); return(STRUCT);}
"->"                          {strcpy(vet,yytext); chars += strlen(yytext); return(POINTER);}
"void"                        {strcpy(vet,yytext); chars += strlen(yytext); return(VOID);}
"int"                         {strcpy(vet,yytext); chars += strlen(yytext); return(INT);}
"char"                        {strcpy(vet,yytext); chars += strlen(yytext); return(CHAR);}
"return"                      {strcpy(vet,yytext); chars += strlen(yytext); return(RETURN);}
"do"                          {strcpy(vet,yytext); chars += strlen(yytext); return(DO);}
"while"                       {strcpy(vet,yytext); chars += strlen(yytext); return(WHILE);}
"for"                         {strcpy(vet,yytext); chars += strlen(yytext); return(FOR);}
"if"                          {strcpy(vet,yytext); chars += strlen(yytext); return(IF);}
"else"                        {strcpy(vet,yytext); chars += strlen(yytext); return(ELSE);}
"+"                           {strcpy(vet,yytext); chars += strlen(yytext); return(PLUS);}
"-"                           {strcpy(vet,yytext); chars += strlen(yytext); return(MINUS); }
"*"                           {strcpy(vet,yytext); chars += strlen(yytext); return(MULTIPLY);}
"/"                           {strcpy(vet,yytext); chars += strlen(yytext); return(DIV);}
"%"                           {strcpy(vet,yytext); chars += strlen(yytext); return(REMAINDER); }
"++"                          {strcpy(vet,yytext); chars += strlen(yytext); return(INC);}
"--"                          {strcpy(vet,yytext); chars += strlen(yytext); return(DEC);}
"&"                           {strcpy(vet,yytext); chars += strlen(yytext); return(BITWISE_AND);}
"|"                           {strcpy(vet,yytext); chars += strlen(yytext); return(BITWISE_OR);}
"~"                           {strcpy(vet,yytext); chars += strlen(yytext); return(BITWISE_NOT);}
"^"                           {strcpy(vet,yytext); chars += strlen(yytext); return(BITWISE_XOR);}
"!"                           {strcpy(vet,yytext); chars += strlen(yytext); return(NOT);}
"&&"                          {strcpy(vet,yytext); chars += strlen(yytext); return(LOGICAL_AND);}
"||"                          {strcpy(vet,yytext); chars += strlen(yytext); return(LOGICAL_OR);}
"=="                          {strcpy(vet,yytext); chars += strlen(yytext); return(EQUAL);}
"!="                          {strcpy(vet,yytext); chars += strlen(yytext); return(NOT_EQUAL);}
"<"                           {strcpy(vet,yytext); chars += strlen(yytext); return(LESS_THAN);}
">"                           {strcpy(vet,yytext); chars += strlen(yytext); return(GREATER_THAN);}
"<="                          {strcpy(vet,yytext); chars += strlen(yytext); return(LESS_EQUAL);}
">="                          {strcpy(vet,yytext); chars += strlen(yytext); return(GREATER_EQUAL);}
">>"                          {strcpy(vet,yytext); chars += strlen(yytext); return(R_SHIFT);}
"<<"                          {strcpy(vet,yytext); chars += strlen(yytext); return(L_SHIFT);}
"="                           {strcpy(vet,yytext); chars += strlen(yytext); return(ASSIGN);}
"+="                          {strcpy(vet,yytext); chars += strlen(yytext); return(ADD_ASSIGN);}
"-="                          {strcpy(vet,yytext); chars += strlen(yytext); return(MINUS_ASSIGN);}
";"                           {strcpy(vet,yytext); chars += strlen(yytext); return(SEMICOLON);}
","                           {strcpy(vet,yytext); chars += strlen(yytext); return(COMMA);}
":"                           {strcpy(vet,yytext); chars += strlen(yytext); return(COLON);}
"("                           {strcpy(vet,yytext); chars += strlen(yytext); return(L_PAREN);}
")"                           {strcpy(vet,yytext); chars += strlen(yytext); return(R_PAREN);}
"{"                           {strcpy(vet,yytext); chars += strlen(yytext); return(L_CURLY_BRACKET);}
"}"                           {strcpy(vet,yytext); chars += strlen(yytext); return(R_CURLY_BRACKET);}
"["                           {strcpy(vet,yytext); chars += strlen(yytext); return(L_SQUARE_BRACKET);}
"]"                           {strcpy(vet,yytext); chars += strlen(yytext); return(R_SQUARE_BRACKET);}
"?"                           {strcpy(vet,yytext); chars += strlen(yytext); return(TERNARY_CONDITIONAL);}
"#"                           {strcpy(vet,yytext); chars += strlen(yytext); return(NUMBER_SIGN);}
"printf"                      {strcpy(vet,yytext); chars += strlen(yytext); return(PRINTF);}
"scanf"                       {strcpy(vet,yytext); chars += strlen(yytext); return(SCANF);}
"define"                      {strcpy(vet,yytext); chars += strlen(yytext); return(DEFINE);}
"exit"                        {strcpy(vet,yytext); chars += strlen(yytext); return(EXIT);}


" "                            {chars++;}
[\n]                           {lines++; chars=0;}
"//".*[\n]?                     {lines++; varcoluna = chars; }
"/*"                           {chars += 2; BEGIN(COMMENT);}
<COMMENT>"*/"                  {varcoluna = chars-1; chars+=1; BEGIN(INITIAL);}
<COMMENT>([^*]|\n)+|.          {int i; chars+=2; for(i=0; i<strlen(yytext); i++) {if (yytext[i] == '\n') { lines++; chars = 0;}else chars++;}}
<COMMENT><<EOF>>               {printf("error:lexical:%d:%d :unterminated comment", comment_lines, chars+1); varcoluna = chars; exit(1);}
0[1-7]+[0-7]*                {strcpy(vet,yytext); chars += strlen(yytext); return(NUM_OCTAL); }
0[x|X]([0-9]+|[a-fA-F]+)+       {strcpy(vet,yytext); chars += strlen(yytext); return(NUM_HEXA); }
[0-9]+                         {strcpy(vet,yytext); chars += strlen(yytext); return(NUM_INTEGER);}
[_?a-zA-Z]+[0-9]*              {strcpy(vet,yytext); chars += strlen(yytext); return(IDENTIFIER);}
[\t]                           {}
[\']("\n"|"\t"|"\0"|"\a")[\']    {strcpy(vet,yytext); chars+=2; return(CHARACTER);}
[\'].[\']                    {strcpy(vet,yytext); chars++; return(CHARACTER);}
[\"].*[\"]                   {strcpy(vet,yytext); chars += strlen(yytext); return(STRING);}
.                              {printf("error:lexical:%d:%d: %s",lines,chars+1,yytext); exit(0);}
<<EOF>>                        {end = 1; return(END_FILE);}

%%
