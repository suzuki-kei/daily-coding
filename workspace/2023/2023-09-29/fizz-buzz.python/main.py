import itertools


fizz_buzz_generator = map(
    lambda xs: next(itertools.dropwhile(lambda x: x is None, xs)),
    zip(itertools.cycle([None] * 14 + ["FizzBuzz"]),
        itertools.cycle([None] *  4 + ["Buzz"]),
        itertools.cycle([None] *  2 + ["Fizz"]),
        itertools.count(1, 1)))

for x in itertools.islice(fizz_buzz_generator, 100):
    print(x)

