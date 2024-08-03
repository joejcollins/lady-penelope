# Stage 1: Base image
#####################
# Get a Rocker image with LaTeX already installed.
FROM ghcr.io/rocker-org/devcontainer/geospatial:4.4 AS base

# Build the Python virtual environment and R library so they are available to all users.
RUN apt-get --quiet update
RUN sudo apt-get install --assume-yes python3.10-venv lsof

# Build some assets for the rstudio user so they are available for testing.
USER rstudio

# This is where the production app will be run from and where the virtual environment
# will be prebuilt for use in testing.
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

# Add some labels so it looks nice in Github packages.
LABEL org.opencontainers.image.source=https://github.com/joejcollins/lady-penelope/

# Stage 2a: Development and test image
######################################
# Includes a prebuild virtual environment with all the developer dependencies, but no
# source files, so is only rebuilt when the requirements.dev.txt or Dockerfile change.
# The prebuilt virtual environment is used to speed up testing so we don't have to wait
# for the dependencies to install before the tests can be run.
FROM base AS development

LABEL org.opencontainers.image.description="lady-penelope development container."

# Copy only the necessary files and prebuild the virtual environment.
COPY Makefile pyproject.toml requirements.dev.txt ./
RUN make venv-dev

# Stage 2b: Production image
############################
# Include a prebuilt virtual environment with only the production dependencies and all
# the source files.  This will be used to run the app in production.
FROM base AS production

LABEL org.opencontainers.image.description="lady-penelope production container."

# Copy everything and build the virtual environment without the dev dependencies.
COPY . .
RUN make venv-prod
