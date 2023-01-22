
def main():
    xs = "a a b c c c".split()
    encoded = encode(xs)
    decoded = decode(encoded)
    print(xs)
    print(encoded)
    print(decoded)

def encode(xs):
    return xs_to_encoded_runs(xs)

def xs_to_encoded_runs(xs):
    runs = xs_to_runs(xs)
    return runs_to_encoded_runs(runs)

def xs_to_runs(xs):
    if len(xs) == 0:
        return []

    runs = []
    run = xs[:1]
    xs = xs[1:]

    while len(xs) != 0:
        if xs[0] == run[0]:
            run.append(xs[0])
            xs = xs[1:]
        else:
            runs.append(run)
            run = xs[:1]
            xs = xs[1:]

    runs.append(run)
    return runs

def runs_to_encoded_runs(runs):
    return list(map(run_to_encoded_run, runs))

def run_to_encoded_run(run):
    return (run[0], len(run))

def decode(encoded_runs):
    return encoded_runs_to_runs(encoded_runs)

def encoded_runs_to_runs(encoded_runs):
    runs = list(map(encoded_run_to_run, encoded_runs))
    return runs_to_xs(runs)

def encoded_run_to_run(encoded_run):
    run = []

    for i in range(encoded_run[1]):
        run.append(encoded_run[0])
    return run

def runs_to_xs(runs):
    xs = []
    for run in runs:
        xs += run
    return xs

if __name__ == "__main__":
    main()

