open Abb;;
open Printf;;

let arbol = ref Null;;

let rec preordenParentizado a =
	print_string "(";
	if not (esArbolVacio !a) then (
		let Node (clave, izq, der) = !a in
		if not (esArbolVacio !izq) || not (esArbolVacio !der) then (
			print_int clave;
			print_string " ";
			preordenParentizado izq;
			print_string " ";
			preordenParentizado der )
		else
			print_int clave);
	print_string ")";;

let usage () =
	print_string "Usage: programa_abb command \n";
	print_string "Commands must be of the form \"i 3 5 1 e 3 i 4\" ";
	print_string "with i representing insertions and e erasures. ";
	print_string "If unspecified, insertions are asummed by default.";
	exit 1;;
	
let main () =
	let delete = ref false in
	for i = 1 to Array.length Sys.argv - 1 do
		match Sys.argv.(i) with
			| "i" -> delete := false
			| "e" -> delete := true
			| _ -> try
					let key = int_of_string Sys.argv.(i) in
					if !delete then
						eliminar_r arbol key
					else
						insertar_r arbol key
				with
					| Failure _ -> usage ();
	done;
	preordenParentizado arbol;
	print_endline "";;

main ();
