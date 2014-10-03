makedepend
----------

This is a quick and rude port of the X11 R6 makedepend to OS/2 using icc.

I have taken the code from FreeBSD 2.0.5, which I happened to have handy.

I have added a feature I wanted: the switch -iENVIRONMENTVARIABLE will add
all semicolon delimited directories in ENVIRONMENTVARIABLE to the list of
include directories.

One obvious use is: makedepend -i INCLUDE a.c

If you do not want the system header files in you dependencies, you might use:

set MYINCLUDE=\mytree\include;\mytree\subproj\include

makedepend -i MYINCLUDE a.c

but

makedepend -I \mytree\include -I \mytree\subproj\include a.c

which is the 'normal' way of doing things, is also possible.

Sources
-------

Todd Brunhoff wrote this program. Thanks.

To build makedepend, I use icc and GNU make. nmake will barf over the makefile.

And yes, I use long filenames. If you don't like that, edit the makefile.

I have compiled these sources under NT with VC++ 4.2 without any hassles (different 
makefile, though).

Lars Immisch
lars@ibp.de