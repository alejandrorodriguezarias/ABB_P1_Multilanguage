require_relative 'abb'
def preorderDisplay (tBST) 
	tBST = tBST
	
	print ("(")
	if !BinarySearchTreeDLP.isEmptyTree(tBST) then 
		if !BinarySearchTreeDLP.isEmptyTree(BinarySearchTreeDLP.leftChild(tBST)) || 
		!BinarySearchTreeDLP.isEmptyTree(BinarySearchTreeDLP.rightChild(tBST)) then
			print (" #{BinarySearchTreeDLP.root(tBST)} ")
			preorderDisplay(BinarySearchTreeDLP.leftChild(tBST))
			print(" ")
			preorderDisplay(BinarySearchTreeDLP.rightChild(tBST))
		else
			print (" #{BinarySearchTreeDLP.root(tBST)} ")
		end
	end	
	
	print(")")
end 


tree = BinarySearchTreeDLP.emptyTree
tree = BinarySearchTreeDLP.keyInsert(tree , 4)
tree = BinarySearchTreeDLP.keyInsert(tree , 4)
tree = BinarySearchTreeDLP.keyInsert(tree , 2)
tree = BinarySearchTreeDLP.keyInsert(tree , 6)
tree = BinarySearchTreeDLP.keyInsert(tree , 1)
tree = BinarySearchTreeDLP.keyInsert(tree , 3)
tree = BinarySearchTreeDLP.keyInsert(tree , 5)
tree = BinarySearchTreeDLP.keyInsert(tree , 7)
preorderDisplay(tree)

puts()

puts("buscar 1 .. #{BinarySearchTreeDLP.root(BinarySearchTreeDLP.keySearch(tree,1))}")
puts("buscar 2 .. #{BinarySearchTreeDLP.root(BinarySearchTreeDLP.keySearch(tree,2))}")
puts("buscar 3 .. #{BinarySearchTreeDLP.root(BinarySearchTreeDLP.keySearch(tree,3))}")
puts("buscar 4 .. #{BinarySearchTreeDLP.root(BinarySearchTreeDLP.keySearch(tree,4))}")
puts("buscar 5 .. #{BinarySearchTreeDLP.root(BinarySearchTreeDLP.keySearch(tree,5))}")
puts("buscar 6 .. #{BinarySearchTreeDLP.root(BinarySearchTreeDLP.keySearch(tree,6))}")
puts("buscar 7 .. #{BinarySearchTreeDLP.root(BinarySearchTreeDLP.keySearch(tree,7))}")

print("removing 5...")		       
BinarySearchTreeDLP.removeKey(tree, 5)
preorderDisplay(tree)
puts()

print("removing 6...")		       
BinarySearchTreeDLP.removeKey(tree, 6)
preorderDisplay(tree) 
puts()

print("removing 4...");			       
BinarySearchTreeDLP.removeKey(tree, 4)
preorderDisplay(tree) 
puts()

print("removing 2...")			       
BinarySearchTreeDLP.removeKey(tree, 2)
preorderDisplay(tree) 
puts()
