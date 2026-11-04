
def main
    values = (0..9).to_a
    puts values.join(' ')
    shuffle!(values)
    puts values.join(' ')
end

def shuffle!(values)
    (0 ...  values.size - 1).each do |i|
        target = rand(i ... values.size)
        values[i], values[target] = values[target], values[i]
    end
end

if $0 == __FILE__
    main
end

