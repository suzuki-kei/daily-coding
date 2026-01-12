
def main
    values = make_random_values(20)
    puts values.join(' ')
    quick_sort(values)
    puts values.join(' ')
end

def make_random_values(n)
    n.times.map do
        rand(90) + 10
    end
end

def quick_sort(values)
    quick_sort_range(values, 0, values.size - 1)
end

def quick_sort_range(values, lower, upper)
    lower_index = lower
    upper_index = upper
    pivot = values[(lower + upper) / 2]

    while lower_index <= upper_index
        while values[lower_index] < pivot
            lower_index += 1
        end
        while values[upper_index] > pivot
            upper_index -= 1
        end
        if lower_index <= upper_index
            values[lower_index], values[upper_index] = values[upper_index], values[lower_index]
            lower_index += 1
            upper_index -= 1
        end
    end

    if lower < upper_index
        quick_sort_range(values, lower, upper_index)
    end
    if lower_index < upper
        quick_sort_range(values, lower_index, upper)
    end
end

main

