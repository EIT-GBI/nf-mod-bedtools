process BEDTOOLS_BIGWIG {
    tag "${meta.id}"

    publishDir "${params.outdir}/bigwig", mode: 'link'
 
    input:
    tuple val(meta), path(bam), path(bai)
    tuple path(fasta), path(fai)

    output:
    tuple val(meta), path("${meta.id}.bw"), emit: bigwig

    script:
    """
    set -euo pipefail
    cut -f1,2 ${fai} > chrom_sizes
    bedtools genomecov -ibam ${bam} -bg | sort -k1,1 -k2,2n > coverage.bg
    if [ -s coverage.bg ]; then
        bedGraphToBigWig coverage.bg chrom_sizes ${meta.id}.bw
    else
        echo "No coverage records for ${meta.id} — skipping bigwig"
    fi
    """

    stub:
    """
    touch ${meta.id}.bw
    """
}
