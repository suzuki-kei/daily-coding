import inspect


def parameterized(tuples):
    def new_wrapper(method, tuple):
        def wrapper(self):
            method(self, *tuple)
        return wrapper

    def decorator(method):
        f_locals = inspect.currentframe().f_back.f_locals

        for i, tuple in enumerate(tuples):
            wrapper_name = f"{method.__name__}_{i}"
            wrapper_method = new_wrapper(method, tuple)
            f_locals[wrapper_name] = wrapper_method

    return decorator

