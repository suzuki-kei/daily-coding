
def main
    values = generate_random_values(20)
    puts values.join(' ')
    quick_sort!(values)
    puts values.join(' ')
end

def generate_random_values(n)
    n.times.map do
        rand(90) + 10
    end
end

def quick_sort!(values, lower=0, upper=values.size-1)
    lower_index = lower
    upper_index = upper
    pivot = values[(lower + upper) / 2]

    while lower_index <= upper_index
        lower_index += 1 while values[lower_index] < pivot
        upper_index -= 1 while values[upper_index] > pivot

        if lower_index <= upper_index
            values[lower_index], values[upper_index] = values[upper_index], values[lower_index]
            lower_index += 1
            upper_index -= 1
        end
    end

    quick_sort!(values, lower, upper_index) if lower < upper_index
    quick_sort!(values, lower_index, upper) if lower_index < upper
end

main if $0 == __FILE__

