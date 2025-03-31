"""File finder service."""

import glob
from os import path
from typing import Any


class FileFinderService:
    """Find a file upwards from a starting directory."""

    def __init__(self, isfile=path.isfile, abspath=path.abspath, glob=glob.glob):
        """Initialise the file finder service.

        Use dependency injection so that we can pass in mock items for testing.  Under
        normal use the default "normal" values are used.
        """
        self.isfile = isfile
        self.abspath = abspath
        self.glob = glob

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
        """Find the root of the project.

        Assuming that the pyproject.toml is in the root of the application.
        """
        pyproject_toml = self.find_file_upwards("pyproject.toml", start_directory)
        return path.dirname(pyproject_toml) if pyproject_toml else None
