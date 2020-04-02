ARG JUPYTER_IMAGE=jupyter/minimal-notebook
FROM $JUPYTER_IMAGE
#FROM jupyter/minimal-notebook

USER root
RUN apt-get install  -y build-essential gcc

USER jovyan


# Add permanent pip/conda installs, data files, other user libs here
# e.g., RUN pip install jupyter_dashboards
COPY requirements.txt /tmp/
RUN ls /tmp
RUN pip install -U pip
RUN pip install -r /tmp/requirements.txt 

USER root

# Add permanent apt-get installs and other root commands here
# e.g., RUN apt-get install npm nodejs
