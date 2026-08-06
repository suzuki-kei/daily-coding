
def main
    values = selection_without_replacement(10, 99, 20)
    puts values.join(' ')
end

def selection_without_replacement(min, max, n)
    if n > max - min + 1
        raise
    end

    [].tap do |values|
        (min .. max).each do |value|
            numerator = n - values.size
            denominator = max - value + 1
            values << value if rand < numerator / denominator.to_f
        end
    end
end

if $0 == __FILE__
    main
end

