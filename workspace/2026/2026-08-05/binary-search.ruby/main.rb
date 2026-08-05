
def main
    values = selection_without_replacement(10, 99, 20)
    puts values.join(' ')

    min = values.first - 1
    max = values.last + 1

    (min .. max).each do |target|
        index = binary_search(values, target)
        puts "target=#{target}, index=#{index}"
    end
end

def selection_without_replacement(min, max, n)
    [].tap do |values|
        (min .. max).each do |value|
            numerator = (n - values.size).to_f
            denominator = (max - value + 1).to_f
            values << value if rand < numerator / denominator
        end
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

