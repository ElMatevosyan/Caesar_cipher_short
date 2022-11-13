.PHONY: clean create_directories
CC = g++
export EXECUTABLE := bin/coder
export LIB := $(wildcard lib/*.so)
#export SRC_FILES := $(wildcard *.cpp)
#export OBJ_FILES := $(patsubst %.cpp, %.o, $(SRC_FILES))

all: clean create_directories  $(EXECUTABLE)

$(EXECUTABLE):lib/libunit_test.a lib/libencoder.so lib/libdecoder.so #$(LIB)
	@echo "________________________"
	@echo "Building the project..." 
	$(CC) src/main.cpp -I inc/ -Wall $^ -o $(EXECUTABLE)
	@echo "Executing the binary exe..."
	@echo "...................................."
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/lib ./$(EXECUTABLE)

lib/lib%.a: obj/%.o
	@echo "________________________"
	@echo "Create a static unit_test library..."
	ar cvq $@ $<

lib/lib%.so: obj/%.o 
	@echo "________________________"
	@echo "Creating a shared libraries......"
	$(CC) -shared -fPIC -o $@ $^

obj/%.o: src/%.cpp
	@echo "________________________"
	@echo "Creating object files..."
	$(CC) -c $^ -I inc/ -o $@


create_directories:
	@echo "Creating directories lib bin obj..." 
	@mkdir -p bin lib obj
clean:
	@echo "Cleaning the project..."
	@rm -rf bin lib obj

