"""File finder service."""

from os import path
from typing import Any


def find_training_image(image_name: str) -> str:
    """Find the training image."""
    file_finder = FileFinderService()
    root = file_finder.find_root()
    return path.join(root, "data/raw/training", image_name)


class FileFinderService:
    """Find a file upwards from a starting directory."""

    def __init__(self, isfile=path.isfile, abspath=path.abspath):
        """Initialise the file finder service, so items can be mocked for testing."""
        self.isfile = isfile  # so we can confirm if a file exists.
        self.abspath = (
            # so we can get the complete path to where we are to begin with.
            abspath
        )

    def find_file_upwards(self, filename: str, start_directory: str = ".") -> Any:
        """Find a file upwards from a starting directory."""
        current_directory = self.abspath(start_directory)
        while (
            True
        ):  # keep looping until we find the file or reach the root of the filesystem.
            potential_path = path.join(current_directory, filename)
            if self.isfile(potential_path):  # you found the file.
                return potential_path
            # move up a directory.
            parent_directory = path.dirname(current_directory)
            if current_directory == parent_directory:
                # you reached the root of the filesystem without finding.
                return None
            # move up a directory and try again.
            current_directory = parent_directory

    def find_root(self, start_directory: str = ".") -> Any:
        """Find the root of the project."""
        pyproject_toml = self.find_file_upwards("pyproject.toml", start_directory)
        return path.dirname(pyproject_toml) if pyproject_toml else None

    def find_files_glob(self, pattern: str, start_directory: str = ".") -> Any:
        """Find files matching a pattern."""