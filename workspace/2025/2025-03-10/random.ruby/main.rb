
def main
    puts generate_random_values(20)
end

def generate_random_values(n)
    n.times.map do
        rand(90) + 10
    end
end

main if $0 == __FILE__

