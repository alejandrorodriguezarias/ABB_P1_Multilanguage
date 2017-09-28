tNodeA = Struct.new(:key,:left,:right)

def error (error_mesage)
	puts ("#{error_mesage}")
	exit
end #error message

def createNodeA (tNodeA)
	new_node = tNodeA.new
	if new_node == nil then
		error(" *** abb.createNodeA: no memory avaliable")
	end
	return new_node
end

def emptyTree
	return nil
end; #emptyTree 

#*********************************************************************
#INSERT
#*********************************************************************
def iterativeInsert (tNodeA, tABB, key)	
	#new node inicialization
	new_node = createNodeA(tNodeA)
	new_node.key = key
	new_node.left = nil
	new_node.right = nil
	
	if tABB == nil then
		return new_node
	else 
		father = nil	
		child = tABB
		#Find insert position
		while child != nil && child.key != key 
			father = child
			if key < child.key then
				child = child.left
			else
				child = child.right
			end
		end	
		
		if child == nil then
			if key < father.key then
				father.left = new_node
			else 
				father.right = new_node
			end
		end #Duplicated keys ignored.
	end
	return tABB;
end #Iterative Insert

def recursiveInsert (tNodeA,tABB,key)
	
	if tABB == nil then
		tABB = createNodeA(tNodeA)
		tABB.key = key
		tABB.left = nil
		tABB.right = nil
		
	elsif key < tABB.key then
		tABB.left = recursiveInsert(tNodeA,tABB.left,key)
	elsif key > tABB.key then 
		tABB.right = recursiveInsert(tNodeA,tABB.right,key)
	end #Duplicated keys ignored
	
	return tABB;
	
end#recursiveInsert

def keyInsert(tNodeA,tABB, key)
	recursiveInsert(tNodeA,tABB,key)
end#keyInsert

#***********************************************************************

def isEmptyTree(tABB)
	return tABB == nil
end #isEmptyTree

def leftChild (tABB)
	return tABB.left
end #leftChild

def rightChild(tABB)
	return tABB.right
end #rightChild

def root(tABB)
	return tABB.key
end #root

#*********************************************************************
#Search
#*********************************************************************
def recursiveSearch (tABB,key)
	if tABB == nil then
		return nil
	elsif tABB.key == key then
		return tABB
	elsif key < tABB.key then
		return recursiveSearch(tABB.left,key)
	else
		return recursiveSearch(tABB.right,key)
	end 
end#recursiveSearch

def iterativeSearch (tABB,key)
	
	node = tABB
	while node != nil && node.key != key
		if key < node.key then 
			node = node.left
		else 
			node = node.right
		end
	end
	return node
end #iterativeSearch

def keySearch(tABB,key)
	return recursiveSearch(tABB,key)
end#recursiveSearch
#********************************************************************

#*********************************************************************
#Delete
#*********************************************************************
def recursiveRemove(tABB,key)
	
	#when the target node have two children, this function it´s called
	#Replace the target with the highest key node from left subtree
	#father contains the father node from the highest key node from the left subtree
	def rem2 (tree,father,aux)
		if tree.right !=nil then
			rem2(tree.right,tree,aux)
		else 
			aux.key = tree.key
			#aux=tree 
			#especial case if father.left = tree (father = aux)
			if father.left == tree then 
				father.left = tree.left
			else
				father.right = tree.left
			end
		end
		return aux
	end#sup2
	
	if tABB !=nil then 
		if key < tABB.key then
			tABB.left = recursiveRemove(tABB.left,key)
		elsif key > tABB.key then
			tABB.right = recursiveRemove(tABB.right,key)
		else 
			aux = tABB
			if tABB.left == nil then
				tABB=tABB.right
			elsif tABB.right == nil then
				tABB=tABB.left
			else
				tABB = rem2(tABB.left,tABB,aux)
			end
			aux = nil
		end
	end
	return tABB
end#recursiveRemove

def iterativeRemove (tABB,key)

	fDel = nil  #father of target node
	del = tABB  #target node
	#Search target node
	while del != nil && del.key != key do
		fDel = del
		if key < del.key then 
			del = del.left
		else
			del = del.right
		end
	end
	#If missing key do nothing
	if del != nil then
	
		# Number of children
		children = 0;
		if del.left != nil then
			children= children + 1
		end
		if del.right != nil then
			children = children + 1
		end
		
		case children 
		
		when 0 
			if fDel == nil then
				tABB = nil # Root was the only node
			elsif fDel.left == del then
				fDel.left = nil
			else 
				fDel.right = nil
			end  
		#Delete node with one child
		when 1
			#NotEmptyChild is the not empty child from the node target
			#Keep the not empty child
			if del.left == nil then
				notEmptyChild = del.right
			else 
				notEmptyChild = del.left
			end
			
			# Delete target node
			if fDel == nil then 
				tABB = notEmptyChild	
			elsif fDel.left == del then 
				fDel.left = notEmptyChild
			else
				fDel.right = notEmptyChild
			end
		# Delete node with two children	
		when 2
			fDel = del
			#subLeftMax node with highest key in left subtree
			subLeftMax= del.left
			
			while subLeftMax.right != nil 
				fDel = subLeftMax
				subLeftMax = subLeftMax.right
			end #while
			
			del.key = subLeftMax.key
			
			if fDel == del then 
				fDel.left = subLeftMax.left
			else
				fDel.right = subLeftMax.left
			end
			del = subLeftMax
		end #case
	end#if
	return tABB
end # iterativeRemove

def removeKey(tABB,key)
	recursiveRemove(tABB,key)
end

