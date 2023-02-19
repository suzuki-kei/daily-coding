
def encode(xs)
    runs = xs_to_runs(xs)
    runs_to_encoded_runs(runs)
end

def xs_to_runs(xs)
    if xs.empty?
        return []
    end

    runs = []
    run = xs.take(1)
    xs = xs.drop(1)

    xs.each do |x|
        if x == run[0]
            run.append(x)
        else
            runs.append(run)
            run = [x]
        end
    end

    runs.append(run)
end

def runs_to_encoded_runs(runs)
    runs.map do |run|
        run_to_encoded_run(run)
    end
end

def run_to_encoded_run(run)
    [run[0], run.size]
end

def decode(encoded_runs)
    runs = encoded_runs_to_runs(encoded_runs)
    runs_to_xs(runs)
end

def encoded_runs_to_runs(encoded_runs)
    encoded_runs.map do |encoded_run|
        encoded_run_to_run(encoded_run)
    end
end

def encoded_run_to_run(encoded_run)
    [encoded_run[0]] * encoded_run[1]
end

def runs_to_xs(runs)
    runs.reduce([], :+)
end

