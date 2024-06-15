# Get a Rocker image with LaTeX already installed.
FROM ghcr.io/rocker-org/devcontainer/geospatial:4.4

# Disable RStudio Server authentication
RUN echo "server-user=rstudio" >> /etc/rstudio/rserver.conf  \
 && echo "auth-none=1" >> /etc/rstudio/rserver.conf

# Build the Python virtual environment and R library so they are available for other users.
RUN apt-get --quiet update
RUN sudo apt-get install --assume-yes python3.10-venv lsof
WORKDIR /app
RUN mkdir -p /app/.R/library
COPY pyproject.toml requirements.txt Makefile /app/
RUN make venv

# Add a few LaTeX packages that aren't already installed.
## User is rstudio because they are to be used in Rstudio.
USER rstudio
RUN tlmgr update --self
RUN tlmgr install isodate beamer substr babel-english sectsty float
