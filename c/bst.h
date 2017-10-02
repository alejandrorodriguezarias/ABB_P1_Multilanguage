#ifndef bst_H_
#define bst_H_
#include <stdbool.h>

typedef int tKey;
struct node{
	tKey key;
	struct node *left, *right;
};
typedef struct node tNodeT;
typedef tNodeT * tPosT;
typedef tPosT tBST;


void emptyTree(tBST *tree);
void keyInsert(tBST *tree, tKey key);

tBST leftChild(tBST tree);
tBST rightChild (tBST tree);
tKey root(tBST tree);
bool isEmptyTree(tBST tree);
tBST keySearch (tBST tree , tKey key);

void keyRemove(tBST *tree, tKey key);

#endif

