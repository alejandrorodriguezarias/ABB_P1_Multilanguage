CAMLC=ocamlopt
CMX = abb.cmx programa_abb.cmx
OUTPUT = programa_abb

%.cmx: %.ml
	$(CAMLC) -c $<

$(OUTPUT): $(CMX)
	$(CAMLC) -o $(OUTPUT) $(CMX)

.PHONY: clean test

clean:
	rm -f *.o *.cmx *.cmi $(OUTPUT)

test:	$(OUTPUT)
	./test
