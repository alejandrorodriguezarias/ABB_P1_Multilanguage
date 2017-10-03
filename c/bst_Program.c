/*Name:Alejandro Rodriguez Arias
  Login: alejandro.rodriguez.arias
  Name: Jacobo Bouzas Quiroga
  Login: jacobo.bouzas.quiroga*/
#include <stdio.h>
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

int main()
{
	tBST tree;
	emptyTree(&tree);
	keyInsert(&tree, 4);
	keyInsert(&tree, 4);
	keyInsert(&tree, 2);
	keyInsert(&tree, 6);
	keyInsert(&tree, 1);
	keyInsert(&tree, 3);
	keyInsert(&tree, 5);
	keyInsert(&tree, 7);

	display(tree);
	printf("\n");

	printf("searching 1...%i\n", root(keySearch(tree,1)));
   	printf("searching 2...%i\n", root(keySearch(tree,2)));
   	printf("searching 3...%i\n", root(keySearch(tree,3)));
   	printf("searching 4...%i\n", root(keySearch(tree,4)));
   	printf("searching 5...%i\n", root(keySearch(tree,5)));
   	printf("searching 6...%i\n", root(keySearch(tree,6)));
   	printf("searching 7...%i\n", root(keySearch(tree,7)));

	printf("deleting 5...");			       
   	keyRemove(&tree, 5);
   	display(tree); printf("\n");

   	printf("deleting 6...");			       
   	keyRemove(&tree,6);
   	display(tree); printf("\n");

   	printf("deleting 4...");			       
   	keyRemove(&tree,4);
   	display(tree); printf("\n");

   	printf("deleting 2...");			       
   	keyRemove(&tree,2);
   	display(tree); printf("\n");

	return(0);

}
