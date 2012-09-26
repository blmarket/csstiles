all: a.out
	./a.out
	
a.out: main.cc
	make -C rltiles TILES=y
	cp rltiles/*.png .
	g++ main.cc rltiles/*.o

clean:
	make -C rltiles clean
	rm a.out
