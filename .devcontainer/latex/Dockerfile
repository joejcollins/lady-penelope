# Sourcery won't run on `arm` so force the use of `amd64` for the base image.
FROM mcr.microsoft.com/devcontainers/base:bookworm

# Install LaTeX.
RUN apt-get --quiet update \
 && apt-get install --assume-yes texlive-latex-extra texlive-extra-utils latexmk \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Add some labels so it looks nice in Github packages.
LABEL org.opencontainers.image.source=https://github.com/joejcollins/lady-penelope-latex/
LABEL org.opencontainers.image.description="lady-penelope-latex container."
