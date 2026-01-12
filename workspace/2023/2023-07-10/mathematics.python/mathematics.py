from functools import reduce
from operator import add


def count(xs):
    return reduce(lambda n, x: n + 1, xs, 0)


def sum(xs):
    return reduce(add, xs, 0)


def average(xs):
    return sum(xs) / count(xs)


def minimum(xs):
    def less(a, b):
        if a < b:
            return a
        else:
            return b
    return reduce(less, xs[1:], xs[0])


def maximum(xs):
    def greater(a, b):
        if a > b:
            return a
        else:
            return b
    return reduce(greater, xs[1:], xs[0])


def variance(xs):
    return sum([(x - average(xs)) ** 2 for x in xs]) / count(xs)


def stddev(xs):
    return variance(xs) ** 0.5

