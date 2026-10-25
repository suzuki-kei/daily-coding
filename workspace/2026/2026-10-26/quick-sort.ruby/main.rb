
def main
    demonstration('partition 2-way', method(:partition_2way!))
    demonstration('partition 3-way', method(:partition_3way!))
end

def demonstration(label, partition)
    puts "==== #{label}"
    array = generate_random_values(20, 10..99)
    print_array(array)
    quick_sort!(array, partition)
    print_array(array)
end

def generate_random_values(n, range)
    n.times.map do
        rand(range)
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
    array.each_cons(2).all? do |a, b|
        a <= b
    end
end

def quick_sort!(array, partition, first = 0, last = array.size - 1)
    while first < last
        middle_begin, middle_end = partition.call(array, first, last)
        n_left = middle_begin - first
        n_right = last - middle_end + 1

        if n_left < n_right
            quick_sort!(array, partition, first, middle_begin - 1)
            first = middle_end
        else
            quick_sort!(array, partition, middle_end, last)
            last = middle_begin - 1
        end
    end
end

def partition_2way!(array, first, last)
    increment_index = first
    decrement_index = last
    pivot = array[rand(first..last)]

    while increment_index <= decrement_index
        while array[increment_index] < pivot
            increment_index += 1
        end

        while array[decrement_index] > pivot
            decrement_index -= 1
        end

        if increment_index <= decrement_index
            swap!(array, increment_index, decrement_index)
            increment_index += 1
            decrement_index -= 1
        end
    end

    middle_begin = decrement_index + 1
    middle_end = increment_index
    [middle_begin, middle_end]
end

def partition_3way!(array, first, last)
    i = first
    less_end = first
    greater_begin = last + 1
    pivot = array[rand(first..last)]

    while i < greater_begin
        if array[i] < pivot
            swap!(array, less_end, i)
            i += 1
            less_end += 1
        elsif array[i] > pivot
            swap!(array, i, greater_begin - 1)
            greater_begin -= 1
        else
            i += 1
        end
    end

    middle_begin = less_end
    middle_end = greater_begin
    [middle_begin, middle_end]
end

def swap!(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

if $0 == __FILE__
    main
end

