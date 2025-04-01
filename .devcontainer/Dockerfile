# Get a Rocker image (without LaTeX).
FROM ghcr.io/rocker-org/devcontainer/tidyverse:4.4

# Install LaTeX because it is not included in the Rocker image.
RUN apt-get --quiet update \
    && apt-get install --assume-yes texlive-latex-extra texlive-extra-utils latexmk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Precache the R packages to improve start up times.
WORKDIR /app
COPY renv.lock ./
RUN R -e "install.packages('renv')" \
    && R -e "renv::restore()"

# Install uv for everyone not just the current user.
RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && cp /root/.local/bin/uv /usr/local/bin/uv
COPY pyproject.toml requirements.txt Makefile ./
RUN make venv

# Add some labels so it looks nice in Github packages.
LABEL org.opencontainers.image.source=https://github.com/joejcollins/lady-penelope/
LABEL org.opencontainers.image.description="lady-penelope container."
