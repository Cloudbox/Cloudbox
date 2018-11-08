
# Modified version of https://github.com/audreyr/jinja2_pluralize

def pluralize(value, arg='s', arg2=None):
    """
    Adapted from django.template.defaultfilters:
    https://github.com/django/django/blob/master/django/template/defaultfilters.py

    Returns a plural suffix if the value is not 1. By default, 's' is used as
    the suffix:

    * If value is 0, vote{{ value | pluralize }} displays "0 votes".
    * If value is 1, vote{{ value | pluralize }} displays "1 vote".
    * If value is 2, vote{{ value | pluralize }} displays "2 votes".

    If an argument is provided, that string is used instead:

    * If value is 0, class{{ value | pluralize('es') }} displays "0 classes".
    * If value is 1, class{{ value | pluralize('es') }} displays "1 class".
    * If value is 2, class{{ value | pluralize('es') }} displays "2 classes".

    If the provided argument contains a comma, the text before the comma is
    used for the singular case and the text after the comma is used for the
    plural case:

    * If value is 0, cand{{ value | pluralize('y','ies') }} displays "0 candies".
    * If value is 1, cand{{ value | pluralize('y','ies') }} displays "1 candy".
    * If value is 2, cand{{ value | pluralize('y','ies') }} displays "2 candies".
    """

    if arg2 is not None:
        singular_suffix = arg
        plural_suffix = arg2
    else:
        singular_suffix = ''
        plural_suffix = arg

    try:
        if int(value) != 1:
            return plural_suffix
    except ValueError:  # Invalid string that's not a number.
        pass
    except TypeError:  # Value isn't a string or a number; maybe it's a list?
        try:
            if len(value) != 1:
                return plural_suffix
        except TypeError:  # len() of unsized object.
            pass
    return singular_suffix


class FilterModule(object):
    ''' adds pluralize filter '''
    def filters(self):
        return {
            # filter map
            'pluralize': pluralize
        }
