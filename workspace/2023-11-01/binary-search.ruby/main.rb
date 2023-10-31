
def main
    values = generate_random_ascending_values(20)
    puts values.join(' ')

    lower = values[0] - 1
    upper = values[-1] + 1

    (lower..upper).each do |target|
        index = binary_search(values, target)
        puts "target=#{target}, index=#{index}"
    end
end

def generate_random_ascending_values(n)
    [].tap do |values|
        offset = 10
        n.times.each do
            values.append(rand(5) + offset)
            offset = values[-1] + 1
        end
    end
end

def binary_search(values, target)
    binary_search_range(values, 0, values.size - 1, target)
end

def binary_search_range(values, lower, upper, target)
    center = (lower + upper) / 2

    case
        when center < lower || upper < center
            -1
        when target < values[center]
            binary_search_range(values, lower, center - 1, target)
        when target > values[center]
            binary_search_range(values, center + 1, upper, target)
        else
            center
    end
end

main

