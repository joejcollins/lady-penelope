"""Configuration file for the Sphinx documentation builder."""

# sourcery skip: avoid-global-variables
import os
import sys

sys.path.insert(0, os.path.abspath("./"))

# Project information
project = "lady-penelope"
copyright = "2024, Joe J Collins"
author = "Joe J Collins"
release = "1"

# General configuration, the order of which is important (strangely).
extensions = [
    "myst_parser",  # So we can use markdown instead of reStructuredText.
    "autodoc2",  # automatic static analysis of the code for the API documentation.
    "sphinxcontrib.mermaid",  # so we can embed mermaid diagrams.
]

# Options for MyST
# https://myst-parser.readthedocs.io/en/latest/configuration.html
myst_enable_extensions = [
    "deflist",
    "fieldlist",
    "linkify",
    "replacements",
    "smartquotes",
    "tasklist",
]
myst_fence_as_directive = [
    # MyST usually uses the syntax ```{mermaid} to have a directive.
    # This will allow you to write ```mermaid which will render in
    # GitHub.
    "mermaid",
]

# Options for autodoc2
# https://sphinx-autodoc2.readthedocs.io/en/latest/config.html
autodoc2_output_dir = "api"
autodoc2_packages = [
    "../python_src",
]
autodoc2_render_plugin = "myst"


html_static_path = ["_static"]
html_theme = "sphinx_rtd_theme"
html_sidebars = {
    "**": [
        "globaltoc.html",  # Main table of contents
        "sourcelink.html",  # Source link to GitHub
        "searchbox.html",  # Search box
    ]
}


def setup(app):
    """Set up so that we can add custom features."""
    app.add_css_file("custom.css")
