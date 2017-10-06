JAVAC=javac
JFLAGS = -classpath
CLASSES = ABB.class AbbProgram.class

AbbProgram.class ABB.class : ABB.java AbbProgram.java
	$(JAVAC) ABB.java AbbProgram.java

.PHONY: clean test

clean:
	rm -f *.class

test: AbbProgram.class
	./test
