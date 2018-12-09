#include <stdio.h>
#include <stdlib.h>
#include "Ast.h"

#define INT 1
#define CHAR 2
#define DOUBLE 3
#define FLOAT 4
#define IF 1
#define WHILE 2
#define EXP 3
#define NUMBER 0
#define PLUS 1
#define MULTI 2
#define MINUS 3
#define DIV 4


programa* novoPrograma(){
  programa* prog = NULL;
  prog = (programa*)malloc(sizeof(programa));
  prog->funcoes = createList();

  return prog;
}

void insertFunction(programa* prog, funcao* func){
  insert(prog->funcoes,func);
}

funcao* novaFuncao(int type, char* nome){
  funcao *func;
  int tam;
  func = (funcao *)malloc(sizeof(funcao));
  tam = strlen(nome);
  func->nome = (char *)malloc((tam+1)*sizeof(char));
  strcpy(func->nome,nome);
  func->type = type;
  func->parametros = createList();
  func->comandos = createList();

  return func;
}

void insertParametrosOnFunc(funcao* func, variavel* var){
  insert(func->parametros,var);
}

void insertComandosOnFunc(funcao* func, variavel* var){
  insert(func->comandos,var);
}

variavel* novaVariavel(int type, char* name){
  variavel *var;
  int tam;
  var = (variavel *)malloc(sizeof(variavel));
  var->type = type;
  tam = strlen(name);
  var->name = (char *)malloc((tam+1)*sizeof(char));
  strcpy(var->name,name);

  return var;
}

comando* novoComando(int type){
  comando *com;
  com = (comando *)malloc(sizeof(comando));
  com->type = type;
  com->expressao = NULL;

  if(type == IF_STMT){
    com->field1 = createList();
    com->field2 = createList();
  }
  else if(type == WHILE_STMT){
    com->field1 = createList();
    com->field2 = NULL;
  }
  else if(type == EXP_STMT){
    com->field1 = NULL;
    com->field2 = NULL;
  }

  return com;
}

void insertExpressao(comando* com, treenode* expr){
  if((com->type == IF || com->type == WHILE) && com->expressao == NULL)
    com->expressao = expr;
  else
    printf("Erro ao inserir expressão\n");

}

void insertComandoOnComando(comando *com, comando *otherComand, int field){
  if(com->type == IF || com->type == WHILE){
    if(field == 1)
      insert(com->field1,otherComand);
    else if(field == 2){
      if(com->type == IF)
        insert(com->field2,otherComand);
      else
        printf("Erro ao inserir comando\n");
    }
  }
  else
    printf("Erro ao inserir comando\n");
}

treenode* insertNode(int type, char* value, treenode* esq, treenode* dir){
  treenode* x;
  int tam;
  x = (treenode *)malloc(sizeof(treenode));
  x->type = type;
  tam = strlen(value);
  x->valor = (char *)malloc((tam+1)*sizeof(char));
  strcpy(x->valor,value);
  x->esquerda = esq;
  x->direita = dir;

  return x;
}
