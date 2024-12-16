#!/bin/bash

items=( SRR6914927 SRR6914928 SRR6914931 SRR6914932 SRR6914933 SRR6914934 SRR6914935 SRR6914937 SRR6914959 SRR6914960 SRR6914961 SRR6914962 SRR6914963 SRR6914964 SRR6914973 SRR6914974 )

for item in "${items[@]}"; do
  echo "Downloading FASTQ from SRA Archive"
  cd fastq
  /ccb/sw/bin/prefetch --max-size 150G "$item"
  /ccb/sw/bin/fasterq-dump --split-files "$item"
  cd ..
  echo "Running $item with BowTie2"
  bowtie2 -p 16 -x bt_index/index -1 fastq/"$item"_1.fastq -2 fastq/"$item"_2.fastq -S sams/"$item".sam
  /ccb/sw/bin/samtools sort -@ 8 -o bams/"$item".bam sams/"$item".sam
  rm -rf fastq/"$item"_*
done
