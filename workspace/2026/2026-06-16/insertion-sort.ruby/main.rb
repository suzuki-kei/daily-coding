
def main
    array = generate_random_values(20)
    print_array(array)
    insertion_sort!(array)
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

def insertion_sort!(array)
    (1 ... array.size).each do |i|
        insert(array, i)
    end
end

def insert(array, i)
    value = array[i]

    while i >= 1 && value < array[i - 1]
        array[i] = array[i - 1]
        i -= 1
    end

    array[i] = value
end

if $0 == __FILE__
    main
end

