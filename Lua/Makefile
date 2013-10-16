PDIR = ..
DATADIR = $(PDIR)/Data
PREFIX := $(HOME)/.lua
PROJECT = CDK
CDIR = $(PDIR)/C
CCFLAGS = `cdk5-config --cflags`
LUADIR = $(PDIR)/Lua
BINDIR = $(PDIR)/Bin
LUADIRPROJECT = ${LUADIR}/${PROJECT}

BUILDLIBRARYDIR = $(PDIR)/Build/Library
BUILDSHAREDDIR = $(PDIR)/Build/Shared

CONSTANTSBIN = $(DATADIR)/constants.lua
CONSTANTSDEF = $(DATADIR)/${PROJECT}Constants.def
CONSTANTSC = $(CDIR)/${PROJECT}Constants.c
CONSTANTSLUA = $(LUADIR)/${PROJECT}/Constants.lua
CONSTANTSGEN = $(DATADIR)/${PROJECT}Constants

PROJECTMOD = ${PROJECT}
LIBRARYFILES = CDK.lua Dialog.lua Binding.lua Label.lua Viewer.lua \
	Swindow.lua Fselect.lua Entry.lua Util.lua Selection.lua Itemlist.lua \
	Radio.lua Template.lua

all: library auxlibraries constants

library: $(LUADIR)/${PROJECT}/${PROJECT}.lua
	@echo " ==== Copying lua libraries [LUA] ==== "
	@for i in `echo ${LIBRARYFILES}`; do \
		echo "   --> $$i [LUA] " ; \
		cp $(LUADIRPROJECT)/$$i ${BUILDSHAREDDIR}/${PROJECT} ; \
	done

auxlibraries: $(LUADIR)/struct.lua $(LUADIR)/switch.lua
	@echo " ==== Copying aux lua libraries [LUA] ==== "
	@cp $(LUADIR)/struct.lua $(BUILDSHAREDDIR)/$(PROJECT)
	@cp $(LUADIR)/switch.lua $(BUILDSHAREDDIR)/$(PROJECT)
	@cp $(LUADIR)/alienize.lua $(BUILDSHAREDDIR)/$(PROJECT)

constants: $(CONSTANTSDEF)
	@echo " ==== Building ${PROJECT} Constants [$(CONSTANTSLUA)] ===="
	@$(CONSTANTSBIN) '$(CONSTANTSDEF)' '$(CONSTANTSC)' '$(CONSTANTSLUA)' '$(PROJECTMOD)'
	@echo "  --> $(CONSTANTSC) [CC]"
	@$(CC) $(CCFLAGS) -I$(CDIR) -o $(CONSTANTSGEN) $(CONSTANTSC)
	@echo "  --> $(CONSTANTSLUA) [LUA]"
	@$(CONSTANTSGEN) || true
	@cp $(LUADIR)/${PROJECT}/${PROJECT}.lua $(BUILDSHAREDDIR)/${PROJECT}
	@cp $(LUADIR)/${PROJECT}/Constants.lua $(BUILDSHAREDDIR)/${PROJECT}

install: all
	@echo " == Installing ${PROJECT}.lua == "
	@mkdir -p $(PREFIX)/share/
	@cp -r $(BUILDSHAREDDIR)/${PROJECT} $(PREFIX)/share


uninstall: 
	@echo " == Uninstalling ${PROJECT}.lua == "
	@rm -rf $(PREFIX)/share/${PROJECT}

clean:
	@echo " ==== Cleaning Lua files ==== "
	@rm -rf $(CONSTANTSGEN)
	@rm -rf $(CONSTANTSLUA)
	@rm -rf $(CONSTANTSC)
