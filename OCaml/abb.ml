type abb = Null | Node of (int * abb ref * abb ref);;

exception Invalid_arg;;

let arbolVacio a =
	a := Null;;

let crearNodo p c = 
	p := Node (c, ref Null, ref Null);;

let hijoIzquierdo = function
	| Null -> raise (Invalid_arg)
	| Node (_,i,_) -> i;;

let hijoDerecho = function
	| Null -> raise (Invalid_arg)
	| Node (_,_,d) -> d;;

let raiz = function
	| Null -> raise (Invalid_arg)
	| Node (r,_,_) -> r;;

let esArbolVacio = function
	| Null -> true
	| Node _ -> false;;

let rec insertar_r a c =
	if !a = Null then
		crearNodo a c
	else if c < (raiz !a) then
		insertar_r (hijoIzquierdo !a) c
	else if c > (raiz !a) then
		insertar_r (hijoDerecho !a) c
	else ();;

let insertar_i a c =
	let nuevo = ref Null in
	let padre = ref Null in
	let hijo = ref Null in
	crearNodo nuevo c;
	if !a = Null then a := !nuevo
	else begin
		hijo := !a;
		while (!hijo <> Null) && (raiz !hijo <> c) do
			padre := !hijo;
			if c < (raiz !hijo)
			then hijo := !(hijoIzquierdo !hijo)
			else hijo := !(hijoDerecho !hijo)
		done;

		if !hijo = Null then
			if c < (raiz !padre) then
				(hijoIzquierdo !padre) := !nuevo
			else
				(hijoDerecho !padre) := !nuevo
	end;;

let rec buscar_r a c =
	if !a = Null then
		ref Null
	else if c = (raiz !a) then a
	else if c < (raiz !a) then
		let izq = (hijoIzquierdo !a) in
		buscar_r izq c
	else
		let der = (hijoDerecho !a) in
		buscar_r der c;;

let buscar_i a c =
	let nodo = ref Null in
	nodo := !a;
	while !nodo <> Null && (raiz !nodo) <> c do
		if c < (raiz !nodo)
		then nodo := !(hijoIzquierdo !nodo)
		else nodo := !(hijoDerecho !nodo)
	done;
	nodo;;

let rec eliminar_r a c =
	let aux = ref Null in
	let rec sup2 b =
		let Node (clave,izquierdo,derecho) = !b in
		if !derecho <> Null then
			sup2 derecho
		else
			let Node (_,auxizq,auxder) = !aux in (
				aux := Node (clave,auxizq,auxder);
				b := !izquierdo )
	in if !a <> Null then
		let Node (ra,izq,der) = !a in
		if c < ra then
			eliminar_r izq c
		else if c > ra then
			eliminar_r der c
		else (
			aux := !a;
			if !izq = Null then a := !der
			else if !der = Null then a := !izq
			else (
				sup2 (hijoIzquierdo !a);
				a := !aux ))
	else ();;

let eliminar_i a c =
	let sup = ref Null in
	let pSup = ref Null in
	let hijoNoVacio = ref Null in
	let sucIzMax = ref Null in
	sup := !a;
	while !sup <> Null && (raiz !sup) <> c do
		pSup := !sup;
		if c < (raiz !sup) then sup := !(hijoIzquierdo !sup)
		else sup := !(hijoDerecho !sup)
	done;

	if !sup <> Null then
		match !sup with
			| Node (_, i, d) when !i = Null && !d = Null ->
				if !pSup = Null then a := Null
				else if sup = (hijoIzquierdo !pSup) then
					(hijoIzquierdo !pSup) := Null
				else (hijoDerecho !pSup) := Null
			| Node (_,i,d) when (!i = Null) <> (!d = Null) ->
				hijoNoVacio := if !i = Null then !d else !i;
				if !pSup = Null then a := !hijoNoVacio
				else if (hijoIzquierdo !pSup) = sup then
					(hijoIzquierdo !pSup) := !hijoNoVacio
				else (hijoDerecho !pSup) := !hijoNoVacio
			| Node _ ->
				pSup := !sup;
				sucIzMax := !(hijoIzquierdo !sup);
				while !(hijoDerecho !sucIzMax) <> Null do
					pSup := !sucIzMax;
					sucIzMax := !(hijoDerecho !sucIzMax)
				done;
				
				let Node(_,izq,der) = !sup in
				let Node(_,pi,pd) = !pSup in (
				sup := Node (raiz !sucIzMax, izq, der);
				if pSup = sup then
					pi := !(hijoIzquierdo !sucIzMax)
				else pd := !(hijoDerecho !sucIzMax);
				sup := !sucIzMax )

let p = ref Null;;
let test () =
	insertar_i p 10;
	insertar_i p 5;
	insertar_i p 6;
	eliminar_i p 5;;
