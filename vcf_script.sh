#!/bin/bash

items=( SRR6914928 SRR6914931 SRR6914932 SRR6914933 SRR6914934 SRR6914935 SRR6914937 SRR6914959 SRR6914960 SRR6914961 SRR6914962 SRR6914963 SRR6914964 SRR6914973 SRR6914974 )

for item in "${items[@]}"; do
    freebayes -f ref/GRCh38.dna.primary_assembly.fa bams/"$item".chr21.filtered.bam > vars/"$item".chr21.vcf
    bcftools filter -e 'QUAL<100' vars/"$item".chr21.vcf -o vars/"$item".chr21.filtered.vcf
    vcftools --vcf vars/"$item".chr21.filtered.vcf --maf 0.05 --recode --out vars/"$item".chr21.filtered
done
