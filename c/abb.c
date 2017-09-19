#include "abb.h"
#include <stdio.h>
#include <stdlib.h>

void  error ( char mensaje_error[]) {

	printf("%s\n",mensaje_error);
}// Fin error

void crearNodoA ( tPosA *p) {
	
	*p = malloc(sizeof(tPosA));
	if (*p==NULL) {
		error(" *** abb.crearNodoA: no hay memoria");
	}
} //Fin crearNodoA

/**************************************************************/

void arbolVacio (tABB *arbol){
	*arbol = NULL;
}//Fin arbolVacio

/************************Insertar_Nodo*************************/
//insertar recursivo
void insertar_r (tABB * arbol, tClave clave){
	tABB nuevo;
	if (*arbol==NULL){
		crearNodoA(arbol);
		(*arbol)->clave = clave;
		(*arbol)->izdo = NULL;
		(*arbol)->dcho = NULL;
	}else 
		if (clave < (*arbol)->clave){
			insertar_r(&(*arbol)->izdo,clave);
		}else 
			if (clave > (*arbol)->clave) {
				insertar_r(&(*arbol)->dcho, clave);			
			}//Se ignoran los dublicados*/
}//fin insertar_r

//insertar iterativo
void insertar_i (tABB * arbol, tClave clave){
	//Variables
	tABB nuevo, padre, hijo;
	//Fin Variables
		crearNodoA(&nuevo);
		nuevo->clave = clave;
		nuevo->izdo = NULL;
		nuevo->dcho = NULL;
		if (*arbol==NULL) {
			//Caso arbol vacio
			*arbol = nuevo;
		}else{
			//Caso arbol no vacio
			padre = NULL;
			hijo = *arbol;
			while ((hijo != NULL) && (hijo->clave != clave)) {
				padre = hijo;
				if (clave < hijo->clave) {
					hijo = hijo->izdo;
				}else {
					hijo = hijo->dcho;
				}		
			} 
			if (hijo == NULL) {
				if (clave < padre->clave) {
					padre->izdo = nuevo;
				}else {
					padre->dcho = nuevo;			
				}// Se ignoran los duplicados			
			}
		}
}// Fin insertar iterativo

void insertarClave (tABB *arbol, tClave clave) {
	insertar_r(arbol,clave);
}

/*********************buscar_nodo**************************/
//buscar recursivo
tPosA buscar_r(tABB arbol, tClave clave){
	if (arbol==NULL) {
		return NULL;		
	}else 
		if (arbol->clave == clave) {
			return arbol;	
		}else 
			if (clave < arbol->clave) {
				buscar_r(arbol->izdo, clave);	
			} else buscar_r(arbol->dcho,clave);
}//Fin Buscar_R 

//buscar iterativo
tPosA buscar_i (tABB *arbol, tClave clave) {
	//Variables
	tPosA nodo;
	//Fin variables

	nodo = *arbol;
	while ((nodo != NULL) && (nodo->clave != clave)){
		if (clave < nodo->clave){
			nodo = nodo->izdo;
		}else{
			nodo = nodo->dcho;
		}
	}
	return nodo;
}//Fin buscar_i

tABB buscarClave (tABB arbol, tClave clave) {
	return buscar_r(arbol,clave);
}

/**************************************************************/

tABB hijoIzquierdo(tABB arbol) {	
		return arbol->izdo;
}//Fin hijoIzquierdo

tABB hijoDerecho(tABB arbol) {	
		return arbol->dcho;
}//Fin hijoDerecho

tClave Raiz(tABB arbol) {
	return arbol->clave;	
}//Fin Raiz

bool esArbolVacio(tABB arbol) {
	return (arbol==NULL);
}//Fin esArbolVacio

/**************************ELiminar_Nodo**********************/
void eliminar_r (tABB * arbol, tClave clave) {
	//Variables
	tABB aux;
	//Fin variables
	
	void sup2 (tABB *arbol2){
		if ((*arbol2)->dcho != NULL){
			sup2(&(*arbol2)->dcho);
		}else {
			aux->clave = (*arbol2)->clave;
			aux = *arbol2;
			*arbol2= (*arbol2)->izdo;
		}
	
	}//final sup2

	if (arbol != NULL) {
		if (clave < (*arbol)->clave) {
			eliminar_r(&(*arbol)->izdo,clave);
		}else 
			if (clave > (*arbol)->clave) {
				eliminar_r(&(*arbol)->dcho,clave);
			}else {
				aux = *arbol;
				if ((*arbol)->izdo==NULL){
					*arbol = (*arbol)->dcho;			
				} else 
					if ((*arbol)->dcho==NULL){
						*arbol = (*arbol)->izdo;
					}else sup2(&(*arbol)->izdo);
				free(aux);
			} //else
	}//if
		
}//fin eliminar recursivo

//eliminar iterativo
void eliminar_i (tABB *arbol, tClave clave) {
	//Variables
	int numHijos;
	tABB sup, //nodo a suprimir
		 pSup, //padre del nodo a suprimir
		 hijoNoVacio, //si el nodo a suprimir solo tiene un hijo, el no vacio
		 sucIzMax; //si el nodo a suprimir tiene dos hijos, el nodo con mayor valor del subarbol izquierdo
	//Fin Variables
	
	//Buscar el nodo a suprimir
	pSup = NULL;	
	sup = *arbol;
	while ((sup != NULL) && (sup->clave != clave)) {
		pSup = sup;
		if (clave < sup->clave) {
			sup = sup->izdo;
		} else {
			sup = sup->dcho;		
		}
	}//while
	
	// si la clave no pertenece al arbol no se hace nada
	if (sup != NULL){
		//Cuenta el numero de hijos
		numHijos = 0;
		if (sup->izdo != NULL){
			numHijos++;
		}
		if (sup->dcho != NULL) {
			numHijos++;		
		}

		switch (numHijos) {
			//suprimir nodo hoja
			case 0 :
				if (pSup == NULL) {
					arbol = NULL; //la raiz era el unico nodo del arbol
				}else if (pSup->izdo == sup){ 
					pSup->izdo = NULL;				
				}else pSup->dcho = NULL; 
				break;
			
			//Suprimir nodo con un solo hijo
			case 1:
				if (sup->izdo == NULL) {
					hijoNoVacio = sup->dcho;				
				}else {
					hijoNoVacio = sup->izdo;			
				}
				
				if (pSup == NULL) {
					*arbol = hijoNoVacio; //borramos la raiz
				}else if (pSup->izdo == sup) {
					pSup->izdo = hijoNoVacio;
				}else
					pSup->dcho = hijoNoVacio;
				break;
			//suprimir nodo con dos hijos
			case 2:	
				pSup = sup;
				sucIzMax = sup->izdo;
				while (sucIzMax->dcho != NULL) {
					pSup = sucIzMax;
					sucIzMax = sucIzMax->dcho;
				}
				
				sup->clave = sucIzMax->clave;
				if (pSup == sup) {
					pSup->izdo = sucIzMax->izdo;
				}else 
					pSup->dcho = sucIzMax->izdo;
				
				sup = sucIzMax;	
				break;					
		}//switch
		
		free(sup);	
	}//if
}// eliminar_i


void eliminarClave ( tABB *arbol, tClave clave) {
	eliminar_r(arbol,clave);
}//eliminar clave




