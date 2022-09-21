# MiXCR-Pipeline
### MiXCR analysis pipeline for obtaining TCR sequence information from paired-end, bulk RNA-seq FASTQs. 

For detailed overview, take a look at [MiXCR_pipeline_overview.ipynb](https://github.com/jmakings/MiXCR-Pipeline/blob/main/MiXCR_pipeline_overview.ipynb) which contains each bash script and a description of how they work.

MiXCR is a universal framework that derives quantitated BCR and TCR clonotype information from raw DNA and RNA sequences. Here, it is used to derive TCR clonotype information from bulk RNA-seq data.

This is carried out across a few steps, each of which contains its own bash script: 
1. *Concatenation*: Creating merged read 1 and read 2 fastqs for each sample, by concatenating across lanes[concat_split_lanes.sh]()
