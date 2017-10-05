/*Name:Alejandro Rodriguez Arias
  Login: alejandro.rodriguez.arias
  Name: Jacobo Bouzas Quiroga
  Login: jacobo.bouzas.quiroga*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bst.h"
void display (tBST tree){

	printf("(");
	if (!isEmptyTree(tree)) {
		if (!isEmptyTree(leftChild(tree)) || (!isEmptyTree(rightChild(tree)))) {	
			printf(" %i ",root(tree));
			display(leftChild(tree));
			printf(" ");
			display(rightChild(tree));
		
		}else {
			printf(" %i ",root(tree));
		}
	}
	printf(")");	
}
void menuKeyInsert(tBST* tree){
	int value;
	char read[60];	
	printf("Insert key value\n");
	gets(read);
	value = atoi(read);
	keyInsert(tree, value);
	printf("Done\n");

}
void menuKeySearch(tBST tree){
	int value;
	char read[60];
	printf("Insert key value");
	gets(read);
	value = atoi(read);
	if (keySearch(tree,value)==NULL){
		printf("Key not found\n");
	}else {
		printf("searching %s...%i\n", value, root(keySearch(tree,value)));
	}

}

void menuKeyRemove(tBST *tree){
	int value;
	char read[60];
	printf("Insert key value\n");
	gets(read);
	value = atoi(read);
	keyRemove(tree, value);
	printf("Done\n");

}
void menu() {

	int option;
	char read[1];
	tBST tree;
	emptyTree(&tree);
	bool noexit = true;
	while(noexit){

		printf("0. Exit\n");
		printf("1. Key Insert\n");
		printf("2. Key Search\n");
		printf("3. Key Remove\n");
		printf("4.Tree Display\n");
		gets(read);
		option = atoi(read);

		switch (option){
	
			case 1: menuKeyInsert(&tree);
				break;
			case 2: menuKeySearch(tree);
				break;
			case 3: menuKeyRemove(&tree);
				break;
			case 4: display(tree);
				printf("\n");
				break;
			case 0: noexit=false;
				break;

		}
	}
}
int main()
{
	menu();
	return(0);

}
