import inspect


def expand(tuples):

    def define_expanded_methods(parameterized_method):
        f_locals = inspect.currentframe().f_back.f_locals
        f_locals |= to_expanded_method_map(parameterized_method, tuples)

    def to_expanded_method_map(parameterized_method, tuples):
        return {
            expanded_method.__name__: expanded_method
            for expanded_method in to_expanded_methods(parameterized_method, tuples)
        }

    def to_expanded_methods(parameterized_method, tuples):
        return [
            to_expanded_method(parameterized_method, tuple, index)
            for index, tuple in enumerate(tuples)
        ]

    def to_expanded_method(parameterized_method, tuple, index):
        expanded_method = lambda self: parameterized_method(self, *tuple)
        expanded_method.__name__ = f"{parameterized_method.__name__}_{index + 1}"
        return expanded_method

    return define_expanded_methods

