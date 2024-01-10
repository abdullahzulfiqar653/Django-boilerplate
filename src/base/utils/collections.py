"""
any function related to collection will be placed in this module.
"""


def deep_update(base_dict, update_with):
    """
    function will do a deep update, on passed dictionaries.
    it is doing recursive call if dictionaries have inner dicts.
    """
    # iterate over each item in dict
    for key, value in update_with.items():
        # if a value is a dict
        if isinstance(value, dict):
            base_dict_value = base_dict.get(key)

            # if original value is also a dict then run it thorugh this same function
            if isinstance(base_dict_value, dict):
                deep_update(base_dict_value, value)
            # if the original value is not a dict then just set the new value
            else:
                base_dict[key] = value
        # if the new value is not a dict
        else:
            base_dict[key] = value

    return base_dict
