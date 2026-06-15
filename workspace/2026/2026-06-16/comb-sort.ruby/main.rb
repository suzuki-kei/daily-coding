
def main
    array = generate_random_values(20)
    print_array(array)
    comb_sort!(array)
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

def comb_sort!(array)
    gap = array.size
    swapped = false

    begin
        gap = compute_next_gap(gap)
        swapped = false

        (0 ... array.size - gap).each do |i|
            if array[i] > array[i + gap]
                swap(array, i, i + gap)
                swapped = true
            end
        end
    end while gap != 1 or swapped
end

def compute_next_gap(gap)
    case gap
        when 1..2
            1
        when 13..15
            11
        else
            gap * 10 / 13
    end
end

def swap(array, index1, index2)
    array[index1], array[index2] = array[index2], array[index1]
end

if $0 == __FILE__
    main
end

