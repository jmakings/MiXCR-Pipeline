# MiXCR-Pipeline
### MiXCR analysis pipeline for obtaining TCR sequence information from paired-end, bulk RNA-seq FASTQs. 

For detailed overview, take a look at [MiXCR_pipeline_overview.ipynb](https://github.com/jmakings/MiXCR-Pipeline/blob/main/MiXCR_pipeline_overview.ipynb) which contains each bash script and a description of how they work.

MiXCR is a universal framework that derives quantitated BCR and TCR clonotype information from raw DNA and RNA sequences. Here, it is used to derive TCR clonotype information from bulk RNA-seq data.

This is carried out across a few steps, each of which contains its own bash script: 
1. **Concatenation**: 
Creating merged read 1 and read 2 fastqs for each sample, by concatenating across lanes. Script: [concat_split_lanes.sh](https://github.com/jmakings/MiXCR-Pipeline/blob/main/concat_split_lanes.sh)
2. **MiXCR Run**: 
Aligns, assembles, extends, and exports clonotypes to tsv files. Script: [mixcr_analyze_concat.sh](https://github.com/jmakings/MiXCR-Pipeline/blob/main/mixcr_analyze_concat.sh)
3. **Extract additional information**:
Pull extra data from .clns files, including CDR3 length and V,D,J sequences. Script: [extract_from_clones.sh](https://github.com/jmakings/MiXCR-Pipeline/blob/main/extract_from_clones.sh)
4. **Postanalysis *(Not used currently)***:
Current diversity statistics do not work due to bugs in MiXCR software. Script: [mixcr_postanalysis](https://github.com/jmakings/MiXCR-Pipeline/blob/main/mixcr_postanalysis.sh)

