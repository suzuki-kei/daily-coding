
def count(xs)
    xs.reduce(0, &lambda{|count, x| count + 1})
end

def minimum(xs)
    less = lambda{|a, b| a < b ? a : b}
    xs.reduce(xs[0], &less)
end

def maximum(xs)
    greater = lambda{|a, b| a > b ? a : b}
    xs.reduce(xs[0], &greater)
end

def sum(xs)
    xs.reduce(0, :+)
end

def product(xs)
    xs.reduce(1, :*)
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

