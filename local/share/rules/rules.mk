PHASES := Lappa
include $(BIOINFO_ROOT)/local/share/makefile/global-rules.mk

layout: $(PHASES) $(addsuffix /rules.mk,$(PHASES)) $(addsuffix /makefile,$(PHASES))

$(PHASES):
	mkdir $@

%/rules.mk: ../../local/share/rules-%.mk %
	cd $(word 2,$^) && ln -sf ../$< rules.mk

%/makefile: makefile %
	cd $* && ln -sf ../$$(basename $@)

