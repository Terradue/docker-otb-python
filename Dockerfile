FROM mambaorg/micromamba

USER root

ENV PYTHON_PREFIX=/opt/conda/envs/env_otb
    
ENV PATH=$PYTHON_PREFIX/bin:$PATH

RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libxcb1 \
        libxcb-composite0 \
        libxcb-glx0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render0 \
        libxcb-render-util0 \
        libxcb-util1 \
        libxcb-shm0 \
        libxcb-xfixes0 \
        libxcb-xinerama0 \
        libxcb-xinput0 \
        libxcb-xkb1 \
        libxcb-shape0 \
        libx11-xcb1 \
        libglu1-mesa \
        libxrender1 \
        libxi6 \
        libxkbcommon0 \
        libxkbcommon-x11-0 \
        libxinerama1 

USER mambauser


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

USER mambauser
