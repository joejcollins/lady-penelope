# Get a Rocker image with LaTeX already installed.
FROM ghcr.io/rocker-org/devcontainer/geospatial:4.4

# Build the Python virtual environment and R library so they are available to all users.
RUN apt-get --quiet update
RUN sudo apt-get install --assume-yes python3.10-venv lsof

# Build some assets for the rstudio user so they are available for testing.
USER rstudio
WORKDIR /app
RUN mkdir -p /app/.R/library
COPY pyproject.toml requirements.txt setup.R Makefile /app/
RUN make venv

# Add a few LaTeX packages that aren't already installed.
# The user is rstudio because they are to be used in Rstudio.
USER rstudio
RUN tlmgr update --self
RUN tlmgr install isodate beamer substr babel-english sectsty float
# For convenience open up the permissions on the TexLive directory
RUN sudo chmod -R 777 /usr/local/texlive
