"""File finder service, to find the project root."""

from lady_penelope.helpers import file_finder_service


def test_find_file_upwards_might_not_be_found() -> None:
    """Test that None is returned if a file is not found."""
    # ARRANGE
    file_finder = file_finder_service.FileFinderService()
    # ACT
    # Potentially this file could be present.
    file_finder.find_file_upwards("pyproject.tomlc")
    # ASSERT
    assert file_finder is not None


def test_find_file_upwards_definitely_not_found() -> None:
    """Test that the file finder service does not find the file."""
    # ARRANGE
    # Ensure that the file can never be found.
    file_finder = file_finder_service.FileFinderService(isfile=lambda path: False)
    # ACT
    the_path = file_finder.find_file_upwards(filename="non_existent_file.txt")
    # ASSERT
    assert the_path is None


def test_find_file_upwards_in_current_directory() -> None:
    """Confirm that finder service finds a file upwards."""
    # ARRANGE
    # Ensure that the file is found immediately and you don't actually look upwards.
    file_finder = file_finder_service.FileFinderService(
        isfile=lambda path: True, abspath=lambda path: "/home/user/project"
    )
    # ACT
    the_path = file_finder.find_file_upwards(filename="setting.json")
    # ASSERT
    assert the_path == "/home/user/project/setting.json"


def test_file_found_in_a_parent_directory() -> None:
    """Test that the file finder service finds the file in a parent directory."""

    # ARRANGE
    def mock_isfile(path):
        """Find the file in a parent directory when you have gone up two levels."""
        return path == "/home/user/setting.json"

    # ACT
    file_finder = file_finder_service.FileFinderService(
        isfile=mock_isfile, abspath=lambda path: path
    )
    result = file_finder.find_file_upwards(
        filename="setting.json", start_directory="/home/user/documents/projects"
    )
    # ASSERT
    assert result == "/home/user/setting.json"


def test_find_root_found() -> None:
    """Confirm that the root of the project can be found."""
    # ARRANGE
    # Ensure the root project file will be found.
    file_finder = file_finder_service.FileFinderService(
        isfile=lambda path: True, abspath=lambda path: "/somewhere/on/the/file/system"
    )
    # ACT
    the_root = file_finder.find_root()
    # ASSERT
    assert the_root == "/somewhere/on/the/file/system"
