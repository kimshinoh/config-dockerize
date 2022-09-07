FROM  python:3.8-slim-bullseye

WORKDIR /app/

# Install Poetry
# RUN apt-get update && apt-get upgrade && apt-get install curl -y && \
#     curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | POETRY_HOME=/opt/poetry python && \
#     cd /usr/local/bin && \
#     ln -s /opt/poetry/bin/poetry && \
#     poetry config virtualenvs.create false

ENV POETRY_VERSION=1.1.13
RUN python3 -m pip install poetry==$POETRY_VERSION

# WORKDIR /my_app

COPY ./app/pyproject.toml ./app/poetry.lock* /app/
RUN poetry config virtualenvs.in-project true --local
RUN poetry install --no-dev

COPY . .
CMD [ "poetry", "run", "python", "-c", "print('hello world')" ]


RUN apt-get update && \
    apt-get install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common -y && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt-get update && \
    apt-get install adoptopenjdk-8-hotspot -y

# Copy poetry.lock* in case it doesn't exist in the repo
# COPY ./app/pyproject.toml ./app/poetry.lock* /app/

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=false
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi"

# For development, Jupyter remote kernel, Hydrogen
# Using inside the container:
# jupyter lab --ip=0.0.0.0 --allow-root --NotebookApp.custom_display_url=http://127.0.0.1:8888
ARG INSTALL_JUPYTER=false
RUN python -m pip install --upgrade pip
RUN bash -c "if [ $INSTALL_JUPYTER == 'true' ] ; then pip install jupyterlab ; fi"
RUN bash -c "if [ $INSTALL_JUPYTER == 'true' ] ; then pip install jedi==0.17.2 ; fi"

COPY ./app /app
ENV PYTHONPATH=/app
ENV CLASSPATH=/app/app/java:/app/app/java/jt400.jar
ENV JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
ENV TZ=Europe/Oslo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

#CMD ["/start.sh"]

