#include <stdio.h>
#include "abb.h"
void preordenParentizado (tABB arbol){

	printf("(");
	if (!esArbolVacio(arbol)) {
		if (!esArbolVacio(hijoIzquierdo(arbol)) || (!esArbolVacio(hijoDerecho(arbol)))) {	
			printf(" %i ",Raiz(arbol));
			preordenParentizado(hijoIzquierdo(arbol));
			printf(" ");
			preordenParentizado(hijoDerecho(arbol));
		
		}else {
			printf(" %i ",Raiz(arbol));
		}
	}
	printf(")");	
}

int main()
{
	tABB arbol;
	arbolVacio(&arbol);
	insertarClave(&arbol, 4);
	insertarClave(&arbol, 4);
	insertarClave(&arbol, 2);
	insertarClave(&arbol, 6);
	insertarClave(&arbol, 1);
	insertarClave(&arbol, 3);
	insertarClave(&arbol, 5);
	insertarClave(&arbol, 7);

	preordenParentizado(arbol);
	printf("\n");

	printf("buscar 1...%i\n", Raiz(buscarClave(arbol,1)));
   	printf("buscar 2...%i\n", Raiz(buscarClave(arbol,2)));
   	printf("buscar 3...%i\n", Raiz(buscarClave(arbol,3)));
   	printf("buscar 4...%i\n", Raiz(buscarClave(arbol,4)));
   	printf("buscar 5...%i\n", Raiz(buscarClave(arbol,5)));
   	printf("buscar 6...%i\n", Raiz(buscarClave(arbol,6)));
   	printf("buscar 7...%i\n", Raiz(buscarClave(arbol,7)));

	printf("eliminar 5...");			       
   	eliminarClave(&arbol, 5);
   	preordenParentizado(arbol); printf("\n");

   	printf("eliminar 6...");			       
   	eliminarClave(&arbol,6);
   	preordenParentizado(arbol); printf("\n");

   	printf("eliminar 4...");			       
   	eliminarClave(&arbol,4);
   	preordenParentizado(arbol); printf("\n");

   	printf("eliminar 2...");			       
   	eliminarClave(&arbol,2);
   	preordenParentizado(arbol); printf("\n");

	return(0);

}
