
def main
    (0..6).each do |n|
        (0..n).each do |r|
            puts "C(n=#{n}, r=#{r}) = #{combination(n, r)}"
        end
    end
end

#
# C(n, r)   = n! / (r! * (n-r)!)
# C(n, r-1) = n! / ((r-1)! * (n-(r-1))!)
# r!        = r * (r-1)!
# (n-r)!    = (n-(r-1))! / (n-(r-1))
# C(n, r)   = C(n, r-1) * (n-(r-1)) / r
#
def combination(n, r)
    if n == 0 || r == 0 || n == r
        1
    else
        combination(n, r - 1) * (n - (r - 1)) / r
    end
end

main if $0 == __FILE__

