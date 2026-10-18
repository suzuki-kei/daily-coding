
def main
    values = (0..9).to_a
    puts values.join(' ')
    shuffle!(values)
    puts values.join(' ')
end

def shuffle!(values)
    values.each_index do |i|
        selected = rand(i ... values.size)
        values[i], values[selected] = values[selected], values[i]
    end
end

if $0 == __FILE__
    main
end

