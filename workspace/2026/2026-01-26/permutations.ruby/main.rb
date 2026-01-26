
def main
    p permutations([])
    p permutations([1])
    p permutations([1, 2])
    p permutations([1, 2, 3])
end

def permutations(xs)
    enumerate_permutations(xs).to_a
end

def enumerate_permutations(xs)
    Enumerator.new do |yielder|
        generate_permutations(xs, &yielder.method(:yield))
    end
end

def generate_permutations(xs, &block)
    generate_permutations!(xs.clone, xs.size, &block)
end

def generate_permutations!(xs, n, &block)
    if n == 1
        block.call(xs.clone)
    else
        (0...n).each do |i|
            generate_permutations!(xs, n - 1, &block)

            if n.odd?
                xs[0], xs[n - 1] = xs[n - 1], xs[0]
            else
                xs[i], xs[n - 1] = xs[n - 1], xs[i]
            end
        end
    end
end

if $0 == __FILE__
    main
end

