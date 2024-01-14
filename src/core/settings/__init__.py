import os
import environ
from pathlib import Path
from split_settings.tools import include, optional

BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent
environ.Env.read_env(os.path.join(BASE_DIR, '.env'))

env = environ.Env(
    # set casting, default value
    DEBUG=(bool, False),
    ALLOWED_HOSTS=(list, []),
    CSRF_TRUSTED_ORIGINS=(list, []),
    CORS_ALLOW_ALL_ORIGINS=(bool, True),
)

ENV_VARIABLE_PREFIX = f'{os.environ.get("PROJECT_NAME").upper()}_'
LOCAL_SETTINGS_PATH = os.getenv(f'{ENV_VARIABLE_PREFIX}LOCAL_SETTINGS_PATH')

if not LOCAL_SETTINGS_PATH:
    LOCAL_SETTINGS_PATH = 'local/settings.dev.py'

if not os.path.isabs(LOCAL_SETTINGS_PATH):
    # BASE_DIR is type of "<class 'pathlib.PosixPath'>" so "/" overloaded for path objects
    LOCAL_SETTINGS_PATH = str(BASE_DIR / LOCAL_SETTINGS_PATH)

include('base.py', 'logging.py', 'custom.py', optional(LOCAL_SETTINGS_PATH), 'envvars.py', 'docker.py')
