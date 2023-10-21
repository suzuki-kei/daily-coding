import operator


def count(start=0, step=1):
    i = start

    while True:
        yield i
        i += step


def cycle(iterable):
    values = []

    for value in iterable:
        yield value
        values.append(value)

    while values:
        for value in values:
            yield value


def repeat(value, n=None):
    if n is None:
        while True:
           yield value
    else:
        for _ in range(n):
            yield value


def accumulate(iterable, func=operator.add, *, initial=None):
    iterable = iter(iterable)

    if initial is None:
        try:
            accumulated = next(iterable)
        except StopIteration:
            return
    else:
        accumulated = initial

    yield accumulated

    for value in iterable:
        accumulated = func(accumulated, value)
        yield accumulated


def batched(iterable, n):
    ...  # TODO


def chain(*iterables):
    for iterable in iterables:
        yield from iterable


def compress(iterable, selectors):
    for value, predicate in zip(iterable, selectors):
        if predicate:
            yield value


def dropwhile(predicate, iterable):
    for value in iterable:
        if predicate(value):
            yield value


def filterfalse(predicate, iterable):
    if predicate is None:
        predicate = bool

    for value in iterable:
        if not predicate(value):
            yield value

