# We need to start from regions and obtain chr by chr bed files
.PHONY: all_bed
all_bed: $(addsuffix .bed, $(CHR))

%.bed: $(REGIONS)
	bawk '$$1==$*' < $< > $@
