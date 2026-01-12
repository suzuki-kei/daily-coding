
def count(xs)
    xs.reduce(0) do |count, _|
        count + 1
    end
end

def minimum(xs)
    xs.reduce(xs[0]) do |minimum, x|
        x < minimum ? x : minimum
    end
end

def maximum(xs)
    xs.reduce(xs[0]) do |minimum, x|
        x > minimum ? x : minimum
    end
end

def sum(xs)
    xs.reduce(0, :+)
end

def average(xs)
    sum(xs).to_f / count(xs)
end

def variance(xs)
    sum(xs.map{|x| (x - average(xs)) ** 2}) / count(xs)
end

def stddev(xs)
    Math.sqrt(variance(xs))
end

