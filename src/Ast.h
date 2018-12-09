#ifndef AST_H
#define AST_H
#include "Lista.h"

typedef struct _treenode{
  int type;
  char* valor;
  struct _treenode *esquerda;
  struct _treenode *direita;
}treenode;

typedef struct _programa{
  Lista funcoes;
}programa;

typedef struct _variavel{
  int type;
  char* name;
}variavel;

/*Type: tipo retorno; 0 - VOID; 1 - INT;*/
typedef struct _funcao{
  int type;
  char* nome;
  Lista parametros;
  Lista comandos;
}funcao;

typedef struct _comando{
  int type;
  treenode* expressao;
  Lista field1;
  Lista field2;
}comando;



#endif
