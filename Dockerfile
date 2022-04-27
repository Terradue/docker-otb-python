FROM mambaorg/micromamba

USER root

ENV PYTHON_PREFIX=/opt/conda/envs/env_otb
    
ENV PATH=$PYTHON_PREFIX/bin:$PATH

ADD environment.yml /tmp/environment.yml

RUN micromamba create -f /tmp/environment.yml -c terradue -c conda-forge && \
    micromamba clean -a

ENV CMAKE_PREFIX_PATH=${PYTHON_PREFIX}/conda-otb \
    PYTHONPATH=${PYTHON_PREFIX}/conda-otb/lib/python \
    GDAL_DATA=${PYTHON_PREFIX}/conda-otb/share/gdal \
    PROJ_LIB=${PYTHON_PREFIX}/conda-otb/share/proj \
    LC_NUMERIC=C \
    OTB_APPLICATION_PATH=${PYTHON_PREFIX}/conda-otb/lib/otb/applications \
    LD_LIBRARY_PATH=${PYTHON_PREFIX}/conda-otb/lib \
    PATH=${PYTHON_PREFIX}/conda-otb/bin:$PATH

WORKDIR /tmp
