CC = gcc
CXX = g++
ECHO = echo
RM = rm -f

TERM = "S2019"

CFLAGS = -Wall -Werror -ggdb -funroll-loops -DTERM=$(TERM)
CXXFLAGS = -Wall -Werror -ggdb -funroll-loops -DTERM=$(TERM)

LDFLAGS = 

BIN = poke327
OBJS = poke327.o heap.o

all: $(BIN) etags

$(BIN): $(OBJS)
	@$(ECHO) Linking $@
	@$(CC) $^ -o $@ $(LDFLAGS)

-include $(OBJS:.o=.d)

%.o: %.c
	@$(ECHO) Compiling $<
	@$(CC) $(CFLAGS) -MMD -MF $*.d -c $<

%.o: %.cpp
	@$(ECHO) Compiling $<
	@$(CXX) $(CXXFLAGS) -MMD -MF $*.d -c $<

.PHONY: all clean clobber etags clean_exe

clean: clean_exe
	@$(ECHO) Removing all generated files
	@$(RM) *.o *.d TAGS core vgcore.* gmon.out

clobber: clean
	@$(ECHO) Removing backup files
	@$(RM) *~ \#* *pgm

etags:
	@$(ECHO) Updating TAGS
	@etags *.[ch]

clean_exe:
	@$(ECHO) Removing poke327.exe
	@if [ -f poke327.exe ]; then rm poke327.exe; fi