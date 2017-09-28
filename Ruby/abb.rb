module BinarySearchTreeDLP
	TNODEA = Struct.new(:key,:left,:right)

	def BinarySearchTreeDLP.error (error_mesage)
		puts ("#{error_mesage}")
		exit
	end #error message

	def BinarySearchTreeDLP.createNodeA
		new_node = TNODEA.new
		if new_node == nil then
			error(" *** abb.createNodeA: no memory avaliable")
		end
		return new_node
	end

	def BinarySearchTreeDLP.emptyTree
		return nil
	end; #emptyTree 

	#*********************************************************************
	#INSERT
	#*********************************************************************
	def BinarySearchTreeDLP.iterativeInsert (tBST, key)	
		#new node inicialization
		new_node = createNodeA
		new_node.key = key
		new_node.left = nil
		new_node.right = nil
		
		if tBST == nil then
			return new_node
		else 
			father = nil	
			child = tBST
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
		return tBST;
	end #Iterative Insert

	def BinarySearchTreeDLP.recursiveInsert (tBST,key)
		
		if tBST == nil then
			tBST = createNodeA
			tBST.key = key
			tBST.left = nil
			tBST.right = nil
			
		elsif key < tBST.key then
			tBST.left = recursiveInsert(tBST.left,key)
		elsif key > tBST.key then 
			tBST.right = recursiveInsert(tBST.right,key)
		end #Duplicated keys ignored
		
		return tBST;
		
	end#recursiveInsert

	def BinarySearchTreeDLP.keyInsert(tBST, key)
		BinarySearchTreeDLP.recursiveInsert(tBST,key)
	end#keyInsert

	#***********************************************************************

	def BinarySearchTreeDLP.isEmptyTree(tBST)
		return tBST == nil
	end #isEmptyTree

	def BinarySearchTreeDLP.leftChild (tBST)
		return tBST.left
	end #leftChild

	def BinarySearchTreeDLP.rightChild(tBST)
		return tBST.right
	end #rightChild

	def BinarySearchTreeDLP.root(tBST)
		return tBST.key
	end #root

	#*********************************************************************
	#Search
	#*********************************************************************
	def BinarySearchTreeDLP.recursiveSearch (tBST,key)
		if tBST == nil then
			return nil
		elsif tBST.key == key then
			return tBST
		elsif key < tBST.key then
			return BinarySearchTreeDLP.recursiveSearch(tBST.left,key)
		else
			return BinarySearchTreeDLP.recursiveSearch(tBST.right,key)
		end 
	end#recursiveSearch

	def BinarySearchTreeDLP.iterativeSearch (tBST,key)
		
		node = tBST
		while node != nil && node.key != key
			if key < node.key then 
				node = node.left
			else 
				node = node.right
			end
		end
		return node
	end #iterativeSearch

	def BinarySearchTreeDLP.keySearch(tBST,key)
		return BinarySearchTreeDLP.recursiveSearch(tBST,key)
	end#recursiveSearch
	#********************************************************************

	#*********************************************************************
	#Delete
	#*********************************************************************
	def BinarySearchTreeDLP.recursiveRemove(tBST,key)
		
		#when the target node have two children, this function it´s called
		#Replace the target with the highest key node from left subtree
		#father contains the father node from the highest key node from the left subtree
		def BinarySearchTreeDLP.rem2 (tree,father,aux)
			if tree.right !=nil then
				BinarySearchTreeDLP.rem2(tree.right,tree,aux)
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
		
		if tBST !=nil then 
			if key < tBST.key then
				tBST.left = BinarySearchTreeDLP.recursiveRemove(tBST.left,key)
			elsif key > tBST.key then
				tBST.right = BinarySearchTreeDLP.recursiveRemove(tBST.right,key)
			else 
				aux = tBST
				if tBST.left == nil then
					tBST=tBST.right
				elsif tBST.right == nil then
					tBST=tBST.left
				else
					tBST = BinarySearchTreeDLP.rem2(tBST.left,tBST,aux)
				end
				aux = nil
			end
		end
		return tBST
	end#recursiveRemove

	def BinarySearchTreeDLP.iterativeRemove (tBST,key)

		fDel = nil  #father of target node
		del = tBST  #target node
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
					tBST = nil # Root was the only node
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
					tBST = notEmptyChild	
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
		return tBST
	end # iterativeRemove

	def BinarySearchTreeDLP.removeKey(tBST,key)
		BinarySearchTreeDLP.recursiveRemove(tBST,key)
	end

end