
def main
    array = generate_random_values(20)
    print_array(array)
    double_selection_sort(array)
    print_array(array)
end

def generate_random_values(n)
    n.times.map do
        rand(10..99)
    end
end

def print_array(array)
    if sorted?(array)
        puts "#{array.join(' ')} (sorted)"
    else
        puts "#{array.join(' ')} (not sorted)"
    end
end

def sorted?(array)
    (0 ... array.size - 1).all? do |i|
        array[i] <= array[i + 1]
    end
end

def double_selection_sort(array)
    lower = 0
    upper = array.size - 1

    while lower < upper
        minimum_index = lower
        maximum_index = lower

        (lower + 1 .. upper).each do |i|
            if array[i] < array[minimum_index]
                minimum_index = i
            end
            if array[i] > array[maximum_index]
                maximum_index = i
            end
        end

        if maximum_index == lower
            maximum_index = minimum_index
        end

        swap(array, lower, minimum_index)
        swap(array, upper, maximum_index)

        lower += 1
        upper -= 1
    end
end

def swap(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

if $0 == __FILE__
    main
end

