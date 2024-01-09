"""
any misc funtion can be used in project placed here
"""
import yaml


def yaml_coerce(value):
    """
    returns a python object (just creating quick yaml data using string)
    convert string dict like "{'apple': 20, 'bananas': 12}" into python dict
    sometimes we need to stringyfy some settings like in Docker files
    """
    if isinstance(value, str):

        return yaml.load(f'dummy: {value}', Loader=yaml.SafeLoader)['dummy']
    return value
