
def main
    names = [
        :permutations_recursive,
        :permutations_non_recursive,
    ]
    names.each do |name|
        puts "==== #{name}"
        xs = 'abc'.chars
        method(name).call(xs, xs.size) do |values|
            p values
        end
    end
end

#
# Heap のアルゴリズム (再帰版).
#
def permutations_recursive(xs, n, &block)
    if n == 1
        block.call(xs)
        return
    end

    permutations_recursive(xs, n-1, &block)

    (n-1).times.each do |i|
        if n.even?
            swap(xs, i, n-1)
        else
            swap(xs, 0, n-1)
        end
        permutations_recursive(xs, n-1, &block)
    end
end

#
# Heap のアルゴリズム (非再帰版).
#
def permutations_non_recursive(xs, n, &block)
    indexes = [0] * n
    sp = 1

    block.call(xs)

    while sp < n
        if indexes[sp] < sp
            if sp.even?
                swap(xs, 0, sp)
            else
                swap(xs, sp, indexes[sp])
            end

            block.call(xs)

            indexes[sp] += 1
            sp = 1
        else
            indexes[sp] = 0
            sp += 1
        end
    end
end

def swap(values, index1, index2)
    values.tap do
        values[index1], values[index2] = values[index2], values[index1]
    end
end

main

