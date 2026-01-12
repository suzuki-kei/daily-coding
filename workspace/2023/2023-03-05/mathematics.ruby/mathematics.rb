
def count(xs)
    xs.map{|_| 1}.reduce(0, :+)
end

def minimum(xs)
    less = lambda {|a, b| a < b ? a : b}
    xs.reduce(xs[0], &less)
end

def maximum(xs)
    greater = lambda {|a, b| a > b ? a : b}
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
    square_of_difference = lambda {|x| (x.to_f - average(xs)) ** 2}
    square_of_differences = xs.map(&square_of_difference)
    average(square_of_differences)
end

def stddev(xs)
    Math.sqrt(variance(xs))
end

