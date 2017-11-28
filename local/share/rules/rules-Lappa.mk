# We need to start from regions and obtain chr by chr bed files
.PHONY: all_bed
all_bed: $(addprefix chr, $(addsuffix .bed, $(CHR)))

$(addprefix chr, $(addsuffix .bed, $(CHR))): chr%.bed: $(REGIONS)
	bawk '$$1==$*' < $< > $@

.PHONY: all_rider
all_rider: $(addsuffix .vcf_rider_mat.gz, $(CHRC))
$(addsuffix .vcf_rider_mat.gz, $(CHRC)): %.vcf_rider_mat.gz: $(PWM) %.bed $(VCF_FOLDER)/%.vcf.gz $(MAIN_BIOINFO_ROOT)/task/sequences/dataset/ensembl/$(SPECIES)/$(VERSION)/%.fa
	vcf_rider -v <(bgzip -c -d $^3) -p $< -b $^2 -r $^4 -a $*_genes_snp_lib -f $(BACKGROUND) | gzip > $@
