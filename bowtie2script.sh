# this builds the binary index files (6 files) all with the specificed prefix
bowtie2-build dir/TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta <prefixforoutput> 

# run the alignment for the first file - don't have to gunzip input files
bowtie2 --quiet -x tryp_align1 -1 ./fastq/100k.C1-1-501_1.fq -2 ./fastq/100k.C1-1-501_2.fq \
-S 100k.C1-1-501.sam

##### THIS IS THE FINAL VERSION + LOOPING AND DIRECT OUTPUT TO BAM
for i in $(ls $FASTQ/*.fq.gz | rev | cut -c 9- | rev | uniq)
do
bowtie2 -p 5 -x trypgenome_ref -1 ${i}_1.fq.gz -2 ${i}_2.fq.gz | samtools view -S -bo ${i}.bam
done


#### making some changes to output sam files into sorted bam

for i in $(ls $FASTQ/*.fq.gz | rev | cut -c 9- | rev | uniq)
do
bowtie2 -p 5 -x trypgenome_ref -1 ${i}_1.fq.gz -2 ${i}_2.fq.gz | samtools sort -S -o ${i}.sorted.bam
done
