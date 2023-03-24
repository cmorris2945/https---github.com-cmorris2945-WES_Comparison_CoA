#! /usr/bin/python

import pandas as pd
import os
import sys

#WES BAM HS metrics comparison
print()
print ("BAIT_SET	GENOME_SIZE	BAIT_TERRITORY	TARGET_TERRITORY	BAIT_DESIGN_EFFICIENCY	TOTAL_READS	PF_READS	PF_UNIQUE_READS	PCT_PF_READS	PCT_PF_UQ_READS	PF_UQ_READS_ALIGNED	PCT_PF_UQ_READS_ALIGNED	PF_BASES_ALIGNED	PF_UQ_BASES_ALIGNED	ON_BAIT_BASES	NEAR_BAIT_BASES	OFF_BAIT_BASES	ON_TARGET_BASES	PCT_SELECTED_BASES	PCT_OFF_BAIT	ON_BAIT_VS_SELECTED	MEAN_BAIT_COVERAGE	MEAN_TARGET_COVERAGE	MEDIAN_TARGET_COVERAGE	PCT_USABLE_BASES_ON_BAIT	PCT_USABLE_BASES_ON_TARGET	FOLD_ENRICHMENT	ZERO_CVG_TARGETS_PCT	PCT_EXC_DUPE	PCT_EXC_MAPQ	PCT_EXC_BASEQ	PCT_EXC_OVERLAP	PCT_EXC_OFF_TARGET	FOLD_80_BASE_PENALTY	PCT_TARGET_BASES_1X	PCT_TARGET_BASES_2X	PCT_TARGET_BASES_10X	PCT_TARGET_BASES_20X	PCT_TARGET_BASES_30X	PCT_TARGET_BASES_40X	PCT_TARGET_BASES_50X	PCT_TARGET_BASES_100X	HS_LIBRARY_SIZE	HS_PENALTY_10X	HS_PENALTY_20X	HS_PENALTY_30X	HS_PENALTY_40X	HS_PENALTY_50X	HS_PENALTY_100X	AT_DROPOUT	GC_DROPOUT	HET_SNP_SENSITIVITY	HET_SNP_Q	SAMPLE	LIBRARY	READ_GROUP")
print()
print ("The differences are:")
print()
#reading the files from the input files configuration file

file1 = open(sys.argv[1],'r')
file2 = open(sys.argv[2],'r')

#removing the lines carry different command from dnanexus and cromwell
file1_lines = file1.readlines()[7:8]
file2_lines = file2.readlines()[7:8]


#line by line cpmparison
for i in range(len(file1_lines)):
		
	if file1_lines[i] != file2_lines[i]:
		print("Line " + str(i+7) + " doesn't match.")
		print("----------------------")
		print("DNA_nexus: " + file1_lines[i], end = ' ')
		print()
		print(" Cromwell: " + file2_lines[i])

print ("Note: ***If the results are empty it means no difference in the wes BAM alignment between DNA nexus and Cromwell***")
print()

file1.close()
file2.close()

print ("______________________________________________________________________________________________________________________________________")
print()

