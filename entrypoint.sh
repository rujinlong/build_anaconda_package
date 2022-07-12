#!/bin/bash

set -ex

export ANACONDA_API_TOKEN=$INPUT_ANACONDATOKEN

if [[ "$INPUT_CONDADIR" == "" ]]; then
    echo "-------------- Run skeleton ------------"
    mamba skeleton pypi --output-dir . $INPUT_PYPIPKGNAME
    conda mambabuild -c rujinlong -c rdkit -c bioconda -c conda-forge -c r -c defaults --output-folder . $INPUT_PYPIPKGNAME
else
    echo "-------------- Run local build --------------"
    conda mambabuild -c rujinlong -c rdkit -c bioconda -c conda-forge -c r -c defaults --output-folder . $INPUT_CONDADIR
fi

conda convert -f --platform all -o . linux-64/*.tar.bz2
anaconda upload --force --label main **/*.tar.bz2
