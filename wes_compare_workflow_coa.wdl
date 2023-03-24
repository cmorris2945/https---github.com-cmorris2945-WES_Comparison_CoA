#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
# WES comparison workflow
# Description: Compares the WES analysis results from DNA Nexus and Cromwell
#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------
workflow wes_compare {
	File	workflow_dnanexusbbdukmetrics_normal
	File	workflow_dnanexusbbdukmetrics_tumor
	File	workflow_cromwellbbdukmetrics_normal
	File	workflow_cromwellbbdukmetrics_tumor
        String  workflow_sampleId_tumor
	String  workflow_sampleId_normal
	File	workflow_nexusbamhsnormal
	File 	workflow_crombamhsnormal
	
	    
    call trimcompare {
        input:
        sampleId_normal = workflow_sampleId_normal,
	sampleId_tumor = workflow_sampleId_tumor,
        dnanexusmetrics_normal = workflow_dnanexusbbdukmetrics_normal,
        cromwellmetrics_tumor = workflow_cromwellbbdukmetrics_tumor,
	dnanexusmetrics_tumor = workflow_dnanexusbbdukmetrics_tumor,
        cromwellmetrics_normal = workflow_cromwellbbdukmetrics_normal
        	
    }
    
    call bamcompare {
        input:
        sampleId_normal = workflow_sampleId_normal,
	sampleId_tumor = workflow_sampleId_tumor,
        nexusbamhsnormal = workflow_nexusbamhsnormal,
	crombamhsnormal = workflow_crombamhsnormal,
	
    }
}

#-----------------------------------------------------------------------------
# TASK: WES TRIM METRICS COMPARE FOR NORMAL AND TUMOR SAMPLES
# diff -y --suppress-common-lines <(sed "1d" ${dnanexusmetrics_normal}) <(sed "1d" ${cromwellmetrics_normal}) > ${sampleId_normal}_${sampleId_tumor}.wes.trimcompare.txt
#-----------------------------------------------------------------------------

task trimcompare {
    String  sampleId_normal
    String  sampleId_tumor
    File    dnanexusmetrics_normal
    File    dnanexusmetrics_tumor
    File    cromwellmetrics_normal
    File    cromwellmetrics_tumor
    String  dockerImage
        
            
    command {
    	(echo "WES TRIMMING COMPARISON REPORT FOR NORMAL:${sampleId_normal}";\
        echo "--------------------------------------------------------------";\
        echo "DNANEXUS                                                                     CROMWELL";\
        echo "--------                                                                     ---------";\
        diff -y --suppress-common-lines <(sed "1d" ${dnanexusmetrics_normal}) <(sed "1d" ${cromwellmetrics_normal});\
	echo;\
	echo "WES TRIMMING COMPARISON REPORT FOR TUMOR:${sampleId_tumor}";\
        echo "-------------------------------------------------------------";\
        echo "DNANEXUS                                                                     CROMWELL";\
        echo "--------                                                                     ---------";\
        diff -y --suppress-common-lines <(sed "1d" ${dnanexusmetrics_tumor}) <(sed "1d" ${cromwellmetrics_tumor})) > ${sampleId_normal}_${sampleId_tumor}.wes.trimcompare.txt
    }   

	runtime {
    	   docker: '${dockerImage}'
	       
    }
    output {
    	File trimcompare = "${sampleId_normal}_${sampleId_tumor}.wes.trimcompare.txt"
    }
}
#-----------------------------------------------------------------------------
# TASK: WES BAM HS METRICS COMPARE FOR NORMAL AND TUMOR SAMPLES
# python3 ${bamcompareCmd} ${nexusbamhsnormal} ${crombamhsnormal} > ${sampleId_normal}_${sampleId_tumor}.wes.bamcompare.txt
#-----------------------------------------------------------------------------

task bamcompare {
    String  sampleId_normal
    String  sampleId_tumor
    String  dockerImage
    String  bamcompareCmd
    File  nexusbamhsnormal
    File  crombamhsnormal
    
            
    command {
 	(echo "WES BAM HS METRICS COMPARISON REPORT FOR NORMAL:${sampleId_normal}";\
        echo "-------------------------------------------------------------------";\
    	${bamcompareCmd} ${nexusbamhsnormal} ${crombamhsnormal}) > ${sampleId_normal}_${sampleId_tumor}.wes.bamcompare.txt
    							
    }   

    runtime {
    	   docker: '${dockerImage}'
	       
    }
    output {
    	File bamcompare = "${sampleId_normal}_${sampleId_tumor}.wes.bamcompare.txt"
    }
}
