import inspect


def expand(parameters_map):

    def define_expanded_methods(parameterized_method):
        f_locals = inspect.currentframe().f_back.f_locals
        f_locals |= make_expanded_method_map(parameterized_method)

    def make_expanded_method_map(parameterized_method):
        return {
            expanded_method.__name__: expanded_method
            for expanded_method in make_expanded_methods(parameterized_method)
        }

    def make_expanded_methods(parameterized_method):
        return [
            make_expanded_method(parameterized_method, *parameters, index)
            for index, parameters in enumerate(parameters_map.items())
        ]

    def make_expanded_method(parameterized_method, arguments, expected, index):
        expanded_method = lambda self: parameterized_method(self, expected, *arguments)
        expanded_method.__name__ = f"{parameterized_method.__name__}_{index + 1}"
        return expanded_method

    return define_expanded_methods

