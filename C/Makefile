PDIR = ..
PROJECTVER = 0.1
PREFIX := $(HOME)/.lua
PROJECT = lCDK
DATADIR = $(PDIR)/Data
BUILDLIBDIR = $(PDIR)/Build/Library
CC := gcc
DEBUG := 0
CCOPTS := -g `cdk5-config --cflags` -fPIC

LIBNAME = lib`echo $(PROJECT) | tr A-Z a-z`
LIBNAMESO = $(LIBNAME).$(PROJECTVER).so

all: so

so: lcdk.o
	@echo " ==== Building $(LIBNAMESO) Library ===="
	@echo "  --> $(LIBNAMESO) [LD]"
	@$(CC) -g $(CCOPTS) -shared -Wl,-soname,$(LIBNAMESO) -o $(BUILDLIBDIR)/$(LIBNAMESO) -lcdk lcdk.o
	@pushd $(BUILDLIBDIR);ln -s $(LIBNAMESO) $(LIBNAME).so ; popd

lcdk.o: lcdk.c
	@echo "  --> lcdk.o [CC]"
	$(CC) $(CCOPTS) -D_DEBUG=$(DEBUG) -c lcdk.c

install: all
	@echo " === Installing $(LIBNAMESO) === "
	@mkdir -p $(PREFIX)/lib/
	@cp $(BUILDLIBDIR)/$(LIBNAMESO) $(PREFIX)/lib
	@pushd $(PREFIX)/lib;ln -s $(LIBNAMESO) $(LIBNAME).so ; popd

uninstall:
	@echo " === Uninstalling $(LIBNAMESO) === "
	@rm -rf $(PREFIX)/lib/$(LIBNAMESO)
	@rm -rf $(PREFIX)/lib/$(LIBNAME).so

clean:
	@echo " ==== Cleaning C module ==== "
	@rm lcdk.o 2>/dev/null || true
#	@rm $(LIBNAMESO).0.1  2>/dev/null || true
	@rm $(BUILDLIBDIR)/$(LIBNAMESO) 2>/dev/null || true
