#!/bin/sh

# MIM2GENE="mim2gene"
# MIM2GENEURL="https://omim.org/static/omim/data/mim2gene.txt"
REFSEQ="refseq.gff.gz"
 REFSEQURL="https://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh37_latest/refseq_identifiers/GRCh37_latest_genomic.gff.gz"

# wget -q "$MIM2GENEURL" -O "$MIM2GENE"
wget -q "$REFSEQURL" -O "$REFSEQ"
zcat "$REFSEQ" | sed 21q | awk '!/^#/ {if($3=="exon") {printf "%s\t%s\t%s\n", $1,$4,$5 }}'

#samtools bedcov SeqCap_EZ_Exome_v3_hg19_capture_targets_shorter.bed 7-S7_L00_000_R2.fq_bwa.bam | awk '{printf "%s\t%s\t%s\t%d\n", $1, $2, $3, $4/($3-$2)}' | sed 11q
