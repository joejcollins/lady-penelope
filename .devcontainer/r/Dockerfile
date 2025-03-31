# Get a Rocker image with LaTeX already installed.
FROM ghcr.io/rocker-org/devcontainer/geospatial:4.4

# # Install extra LaTeX packages (you can't use tlmgr because the repos are too old).
# RUN apt-get --quiet update \
#  && apt-get install --assume-yes texlive-latex-extra texlive-extra-utils latexmk \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/*

# # Add a few LaTeX packages that aren't already installed.
# # The user is rstudio because they are to be used in Rstudio.
# USER rstudio
# RUN tlmgr update --self
# RUN tlmgr install isodate beamer substr babel-english sectsty float
# # For convenience open up the permissions on the TexLive directory
# RUN sudo chmod -R 777 /usr/local/texlive

# Add some labels so it looks nice in Github packages.
LABEL org.opencontainers.image.source=https://github.com/joejcollins/lady-penelope-r/
LABEL org.opencontainers.image.description="lady-penelope-r container."
