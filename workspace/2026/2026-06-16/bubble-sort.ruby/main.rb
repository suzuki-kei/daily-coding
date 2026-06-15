
def main
    array = generate_random_values(20)
    print_array(array)
    bubble_sort!(array)
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

def bubble_sort!(array)
    (array.size - 1).downto(1).each do |last|
        (0 ... last).each do |i|
            if array[i] > array[i + 1]
                swap(array, i, i + 1)
            end
        end
    end
end

def swap(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

if $0 == __FILE__
    main
end

