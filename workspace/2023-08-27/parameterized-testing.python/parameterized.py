import inspect


def expand(tuples):

    def decorator(base_method):
        f_locals = inspect.currentframe().f_back.f_locals
        f_locals |= make_expanded_method_map(base_method, tuples)

    def make_expanded_method_map(base_method, tuples):
        return {
            method.__name__: method
            for method in make_expanded_methods(base_method, tuples)
        }

    def make_expanded_methods(base_method, tuples):
        return [
            make_expanded_method(base_method, tuple, index)
            for index, tuple in enumerate(tuples)
        ]

    def make_expanded_method(base_method, tuple, index):
        expanded_method = lambda self: base_method(self, *tuple)
        expanded_method.__name__ = f"{base_method.__name__}_{index + 1}"
        return expanded_method

    return decorator

