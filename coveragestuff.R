refseq.header <- c(
  "seqname",
  "source",
  "feature",
  "start",
  "end",
  "score",
  "strand",
  "frame",
  "attribute"
)
mim2gene.header <- c(
  "mim",
  "type",
  "NCBI",
  "HGNC",
  "Ensembl"
)
attribute.header <- c(
  "ID",
  "Parent",
  "Dbxref",
  "gbkey",
  "gene",
  "product",
  "pseudo",
  "transcript_id"
)

refseq <- read.table("refseq.gff.gz", col.names=refseq.header, sep="\t")
refseq <- refseq[refseq$feature == "exon",]

attribute <- data.frame(
  apply(
    sapply(
      strsplit(
        as.character(refseq$attribute),
        ';',
        fixed=TRUE
      ),
      function(x) strsplit(x, "=")
    ),
    1,
    function(x) sapply(x, "[", 2)
  ))
colnames(attribute) <- attribute.header
refseq <- cbind(refseq, attribute)
refseq <- refseq[ , !(names(refseq) %in% c("attribute"))]

mim2gene <- read.table("mim2gene", col.names=mim2gene.header, sep="\t")
mim2gene <- mim2gene[mim2gene$type == "gene",]
print(match(refseq$gene, mim2gene$HGNC))
# print(refseq)
# print(mim2gene)
