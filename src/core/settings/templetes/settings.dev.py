DEBUG = True
SECRET_KEY = 'skjndckjsdcksc=-0-30923ksckcksc'

LOGGING['formatters']['colored'] = {  # noqa: F821
    '()': 'colorlog.ColoredFormatter',
    'format': '%(log_color)s%(asctime)s %(levelname)s %(name)s %(bold_white)s%(message)s',
}
LOGGING['loggers']['core']['level'] = 'DEBUG'  # noqa: F821
LOGGING['handlers']['console']['level'] = 'DEBUG'  # noqa: F821
LOGGING['handlers']['console']['formatter'] = 'colored'  # noqa: F821
