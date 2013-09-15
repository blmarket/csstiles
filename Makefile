all: buildcss tile_list.json
	./buildcss
	mv *.css public/

test: tile_list.json

tile_list.json: buildlist
	./buildlist > tile_list.json
	
buildcss: rltiles main.cc
	g++ main.cc *.o -o buildcss

# rltiles should be in here too, but it makes
# build slow due to recompile all cc files every time.
# so I omitted it intentional.
buildlist: listing.cc
	g++ listing.cc *.o -o buildlist

rltiles:
	make -C rltiles TILES=y
	g++ -c rltiles/*.cc # creates .o files.
	cp rltiles/*.png public/

clean:
	make -C rltiles clean
	rm public/*.png public/*.css buildcss buildlist
	rm *.o

.PHONY: all clean rltiles test
