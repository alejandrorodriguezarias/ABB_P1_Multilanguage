#include "bst.h"
#include <stdio.h>
#include <stdlib.h>

void  error ( char error_mesage[]) {

	printf("%s\n",error_mesage);
}// Error

void createNodeT ( tPosT *p) {
	
	*p = malloc(sizeof(tPosT));
	if (*p==NULL) {
		error(" *** abb.createNodeT: no memory avaliable ");
	}
} //createNodeT

/**************************************************************/

void emptyTree (tBST *tree){
	*tree = NULL;
}//emptyTree

/************************NodeInsert*************************/
//recursive insert
void recursive_insert (tBST * tree, tKey key){
	tBST new_node;
	if (*tree==NULL){
		createNodeT(tree);
		(*tree)->key = key;
		(*tree)->left = NULL;
		(*tree)->right = NULL;
	}else 
		if (key < (*tree)->key){
			recursive_insert(&(*tree)->left,key);
		}else 
			if (key > (*tree)->key) {
				recursive_insert(&(*tree)->right, key);			
			}//Duplicated ignored*/
}//recursive_insert

//iterative_insert
void iterative_insert (tBST * tree, tKey key){
	//Variables
	tBST new_node, father, child;
	//End Variables
		createNodeT(&new_node);
		new_node->key = key;
		new_node->left = NULL;
		new_node->right = NULL;
		if (*tree==NULL) {
			//emptyTree case 
			*tree = new_node;
		}else{
			//Not Empty tree case
			father = NULL;
			child = *tree;
			while ((child != NULL) && (child->key != key)) {
				father = child;
				if (key < child->key) {
					child = child->left;
				}else {
					child = child->right;
				}		
			} 
			if (child == NULL) {
				if (key < father->key) {
					father->left = new_node;
				}else {
					father->right = new_node;			
				}//Duplicated ignored			
			}
		}
}//iterative_insert

void keyInsert (tBST *tree, tKey key) {
	recursive_insert(tree,key);
}

/*********************NodeSearch**************************/
//recursive_search
tPosT recursive_Search(tBST tree, tKey key){
	if (tree==NULL) {
		return NULL;		
	}else 
		if (tree->key == key) {
			return tree;	
		}else 
			if (key < tree->key) {
				recursive_Search(tree->left, key);	
			} else recursive_Search(tree->right,key);
}//recursive_Search 

//iterative_search
tPosT iterative_Search (tBST *tree, tKey key) {
	tPosT node;
	node = *tree;

	while ((node != NULL) && (node->key != key)){
		if (key < node->key){
			node = node->left;
		}else{
			node = node->right;
		}
	}
	return node;
}//iterative_Search

tBST keySearch (tBST tree, tKey key) {
	return recursive_Search(tree,key);
}

/**************************************************************/

tBST leftChild(tBST tree) {	
		return tree->left;
}//Fin leftChild

tBST rightChild(tBST tree) {	
		return tree->right;
}//Fin rightChild

tKey root(tBST tree) {
	return tree->key;	
}//Fin root

bool isEmptyTree(tBST tree) {
	return (tree==NULL);
}//Fin isEmptyTree

/**************************ELiminar_node**********************/
void recursive_remove (tBST * tree, tKey key) {

	tBST aux;
	void rev2 (tBST *tree2){
		if ((*tree2)->right != NULL){
			rev2(&(*tree2)->right);
		}else {
			aux->key = (*tree2)->key;
			aux = *tree2;
			*tree2= (*tree2)->left;
		}
	
	}// rev2

	if (tree != NULL) {
		if (key < (*tree)->key) {
			recursive_remove(&(*tree)->left,key);
		}else 
			if (key > (*tree)->key) {
				recursive_remove(&(*tree)->right,key);
			}else {
				aux = *tree;
				if ((*tree)->left==NULL){
					*tree = (*tree)->right;			
				} else 
					if ((*tree)->right==NULL){
						*tree = (*tree)->left;
					}else rev2(&(*tree)->left);
				free(aux);
			} //else
	}//if
		
}//recursive_remove

//iterative_remove
void iterative_remove (tBST *tree, tKey key) {
	//Variables
	int numchildren;
	tBST rev, //Target node
		 frev, // target´s father
		 notEmptyChild, //not empty child from a target node with only one child
		 highLeftChild; //highest key node from left subtree of target node
	// Variables
	
	//Target node search
	frev = NULL;	
	rev = *tree;
	while ((rev != NULL) && (rev->key != key)) {
		frev = rev;
		if (key < rev->key) {
			rev = rev->left;
		} else {
			rev = rev->right;		
		}
	}//while
	
	// if key is not in tree do nothing
	if (rev != NULL){
		//children account
		numchildren = 0;
		if (rev->left != NULL){
			numchildren++;
		}
		if (rev->right != NULL) {
			numchildren++;		
		}

		switch (numchildren) {
			//remove target leaf 
			case 0 :
				if (frev == NULL) {
					tree = NULL; //root is the only node from tree 
				}else if (frev->left == rev){ 
					frev->left = NULL;				
				}else frev->right = NULL; 
				break;
			
			//remove one child target node
			case 1:
				if (rev->left == NULL) {
					notEmptyChild = rev->right;				
				}else {
					notEmptyChild = rev->left;			
				}
				
				if (frev == NULL) {
					*tree = notEmptyChild; //remove root
				}else if (frev->left == rev) {
					frev->left = notEmptyChild;
				}else
					frev->right = notEmptyChild;
				break;
			//remove two children target node
			case 2:	
				frev = rev;
				highLeftChild = rev->left;
				while (highLeftChild->right != NULL) {
					frev = highLeftChild;
					highLeftChild = highLeftChild->right;
				}
				
				rev->key = highLeftChild->key;
				if (frev == rev) {
					frev->left = highLeftChild->left;
				}else 
					frev->right = highLeftChild->left;
				
				rev = highLeftChild;	
				break;					
		}//switch
		
		free(rev);	
	}//if
}// iterative_remove


void keyRemove ( tBST *tree, tKey key) {
	recursive_remove(tree,key);
}// keyRemove




