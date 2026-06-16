
def main
    array = generate_random_values(20)
    print_array(array)
    heap_sort!(array)
    print_array(array)
end

def generate_random_values(n)
    Array.new(n) do
        rand(10 .. 99)
    end
end

def print_array(array)
    status = sorted?(array) ? 'sorted' : 'not sorted'
    puts "#{array.join(' ')} (#{status})"
end

def sorted?(array)
    array.each_cons(2).all? do |a, b|
        a <= b
    end
end

def heap_sort!(array)
    make_heap!(array)
    pop_all!(array)
end

def make_heap!(array)
    (0 .. array.size / 2 - 1).reverse_each do |i|
        shift_down!(array, array.size, i)
    end
end

def pop_all!(array)
    (1 ... array.size).reverse_each do |i|
        swap!(array, i, 0)
        shift_down!(array, i, 0)
    end
end

def shift_down!(array, n, i)
    while i * 2 + 1 < n
        maximum_index = i
        maximum_index = compute_maximum_index(array, n, maximum_index, i * 2 + 1)
        maximum_index = compute_maximum_index(array, n, maximum_index, i * 2 + 2)

        break if i == maximum_index
        swap!(array, i, maximum_index)
        i = maximum_index
    end
end

def compute_maximum_index(array, n, maximum_index, child_index)
    case
        when child_index >= n
            maximum_index
        when array[child_index] < array[maximum_index]
            maximum_index
        else
            child_index
    end
end

def swap!(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

if $0 == __FILE__
    main
end

