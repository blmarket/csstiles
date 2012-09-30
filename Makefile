all: a.out
	./a.out
	mv *.css public/
	
a.out: main.cc
	make -C rltiles TILES=y
	cp rltiles/*.png public/
	g++ main.cc rltiles/*.cc

clean:
	make -C rltiles clean
	rm public/*.png public/*.css a.out
