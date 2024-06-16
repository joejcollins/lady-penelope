"""Global configuration file for the project."""

import pydantic


class AquaMarinaSettings(pydantic.BaseModel):


    @property
    def path_to_root(self) -> str:
        """Return the path to the app."""
        return f"{self.home_directory}/zengentiansible/"

    @property
    def path_to_raw


AQUA_MARINA = AquaMarinaSettings()
