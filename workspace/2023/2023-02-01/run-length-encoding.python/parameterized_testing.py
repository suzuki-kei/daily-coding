import inspect


def parameterized(tuples):
    def new_wrapper(method, tuple, i):
        name = f"{method.__name__}_{i}"
        wrapper = lambda self: method(self, *tuple)
        wrapper.__name__ = name
        return wrapper

    def decorator(method):
        for i, tuple in enumerate(tuples):
            wrapper = new_wrapper(method, tuple, i)
            f_locals = inspect.currentframe().f_back.f_locals
            f_locals[wrapper.__name__] = wrapper

    return decorator

