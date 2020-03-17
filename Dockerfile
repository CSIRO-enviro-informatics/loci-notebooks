# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# Pick your favorite docker-stacks image
FROM jupyter/minimal-notebook:2d125a7161b5

USER jovyan


# Add permanent pip/conda installs, data files, other user libs here
# e.g., RUN pip install jupyter_dashboards
COPY requirements.txt /tmp/
RUN ls /tmp
RUN pip install -r /tmp/requirements.txt 

USER root

# Add permanent apt-get installs and other root commands here
# e.g., RUN apt-get install npm nodejs
