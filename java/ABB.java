package abb;

public class ABB<T extends Comparable<T>> {

	private static class Node<U> {
		public U key = null;
		public Node<U> left = null;
		public Node<U> right = null;
	}

	private Node<T> root = null;

	/*********************************************************/

	/**
	* Clears this ABB
	*/
	public void arbolVacio() {
		root = null;
	}
	
	/*********************************************************/
	
	private static <R extends Comparable<R>> void insertarClave_r(ABB<R> abb, R clave) {
	
		if(abb.esArbolVacio()) {
			abb.root = new Node<R>();
			abb.root.key = clave;
		} else {
			int compareVal = clave.compareTo(abb.root.key);
			if(compareVal < 0) {
				ABB<R> hijo = abb.hijoIzquierdo();
				insertarClave_r(hijo, clave);
				if(abb.hijoIzquierdo().esArbolVacio())
					abb.root.left = hijo.root; // if that was empty, we link it
			} else if(compareVal > 0) {
				ABB<R> hijo = abb.hijoDerecho();
				insertarClave_r(hijo, clave);
				if(abb.hijoDerecho().esArbolVacio())
					abb.root.right = hijo.root; // same
			} // else value is already on tree
		}
	}
	
	/**
	* Inserts a key into this ABB
	*/
	public void insertarClave(T clave) {
		insertarClave_r(this, clave);
	}

	/*********************************************************/

	/**
	* Returns left subtree
	*/
	public ABB<T> hijoIzquierdo() {
		ABB<T> hijo = new ABB<T>();
		if(root!=null) hijo.root = root.left;
		return hijo;
	}
	
	/*********************************************************/
	
	/**
	* Returns right subtree
	*/
	public ABB<T> hijoDerecho() {
		ABB<T> hijo = new ABB<T>();
		if(root!=null) hijo.root = root.right;
		return hijo;
	}
	
	/*********************************************************/
	
	/**
	* Returns root value of this tree
	*/
	public T Raiz() {
		if(esArbolVacio()) return null;
		return root.key;
	}

	/*********************************************************/
	
	/**
	* Returns true if tree represents a leaf
	*/
	public boolean esNodoHoja() {
		return !esArbolVacio()
			&& hijoIzquierdo().esArbolVacio()
			&& hijoDerecho().esArbolVacio();
	}
	
	/*********************************************************/
	
	/**
	* Returns true if this tree is empty, false otherwise
	*/
	public boolean esArbolVacio() {
		return root == null;
	}
	
	/*********************************************************/
	
	private static <R extends Comparable<R>> ABB<R> buscarClave_r(ABB<R> abb, R clave) {
		if(abb.esArbolVacio()) return null;
		if(clave==abb.Raiz()) return abb;
		
		if(clave.compareTo(abb.Raiz()) < 0) {
			ABB<R> hijo = abb.hijoIzquierdo();
			return buscarClave_r(hijo, clave);
		} else {
			ABB<R> hijo = abb.hijoDerecho();
			return buscarClave_r(hijo, clave);
		}
	}
	
	/**
	* Returns a subtree whose root is key or null if there's none
	*/
	public ABB<T> buscarClave(T clave) {
		return buscarClave_r(this, clave);
	}

	/*********************************************************/	

	private static <R extends Comparable<R>> void reemplazarSup(ABB<R> abb, ABB<R> padre, ABB<R> reemplazo) {
		if(!reemplazo.hijoDerecho().esArbolVacio())
			reemplazarSup(abb, reemplazo, reemplazo.hijoDerecho());
		else {
			abb.root.key = reemplazo.root.key;
			padre.root.right = reemplazo.root.left;
		}
	}

	private static <R extends Comparable<R>> void eliminarClave_r(ABB<R> abb, R clave) {
		if(!abb.esArbolVacio()) {
			int compareVal = clave.compareTo(abb.Raiz());
			if(compareVal < 0) {
				eliminarClave_r(abb.hijoIzquierdo(), clave);
			} else if(compareVal > 0) {
				eliminarClave_r(abb.hijoDerecho(), clave);
			} else {
				if(abb.hijoIzquierdo().esArbolVacio()) {
					if(!abb.hijoDerecho().esArbolVacio()) {
						abb.root.key = abb.hijoDerecho().root.key;
						abb.root.left = abb.hijoDerecho().root.left;
						abb.root.right = abb.hijoDerecho().root.right; // order matters here
					} else {
						abb.arbolVacio();
					}
				} else if(abb.hijoDerecho().esArbolVacio()) {
					if(!abb.hijoIzquierdo().esArbolVacio()) {
						abb.root.key = abb.hijoIzquierdo().root.key;
						abb.root.right = abb.hijoIzquierdo().root.right;
						abb.root.left = abb.hijoIzquierdo().root.left; // order matters here
					} else {
						abb.arbolVacio();
					}
				} else {
					ABB<R> reemplazo = abb.hijoIzquierdo(); // we replace trees with two branches with maximum from left subtree
					if(reemplazo.hijoDerecho().esArbolVacio()) { // if maximum is immediate left child
						abb.root.key = reemplazo.root.key;
						abb.root.left = reemplazo.root.left;
					} else reemplazarSup(abb, abb, reemplazo); // if there are branches further right
				}
			}
		}
	}
	
	/**
	* Removes key from tree
	*/
	public void eliminarClave(T clave) {
		eliminarClave_r(this, clave);
	}

	/*********************************************************/	

	@Override
	public String toString() {
		if(esNodoHoja())
			return String.format("(%s)", Raiz().toString());
		else if(!esArbolVacio())
			return String.format("(%s %s %s)",
				Raiz().toString(),
				hijoIzquierdo(),
				hijoDerecho());
		return "()";
	}
}
