
PartitionResult = Data.define(:left_upper, :right_lower)

def main
    demonstration('partition 2-way', method(:partition_2way))
    demonstration('partition 3-way', method(:partition_3way))
end

def demonstration(label, partition)
    puts "==== #{label}"
    array = generate_random_values(20)
    print_array(array)
    quick_sort!(array, partition)
    print_array(array)
end

def generate_random_values(n)
    n.times.map do
        rand(10 .. 99)
    end
end

def print_array(array)
    if is_sorted(array)
        puts "#{array.join(' ')} (sorted)"
    else
        puts "#{array.join(' ')} (not sorted)"
    end
end

def is_sorted(array)
    (0 ... array.size - 1).all? do |i|
        array[i] <= array[i + 1]
    end
end

def quick_sort!(array, partition)
    quick_sort_range!(array, 0, array.size - 1, partition)
end

def quick_sort_range!(array, lower, upper, partition)
    if lower >= upper
        return
    end

    result = partition.call(array, lower, upper)
    quick_sort_range!(array, lower, result.left_upper, partition)
    quick_sort_range!(array, result.right_lower, upper, partition)
end

def partition_2way(array, lower, upper)
    increment_index = lower
    decrement_index = upper
    pivot = array[rand(lower .. upper)]

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
        left_upper: decrement_index,
        right_lower: increment_index,
    )
end

def partition_3way(array, lower, upper)
    less_end = lower
    increment_index = lower
    decrement_index = upper
    pivot = array[rand(lower .. upper)]

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
        left_upper: less_end - 1,
        right_lower: increment_index,
    )
end

def swap(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

if $0 == __FILE__
    main
end

