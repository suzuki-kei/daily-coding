
def main
    values = random_values(20)
    puts values.join(' ')
    quick_sort(values)
    puts values.join(' ')
end

def random_values(n)
    n.times.map do
        rand(90) + 10
    end
end

def quick_sort(values)
    _quick_sort(values, 0, values.size - 1)
end

def _quick_sort(values, lower, upper)
    lower_index = lower
    upper_index = upper
    pivot = values[(lower + upper) / 2]

    while lower_index <= upper_index
        lower_index += 1 while values[lower_index] < pivot
        upper_index -= 1 while values[upper_index] > pivot

        if lower_index <= upper_index
            swap(values, lower_index, upper_index)
            lower_index += 1
            upper_index -= 1
        end
    end

    _quick_sort(values, lower, upper_index) if lower < upper_index
    _quick_sort(values, lower_index, upper) if lower_index < upper
end

def swap(values, index1, index2)
    values[index1], values[index2] = values[index2], values[index1]
end

main

