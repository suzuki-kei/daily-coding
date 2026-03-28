import inspect


def expand(parameters_list):
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
            make_expanded_method(parameterized_method, parameters, i)
            for i, parameters in enumerate(parameters_list)
        ]

    def make_expanded_method(parameterized_method, parameters, i):
        expanded_method = lambda self: parameterized_method(self, *parameters)
        expanded_method.__name__ = f"{parameterized_method.__name__}_{i + 1}"
        return expanded_method

    return define_expanded_methods

