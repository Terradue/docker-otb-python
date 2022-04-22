# Orfeo ToolBox (OTB) docker container

## Get the docker 

```console
docker pull terradue/otb-8.0.0
```

Run a container: 

```console
docker run --rm -it terradue/otb-8.0.0:latest bash
```

## Run

Bash console

```console
docker run --rm -it otb-8.0.0:latest bash
```

OTB cli applications are available in PATH.

Python 

```console
docker run --rm -it otb-8.0.0:latest bash
```

then

```console
python
```

```python
import otbApplication
from osgeo import gdal
```

## Extend the conda environment

```console 
micromamba install -n env_otb <some package> -c <channel>
```

## Build

Clone this repo and: 

```console
docker build -f .docker/Dockerfile -t otb-8.0.0
```