open Abb;;

let arbol = ref Null;;

let rec preordenParentizado a =
	print_string "(";
	if not (esArbolVacio !a) then (
		let Node (clave, izq, der) = !a in
		if not (esArbolVacio !izq) || not (esArbolVacio !der) then (
			print_string " ";
			print_int clave;
			print_string " ";
			preordenParentizado izq;
			print_string " ";
			preordenParentizado der )
		else (
			print_string " ";
			print_int clave;
			print_string " " ))
	print_string ")";;

insertarClave arbol 4;;
insertarClave arbol 4;;
insertarClave arbol 2;;
insertarClave arbol 6;;
insertarClave arbol 1;;
insertarClave arbol 3;;
insertarClave arbol 5;;
insertarClave arbol 7;;

preordenParentizado arbol;;
print_endline ();;
