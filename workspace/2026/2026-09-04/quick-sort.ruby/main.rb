
PartitionResult = Data.define(:left_last, :right_first)

def main
    demonstration('partition 2-way', method(:partition_2way))
    demonstration('partition 3-way', method(:partition_3way))
end

def demonstration(label, partition)
    puts "==== #{label}"

    array = generate_random_values(min: 10, max: 99, n: 20)
    print_array(array)
    quick_sort!(array, partition)
    print_array(array)
end

def generate_random_values(min:, max:, n:)
    Array.new(n) do
        rand(min..max)
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
        result = partition.call(array, first, last)
        n_left = result.left_last - first + 1
        n_right = last - result.right_first + 1

        if n_left <= n_right
            quick_sort!(array, partition, first, result.left_last)
            first = result.right_first
        else
            quick_sort!(array, partition, result.right_first, last)
            last = result.left_last
        end
    end
end

def partition_2way(array, first, last)
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
            swap(array, increment_index, decrement_index)
            increment_index += 1
            decrement_index -= 1
        end
    end

    PartitionResult.new(
        left_last: decrement_index,
        right_first: increment_index,
    )
end

def partition_3way(array, first, last)
    less_end = first
    increment_index = first
    decrement_index = last
    pivot = array[rand(first..last)]

    while increment_index <= decrement_index
        if array[increment_index] < pivot
            swap(array, less_end, increment_index)
            less_end += 1
            increment_index += 1
        elsif array[increment_index] > pivot
            swap(array, increment_index, decrement_index)
            decrement_index -= 1
        else
            increment_index += 1
        end
    end

    PartitionResult.new(
        left_last: less_end - 1,
        right_first: increment_index,
    )
end

def swap(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

if $0 == __FILE__
    main
end

