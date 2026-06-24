#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// ── Parameters ──────────────────────────────────────────────────────────────
params.input_dir   = "./fastq"         // directory of raw FASTQs
params.file_type   = "fastq.gz"        // fastq or fastq.gz
params.species     = "hsa"             // MiXCR species code
params.outdir      = "./results"

// ── Helper: detect sample names from R1 files ───────────────────────────────
// Expects Illumina naming: SampleName_S1_L001_R1_001.fastq.gz
Channel
    .fromFilePairs("${params.input_dir}/*_L00{1,2,3,4}_R{1,2}_001.${params.file_type}",
                   flat: true)
    .map { sample_id, r1s, r2s -> tuple(sample_id, r1s, r2s) }
    .set { raw_reads_ch }

// ── Process 1: Concatenate lanes ────────────────────────────────────────────
process CONCAT_LANES {
    tag "$sample_id"
    publishDir "${params.outdir}/merged", mode: 'copy'

    input:
    tuple val(sample_id), path(r1_files), path(r2_files)

    output:
    tuple val(sample_id), path("${sample_id}_ME_R1_001.${params.file_type}"),
                          path("${sample_id}_ME_R2_001.${params.file_type}")

    script:
    """
    cat ${r1_files} > ${sample_id}_ME_R1_001.${params.file_type}
    cat ${r2_files} > ${sample_id}_ME_R2_001.${params.file_type}
    """
}

// ── Process 2: MiXCR analyze shotgun ────────────────────────────────────────
process MIXCR_ANALYZE {
    tag "$sample_id"
    publishDir "${params.outdir}/mixcr", mode: 'copy'

    input:
    tuple val(sample_id), path(r1), path(r2)

    output:
    tuple val(sample_id), path("${sample_id}.clns"),   emit: clns
    path "${sample_id}_report.txt",                     emit: reports
    path "${sample_id}.*.tsv",                          emit: tsv

    script:
    """
    mixcr analyze shotgun \\
        -s ${params.species} \\
        --starting-material rna \\
        --report ${sample_id}_report.txt \\
        --receptor-type tcr \\
        ${r1} ${r2} ${sample_id}
    """
}

// ── Process 3: Export clonotypes ─────────────────────────────────────────────
process EXPORT_CLONES {
    tag "$sample_id"
    publishDir "${params.outdir}/clonotypes", mode: 'copy'

    input:
    tuple val(sample_id), path(clns)

    output:
    tuple val(sample_id), path("${sample_id}_TRB_full.tsv"),
                          path("${sample_id}_TRAD_full.tsv")

    script:
    """
    mixcr exportClones \\
        --chains TRB -p full \\
        -lengthOf CDR3 \\
        -nFeature VCDR3Part -nFeature VDJunction -nFeature DCDR3Part \\
        -nFeature DJJunction -nFeature JCDR3Part -nFeature VJJunction \\
        -avrgFeatureQuality CDR3 \\
        -vHit -vGene -vHitScore -dHit -dGene -dHitScore \\
        -jHit -jGene -jHitScore -cHit -cGene -cHitScore \\
        ${clns} ${sample_id}_TRB_full.tsv

    mixcr exportClones \\
        --chains TRAD -p full \\
        -lengthOf CDR3 \\
        -nFeature VCDR3Part -nFeature VDJunction -nFeature DCDR3Part \\
        -nFeature DJJunction -nFeature JCDR3Part -nFeature VJJunction \\
        -avrgFeatureQuality CDR3 \\
        -vHit -vGene -vHitScore -dHit -dGene -dHitScore \\
        -jHit -jGene -jHitScore -cHit -cGene -cHitScore \\
        ${clns} ${sample_id}_TRAD_full.tsv
    """
}

// ── Workflow ─────────────────────────────────────────────────────────────────
workflow {
    CONCAT_LANES(raw_reads_ch)
    MIXCR_ANALYZE(CONCAT_LANES.out)
    EXPORT_CLONES(MIXCR_ANALYZE.out.clns)
}


/// To Do: Download Datasets into raw