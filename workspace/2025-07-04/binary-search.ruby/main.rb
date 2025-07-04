
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
    n.times.reduce([]) do |values, _|
        offset = values[-1] || 9
        values << rand(1..5) + offset
    end
end

def binary_search(values, target, lower=0, upper=values.size-1)
    center = (lower + upper) / 2

    case
        when lower > upper
            -1
        when target < values[center]
            binary_search(values, target, lower, center - 1)
        when target > values[center]
            binary_search(values, target, center + 1, upper)
        else
            center
    end
end

if $0 == __FILE__
    main
end

