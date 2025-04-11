# w32vc.mak

## Makefile to build the CCCC project on the Win32/Visual Studio platform.
## See rules.mak for discussion of the meaning of the make variables
## which this file defines


# support for debugging (note that debug building is on by default)
!IF "$(DEBUG)"=="true"
CFLAGS_DEBUG=-Zi
LDFLAGS_DEBUG=-Zi
!ENDIF

PATHSEP=\\
CCC=cl.exe -nologo
LD=cl.exe -nologo
CCC_OPTS=-c -I$(PCCTS_H) $(CFLAGS_DEBUG) -GX -TP -D_CRT_SECURE_NO_WARNINGS -DCCCC_CONF_W32VC
C_OFLAG=-Fo
LDFLAGS=$(LDFLAGS_DEBUG) 
LD_OFLAG=-Fe
OBJEXT=obj
CCCC_EXE=cccc.exe

COPY=copy
RM=del

!INCLUDE rules.mak

