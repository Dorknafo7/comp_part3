all: rx-cc

rx-cc: flex_part3 bison_part3 
	g++ -std=c++11 flex_part3.cpp part3.tab.cpp part3_helpers.cpp -o rx-cc

bison_part3: part3.tab.cpp part3.tab.hpp

part3.tab.cpp part3.tab.hpp: part3.ypp
	bison -d part3.ypp

flex_part3: flex_part3.cpp flex_part3.h
	
flex_part3.cpp flex_part3.h: part3.lex
	flex part3.lex

# Utility targets
.PHONY: clean

clean:
	rm -f rx-cc flex_part3.cpp flex_part3.h part3.tab.cpp part3.tab.hpp *.rsk

