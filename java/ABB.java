/*
* Jacobo Bouzas Quiroga - jacobo.bouzas.quiroga@udc.es
* Alejandro Arias Rodríguez - alejandro.arias.rodriguez@udc.es
*/
public class ABB {

	private Integer clave;
	private ABB izdo, dcho;

	/******************************************/

	public void arbolVacio(final ABB a) {
		a.clave = null;
		a.izdo = null;
		a.dcho = null;
	}

	public ABB hijoIzquierdo() {
		return izdo;
	}

	public ABB hijoDerecho() {
		return dcho;
	}

	public int raiz() {
		return clave;
	}

	/*
	 * La función esArbolVacio se utiliza en lugar de comparar con null para
	 * permitir el objeto creado pero sin datos asignados como árbol vacío.
	 */
	public static boolean esArbolVacio(ABB a) {
		return (a == null) || (a.clave == null);
	}

	/******************************************/

	private static void insertar_r(final ABB a, final int c) {
		if (esArbolVacio(a)) {
			a.clave = c;
			a.izdo = null;
			a.dcho = null;
		} else if (c < a.raiz()) {
			/*
			 * Al no haber paso por referencia, tenemos que prevenir que la función
			 * se llame sobre null instanciando las ramas antes de acceder a ellas.
			 */
			if(a.izdo == null) a.izdo = new ABB();
			insertar_r(a.izdo, c);
		} else if (c > a.raiz()) {
			if(a.dcho == null) a.dcho = new ABB();
			insertar_r(a.dcho, c);
		}
	}

	private static void insertar_i(final ABB a, final int c) {

		if (esArbolVacio(a)) {
			a.clave = c;
		} else {
			ABB nuevo, padre, hijo;
			nuevo = new ABB();
			nuevo.clave = c;

			padre = null;
			hijo = a;
			while (!esArbolVacio(hijo) && (hijo.clave != c)) {
				padre = hijo;
				if (c < hijo.clave)
					hijo = hijo.izdo;
				else
					hijo = hijo.dcho;
			}

			if (esArbolVacio(hijo)) {
				if (c < padre.clave)
					padre.izdo = nuevo;
				else
					padre.dcho = nuevo;
			}
		}
	}

	private static ABB buscar_r(final ABB a, final int c) {
		if (esArbolVacio(a))
			return null;
		else if (a.clave == c)
			return a;
		else if (c < a.clave)
			return buscar_r(a.izdo, c);
		else
			return buscar_r(a.dcho, c);
	}

	private static ABB buscar_i(final ABB a, final int c) {
		ABB nodo;

		nodo = a;
		while ((nodo != null) && (nodo.clave != c)) {
			if (c < nodo.clave)
				nodo = nodo.izdo;
			else
				nodo = nodo.dcho;
		}

		return nodo;
	}

	/*
	 * Dado que no hay paso por referencia es necesario transportar un puntero al
	 * padre a través de la función para poder eliminar las referencias al nodo de
	 * la estructura.
	 * 
	 * Aux se pasa a la función como argumento ya que no hay un concepto de función
	 * anidada en Java.
	 */
	private static void sup2(final ABB b, final ABB padre, final ABB aux) {
		if (!esArbolVacio(b.dcho))
			sup2(b.dcho, b, aux);
		else {
			aux.clave = b.clave;
			/* comprobamos si es el nodo inmediatamente a la izquierda del
			 * reemplazado para elegir la posición en la que pegamos la
			 * rama izquierda del nodo candidato*/
			if(padre != aux) padre.dcho = b.izdo;
			else padre.izdo = b.izdo;
		}
	}

	private static void eliminar_r(ABB a, final int c) {
		if (!esArbolVacio(a))
			if (c < a.clave)
				eliminar_r(a.izdo, c);
			else if (c > a.clave)
				eliminar_r(a.dcho, c);
			else {
				/* al no haber paso por referencia es necesario "transplantar"
				 * el nodo hijo correspondiente al nodo cuyo dato se elimina*/
				if (esArbolVacio(a.izdo)) {
					if(a.dcho == null) a.dcho = new ABB();
					a.clave = a.dcho.clave;
					a.izdo = a.dcho.izdo;
					a.dcho = a.dcho.dcho; // aquí importa el orden
				} else if (esArbolVacio(a.dcho)) {
					a.clave = a.izdo.clave;
					a.dcho = a.izdo.dcho;
					a.izdo = a.izdo.izdo; // y aquí
				} else
					sup2(a.izdo, a, a);
			}
	}

	private static void eliminar_i(final ABB a, final int c) {
		ABB pSup = null;
		ABB sup = a;
		while (!esArbolVacio(a) && sup.clave != c) {
			pSup = sup;
			if(c < sup.clave)
				sup = sup.izdo;
			else sup = sup.dcho;
		}
		
		if(sup != null) {
			int numHijos = 0;
			numHijos += esArbolVacio(sup.izdo) ? 0 : 1;
			numHijos += esArbolVacio(sup.dcho) ? 0 : 1;
			
			switch (numHijos) {
			case 0:
				if(esArbolVacio(pSup)) {
					a.clave = null;
					a.dcho = null;
					a.izdo = null;
				} else if(pSup.izdo==sup) {
					pSup.izdo = null;
				} else {
					pSup.dcho = null;
				}
				break;
			case 1:
				ABB hijoNoVacio = esArbolVacio(sup.izdo) ? sup.dcho : sup.izdo;
				if(esArbolVacio(pSup)) {
					a.clave = hijoNoVacio.clave;
					a.dcho = hijoNoVacio.dcho;
					a.izdo = hijoNoVacio.izdo;
				} else if (pSup.izdo == sup) pSup.izdo = hijoNoVacio;
				else pSup.dcho = hijoNoVacio;
				break;
			case 2:
				pSup = sup;
				ABB sucIzMax = sup.izdo;
				while (!esArbolVacio(sucIzMax.dcho)) {
					pSup = sucIzMax;
					sucIzMax = sucIzMax.dcho;
				}
				
				sup.clave = sucIzMax.clave;
				if(pSup == sup) pSup.izdo = sucIzMax.izdo;
				else pSup.dcho = sucIzMax.izdo;
				break;
			default:
				break;
			}
		}
	}

	/******************************************/

	public static void insertarClave(final ABB a, final int c) {
		insertar_i(a, c);
	}

	public static ABB buscarClave(final ABB a, final int c) {
		return buscar_i(a, c);
	}

	public static void eliminarClave(ABB a, int c) {
		eliminar_i(a, c);
	}
	
	/******************************************/
	
	@Override
	public String toString() {
		if(esArbolVacio(this)) return "()";
		String i = izdo == null ? "()" : izdo.toString();
		String d = dcho == null ? "()" : dcho.toString();
		return "("
				+ raiz()
				+ (esArbolVacio(izdo) && esArbolVacio(dcho) ? "" : " " + i + " " + d)
				+ ")";
	}
}
