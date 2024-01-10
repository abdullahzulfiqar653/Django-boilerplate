import os
from pathlib import Path

from split_settings.tools import include, optional

BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent

ENV_VARIABLE_PREFIX = 'BOILERPLATE_'
LOCAL_SETTINGS_PATH = os.getenv(f'{ENV_VARIABLE_PREFIX}LOCAL_SETTINGS_PATH')

if not LOCAL_SETTINGS_PATH:
    LOCAL_SETTINGS_PATH = 'local/settings.dev.py'

if not os.path.isabs(LOCAL_SETTINGS_PATH):
    # BASE_DIR is type of "<class 'pathlib.PosixPath'>" so "/" overloaded for path objects
    LOCAL_SETTINGS_PATH = str(BASE_DIR / LOCAL_SETTINGS_PATH)

include('base.py', 'custom.py', optional(LOCAL_SETTINGS_PATH), 'envvars.py', 'docker.py')
