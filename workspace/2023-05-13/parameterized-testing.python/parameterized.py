import inspect

def parameterized(tuples):

    def decorator(method):
        f_locals = inspect.currentframe().f_back.f_locals
        f_locals |= make_wrapper_map(method, tuples)

    def make_wrapper_map(method, tuples):
        return {
            wrapper.__name__: wrapper
            for wrapper in make_wrappers(method, tuples)
        }

    def make_wrappers(method, tuples):
        return [
            make_wrapper(method, tuple, index)
            for index, tuple in enumerate(tuples)
        ]

    def make_wrapper(method, tuple, index):
        wrapper = lambda self: method(self, *tuple)
        wrapper.__name__ = f"{method.__name__}_{index + 1}"
        return wrapper

    return decorator

