ARG JUPYTER_IMAGE=jupyter/minimal-notebook
FROM $JUPYTER_IMAGE
#FROM jupyter/minimal-notebook



USER root
RUN apt-get install -y build-essential gcc
RUN apt-get update
RUN apt-get install -y  libpq-dev python-dev

USER jovyan


# Add permanent pip/conda installs, data files, other user libs here
# e.g., RUN pip install jupyter_dashboards
COPY requirements.txt /tmp/
RUN ls /tmp
RUN pip install -U pip
RUN pip install -r /tmp/requirements.txt 

# Add notebooks to the docker image
COPY *.ipynb /home/jovyan/
COPY *.csv /home/jovyan/
COPY env-template /home/jovyan/.env


RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user



USER root

# Add permanent apt-get installs and other root commands here
# e.g., RUN apt-get install npm nodejs
RUN  apt-get install -y graphviz


# name your environment and choose python 3.x version
ARG conda_env=python36
ARG py_ver=3.6

# you can add additional libraries you want conda to install by listing them below the first line and ending with "&& \"
RUN conda create --quiet --yes -p $CONDA_DIR/envs/$conda_env python=$py_ver ipython ipykernel && \
    conda clean --all -f -y

# alternatively, you can comment out the lines above and uncomment those below
# if you'd prefer to use a YAML file present in the docker build context

# COPY --chown=${NB_UID}:${NB_GID} environment.yml /home/$NB_USER/tmp/
# RUN cd /home/$NB_USER/tmp/ && \
#     conda env create -p $CONDA_DIR/envs/$conda_env -f environment.yml && \
#     conda clean --all -f -y


# create Python 3.x environment and link it to jupyter
RUN $CONDA_DIR/envs/${conda_env}/bin/python -m ipykernel install --user --name=${conda_env} && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# any additional pip installs can be added by uncommenting the following line
#RUN $CONDA_DIR/envs/${conda_env}/bin/pip install
COPY requirements.txt /tmp/
RUN ls /tmp
RUN $CONDA_DIR/envs/${conda_env}/bin/pip install -r /tmp/requirements.txt 

# prepend conda environment to path
ENV PATH $CONDA_DIR/envs/${conda_env}/bin:$PATH

# if you want this environment to be the default one, uncomment the following line:
ENV CONDA_DEFAULT_ENV ${conda_env}
