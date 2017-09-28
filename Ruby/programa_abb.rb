def preorderDisplay (tABB) 
	tABB = tABB
	
	print ("(")
	if !isEmptyTree(tABB) then 
		if !isEmptyTree(leftChild(tABB)) || !isEmptyTree(rightChild(tABB)) then
			print (" #{root(tABB)} ")
			preorderDisplay(leftChild(tABB))
			print(" ")
			preorderDisplay(rightChild(tABB))
		else
			print (" #{root(tABB)} ")
		end
	end	
	
	print(")")
end 


arbol = emptyTree
arbol = keyInsert(tNodeA, arbol , 4)
arbol = keyInsert(tNodeA, arbol , 4)
arbol = keyInsert(tNodeA, arbol , 2)
arbol = keyInsert(tNodeA, arbol , 6)
arbol = keyInsert(tNodeA, arbol , 1)
arbol = keyInsert(tNodeA, arbol , 3)
arbol = keyInsert(tNodeA, arbol , 5)
arbol = keyInsert(tNodeA, arbol , 7)

puts()

puts("buscar 1 .. #{root(keySearch(arbol,1))}")
puts("buscar 2 .. #{root(keySearch(arbol,2))}")
puts("buscar 3 .. #{root(keySearch(arbol,3))}")
puts("buscar 4 .. #{root(keySearch(arbol,4))}")
puts("buscar 5 .. #{root(keySearch(arbol,5))}")
puts("buscar 6 .. #{root(keySearch(arbol,6))}")
puts("buscar 7 .. #{root(keySearch(arbol,7))}")

print("removing 5...")		       
removeKey(arbol, 5)
preorderDisplay(arbol)
puts()

print("removing 6...")		       
removeKey(arbol, 6)
preorderDisplay(arbol) 
puts()

print("removing 4...");			       
removeKey(arbol, 4)
preorderDisplay(arbol) 
puts()

print("removing 2...")			       
removeKey(arbol, 2)
preorderDisplay(arbol) 
puts()
