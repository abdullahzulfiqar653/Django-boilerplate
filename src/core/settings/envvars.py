from src.base.utils.collections import deep_update
from src.base.utils.settings import get_settings_from_environment

"""
This script captures environment variables with a specified prefix,
removes the prefix, and incorporates them into global variables.

For example:
If you export an environment variable like "PROJECT_NAME_DEBUG=true",

You can then refer to it globally as DEBUG, where the value would be True.
"""

deep_update(globals(), get_settings_from_environment(ENV_VARIABLE_PREFIX)) # type: ignore
