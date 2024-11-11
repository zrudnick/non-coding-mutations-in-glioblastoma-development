#!/bin/bash

items=( "SRR24147148" "SRR24147147" "SRR24147146" "SRR24147145" "SRR24147144" "SRR24147143" "SRR24147142" "SRR24147141" "SRR24147140" "SRR24147139" "SRR24147138" "SRR24147137" "SRR24147136" "SRR24147135" "SRR24147134" "SRR24147133" "SRR24147132" "SRR24147131" "SRR24147130" "SRR24147129" "SRR24147128" )

for item in "${items[@]}"; do
  echo “Downloading FASTQ from SRA Archive”
  cd fastq
  prefetch “$item”
  fasterq-dump --split-files “$item”
  cd ..
  echo "Running $item with HISAT2"
  hisat2 -p 8 --dta --quiet -x hisat_index/hisat_index -1 fastq/”$item”_1.fastq -2 fastq/“$item”_2.fastq -S sams/”$item”.sam
  samtools sort -@ 8 -o bams/”$item”.bam sams/”$item”.sam
  rm -rf fastq/”$item”_*
done
