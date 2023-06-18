
def count(xs)
    xs.map{1}.reduce(0, :+)
end

def minimum(xs)
    less = lambda{|a, b| a < b ? a : b}
    xs.reduce(&less)
end

def maximum(xs)
    greater = lambda{|a, b| a > b ? a : b}
    xs.reduce(&greater)
end

def sum(xs)
    xs.reduce(0, :+)
end

def average(xs)
    sum(xs).to_f / count(xs)
end

def variance(xs)
    variances = xs.map{|x| (x - average(xs)) ** 2}
    sum(variances) / count(xs)
end

def stddev(xs)
    variance(xs) ** 0.5
end

