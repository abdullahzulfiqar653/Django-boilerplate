import os

from .misc import yaml_coerce


def get_settings_from_environment(prefix):
    """
    function iter over all environment variables and return a python
    dict of project specific environment variables.
    """
    return {
        key[len(prefix):]: yaml_coerce(value)
        for key, value in os.environ.items() if key.startswith(prefix)
    }
