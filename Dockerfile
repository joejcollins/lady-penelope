# Get a Rocker image with LaTeX already installed.
FROM rocker/verse:4.3.2

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
