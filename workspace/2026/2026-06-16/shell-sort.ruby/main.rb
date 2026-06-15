
def main
    array = generate_random_values(20)
    print_array(array)
    shell_sort!(array)
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

def shell_sort!(array)
    enumerate_hops(array.size).each do |hop|
        (hop ... array.size).each do |i|
            insert(array, i, hop)
        end
    end
end

def enumerate_hops(n)
    hop = 1

    while hop * 3 + 1 < n
        hop = hop * 3 + 1
    end

    Enumerator.new do |yielder|
        while hop >= 1
            yielder << hop
            hop /= 3
        end
    end
end

def insert(array, i, hop)
    value = array[i]

    while i >= hop && value < array[i - hop]
        array[i] = array[i - hop]
        i -= hop
    end

    array[i] = value
end

if $0 == __FILE__
    main
end

