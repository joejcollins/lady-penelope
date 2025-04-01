# Get a Rocker image with LaTeX already installed.
FROM ghcr.io/rocker-org/devcontainer/geospatial:4.4

# Install uv for everyone not just the current user.
RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
 && cp /root/.local/bin/uv /usr/local/bin/uv

# Add some labels so it looks nice in Github packages.
LABEL org.opencontainers.image.source=https://github.com/joejcollins/lady-penelope/
LABEL org.opencontainers.image.description="lady-penelope container."
