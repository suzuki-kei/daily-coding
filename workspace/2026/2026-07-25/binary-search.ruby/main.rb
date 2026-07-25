
def main
    values = generate_random_ascending_values(20)
    puts values.join(' ')

    min = values.first - 1
    max = values.last + 1

    (min .. max).each do |target|
        index = binary_search(values, target)
        puts "target=#{target}, index=#{index}"
    end
end

def generate_random_ascending_values(n)
    n.times.reduce([]) do |values, _|
        offset = values.last || 9
        values << rand(1..5) + offset
    end
end

def binary_search(values, target, first = 0, last = values.size - 1)
    if first > last
        -1
    else
        center = (first + last) / 2

        case
            when target < values[center]
                binary_search(values, target, first, center - 1)
            when target > values[center]
                binary_search(values, target, center + 1, last)
            else
                center
        end
    end
end

if $0 == __FILE__
    main
end

