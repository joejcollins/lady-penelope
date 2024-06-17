# Python and R Data Analysis Template

Based on:

* <https://github.com/jakubnowicki/r-codespaces>.
* <https://stackoverflow.com/questions/78209916/install-tinytex-into-rstudio-docker>.
* <https://github.com/revodavid/devcontainers-rstudio>.
* <https://rocker-project.org/images/devcontainer/features.html>.

## To Do

- [ ] Test data files, 2 files, 1 observation in one and 2 in the other.
- [ ] Test images, 6 images for the 3 observations.
- [ ] def raw_observation_file_finder(start_path: str) -> List[str]:
  - [ ] test to find files in the data directory.
- [ ] class RawObservationFileReader:
  - [ ] def __init__(self, file: file):
    - [ ] takes a file not a path to the file.
  - [ ] def __next__(self) -> str:
    - [ ] returns next observation up to end of species list.
- [ ] class Observation(pydantic.BaseModel):
  - [ ] validates fields
  - [ ] def csv_headers(self) -> str:
  - [ ] def to_csv(self) -> str:
- [ ] def parse_raw_observation(raw_observation: str) -> dict:
  - [ ] return a dict with the fields of the observation ready fo Pydantic.
