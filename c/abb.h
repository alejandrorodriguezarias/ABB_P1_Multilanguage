#ifndef abb_H_
#define abb_H_
#include <stdbool.h>

typedef int tClave;
struct nodo{
	tClave clave;
	struct nodo *izdo, *dcho;
};
typedef struct nodo tNodoA;
typedef tNodoA * tPosA;
typedef tPosA tABB;


void arbolVacio(tABB *arbol);
void insertarClave(tABB *arbol, tClave clave);

tABB hijoIzquierdo(tABB arbol);
tABB hijoDerecho (tABB arbol);
tClave Raiz(tABB arbol);
bool esArbolVacio(tABB arbol);
tABB buscarClave (tABB arbol , tClave clave);

void eliminarClave(tABB *arbol, tClave clave);

#endif

