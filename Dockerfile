FROM mambaorg/micromamba:1.5.8

USER root

# ucsc-bedgraphtobigwig is pinned to 482 rather than 445: bioconda has no
# linux-aarch64 build for 445, so the arm64 leg of the multi-arch build could
# never solve its environment. aarch64 support starts at 455.
RUN micromamba install -y -n base -c bioconda -c conda-forge \
        procps-ng \
        bedtools=2.31.1 \
        ucsc-bedgraphtobigwig=482 \
    && micromamba clean --all --yes

ENV PATH=/opt/conda/bin:$PATH

CMD ["bedGraphToBigWig"]
