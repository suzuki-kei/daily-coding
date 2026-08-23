
def main
    values = selection_without_replacement(10..99, 20)
    puts values.join(' ')

    target_range = (values.first - 1) .. (values.last + 1)

    target_range.each do |target|
        index = binary_search(values, target)
        puts "target=#{target}, index=#{index}"
    end
end

def selection_without_replacement(range, n)
    [].tap do |values|
        range.each do |value|
            n_remaining = n - values.size
            n_candidates_remaining = range.last - value + 1
            selection_probability = n_remaining / n_candidates_remaining.to_f
            values << value if rand < selection_probability
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

