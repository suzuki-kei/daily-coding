
def main
    p permutations([]).to_a
    p permutations([1]).to_a
    p permutations([1, 2]).to_a
    p permutations([1, 2, 3]).to_a
end

def permutations(xs)
    Enumerator.new do |yielder|
        visit_permutations(xs, &yielder.method(:yield))
    end
end

def visit_permutations(xs, n = xs.size, &block)
    if n == 1
        block.call(xs.clone)
    else
        (0 ... n).each do |i|
            visit_permutations(xs, n - 1, &block)

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

