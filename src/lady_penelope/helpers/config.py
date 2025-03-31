"""Configuration file for the project.

This file defines various paths and settings used throughout the project.
It also initializes logging and handles optional integration with tqdm.
"""

import contextlib
from pathlib import Path

from dotenv import load_dotenv
from loguru import logger

from lady_penelope.helpers import file_finder_service

# Load environment variables from .env file if it exists
load_dotenv()

# Paths
PROJ_ROOT = Path(file_finder_service.FileFinderService().find_root())
logger.info(f"PROJ_ROOT path is: {PROJ_ROOT}")

DATA_DIR = PROJ_ROOT / "data"
RAW_DATA_DIR = DATA_DIR / "raw"
INTERIM_DATA_DIR = DATA_DIR / "interim"
PROCESSED_DATA_DIR = DATA_DIR / "processed"
EXTERNAL_DATA_DIR = DATA_DIR / "external"

MODELS_DIR = PROJ_ROOT / "models"

REPORTS_DIR = PROJ_ROOT / "reports"
FIGURES_DIR = REPORTS_DIR / "figures"

# If tqdm is installed, configure loguru with tqdm.write
# https://github.com/Delgan/loguru/issues/135
with contextlib.suppress(ModuleNotFoundError):
    from tqdm import tqdm

    logger.remove(0)
    logger.add(lambda msg: tqdm.write(msg, end=""), colorize=True)
