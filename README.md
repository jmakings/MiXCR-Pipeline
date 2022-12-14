# MiXCR-Pipeline
### MiXCR analysis pipeline for obtaining TCR sequence information from paired-end, bulk RNA-seq FASTQs. 

For detailed overview, take a look at [MiXCR_pipeline_overview.ipynb](https://github.com/jmakings/MiXCR-Pipeline/blob/main/MiXCR_pipeline_overview.ipynb) which contains each bash script and a description of how they work.

MiXCR is a universal framework that derives quantitated BCR and TCR clonotype information from raw DNA and RNA sequences. Here, it is used to derive TCR clonotype information from bulk RNA-seq data.

This is carried out across a few steps, each of which contains its own bash script: 
1. **Concatenation**: <br>Creating merged read 1 and read 2 fastqs for each sample, by concatenating across lanes. 
<br>Script: [concat_split_lanes.sh](https://github.com/jmakings/MiXCR-Pipeline/blob/main/concat_split_lanes.sh)
2. **MiXCR Run**: <br>Aligns, assembles, extends, and exports clonotypes to tsv files. 
<br>Script: [mixcr_analyze_concat.sh](https://github.com/jmakings/MiXCR-Pipeline/blob/main/mixcr_analyze_concat.sh)
3. **Extract additional information**: <br>Pull extra data from .clns files, including CDR3 length and V,D,J sequences. 
<br>Script: [extract_from_clones.sh](https://github.com/jmakings/MiXCR-Pipeline/blob/main/extract_from_clones.sh)
4. **Postanalysis *(Not used currently)***: <br>Current diversity statistics do not work due to bugs in MiXCR software. 
<br>Script: [mixcr_postanalysis](https://github.com/jmakings/MiXCR-Pipeline/blob/main/mixcr_postanalysis.sh)

For more information on MiXCR: 
<br>[MiXCR Nature Methods Paper](https://www.nature.com/articles/nmeth.3364)
<br>[MiXCR Documentation](https://docs.milaboratories.com/mixcr/reference/mixcr-analyze/)
