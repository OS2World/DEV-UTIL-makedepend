# this MUST be FIRST (why?)

.SUFFIXES:
.SUFFIXES: .c .cpp .obj

# info, PROG is name of exe or dll

NAME    = makedepend
PROG    = makedepend
AUTHOR  = li
VERSION = 1.0
TARGET	= exe
MODULES = 

# edit here for other paths for make install

DLLDIR = \work\dll
BINDIR = \work\bin
LIBDIR = \work\lib

LIBS =
CPP  =
CFILES = cppsetup.c ifparser.c include.c main.c parse.c pr.c

all: $(PROG).$(TARGET) install

# common definitions

CC      = icc -q
LINK    = icc -q
IMPLIB  = implib /nologo
RM      = del
CP      = copy
TOUCH   = touch

OBJS 		= $(patsubst %.c,obj/%.obj,$(CFILES)) $(patsubst %.cpp,obj/%.obj,$(CPP)) 
LINK_OBJS 	= $(patsubst %.c,obj\\%.obj,$(CFILES)) $(patsubst %.cpp,obj\\%.obj,$(CPP))

# flags

CFLAGS		= -Gd+ -Se -Re -Gm+ -G4 -W3
LFLAGS		= /NOLOGO /F /NOI /NOE

C_OPTIMIZE  = $(COMPILE_FLAGS) -O+ -Oi+
L_OPTIMIZE  = $(LINK_FLAGS)
LC_OPTIMIZE = -Ol+

BROWSE_FLAG  = -Fb+
LIST_FLAGS   = -Ls+ -Le+ -Li+ -Lx+ -Ly+

# this is stupid, but ifdef somehow doesn't work

ifeq ($(DEBUG),-DDEBUG)
CFLAGS += -O- -Oi- -Ti+ -DDEBUG
LFLAGS += /DE
endif

ifeq ($(TARGET),dll)
CFLAGS += -Ge-
else
CFLAGS += -Ge+
endif

#make an obj

obj/%.obj:: %.c
	$(CC) $(CFLAGS) $(ADDITIONAL_CFLAGS) -Fo"$@" -c $<

obj/%.obj:: %.cpp
	$(CC) -Tdp $(CFLAGS) $(ADDITIONAL_CFLAGS) -Fo"$@" -c $<

# make a dll 

$(PROG).dll: $(OBJS)
	$(LINK) -b "$(LFLAGS)" -Fe "$(PROG).dll" $(LINK_OBJS) $(LIBS) $(PROG).def
	$(IMPLIB) $(PROG).lib $(PROG).dll

# make an exe

$(PROG).exe: $(OBJS)
	$(LINK) -b "$(LFLAGS)" -Fe "$(PROG).exe" $(LINK_OBJS) $(LIBS) $(PROG).def

debug:
	make "DEBUG=-DDEBUG"

# make the modules

modules:
	for %i in ( $(MODULES) ) do cd $(SOURCES)\\"%i" & make & if ERRORLEVEL 1 exit

debug_modules:
	for %i in ( $(MODULES) ) do cd $(SOURCES)\\"%i" & make debug & if ERRORLEVEL 1 exit

clean_modules:
	for %i in ( $(MODULES) ) do cd $(SOURCES)\\"%i" & make clean & if ERRORLEVEL 1 exit

depend_modules:
	for %i in ( $(MODULES) ) do cd $(SOURCES)\\"%i" & make depend & if ERRORLEVEL 1 exit

depend:
	makedep -p obj/ -I /work/sources $(CPP)

install:
ifeq ($(TARGET),dll)
	$(CP)	$(PROG).dll $(DLLDIR)
	$(CP)	$(PROG).lib $(LIBDIR)
else
	$(CP)	$(PROG).exe $(BINDIR)
endif

# clean: does NOT remove the compiled exe, dll, or lib in $(BINDIR), $(DLLDIR), or $(LIBDIR)

clean:
	-$(RM) obj\\*.obj
	-$(RM) $(PROG).lib
	-$(RM) $(PROG).$(TARGET)


# DO NOT DELETE

obj/main.obj: def.h E:\IBMCPP\INCLUDE/stdio.h Xosdefs.h Xfuncproto.h
obj/main.obj: E:\IBMCPP\INCLUDE/ctype.h E:\IBMCPP\INCLUDE/sys/types.h
obj/main.obj: E:\IBMCPP\INCLUDE/fcntl.h E:\IBMCPP\INCLUDE/sys/stat.h
obj/main.obj: E:\IBMCPP\INCLUDE/stdlib.h E:\IBMCPP\INCLUDE/signal.h
obj/main.obj: E:\IBMCPP\INCLUDE/stdarg.h imakemdep.h
