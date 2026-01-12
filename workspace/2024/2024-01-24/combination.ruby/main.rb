#
# n 個から r 個を選ぶ組み合わせ C(n, r) を求める.
#
# ==== NOTE
# 組み合わせの式:
#     C(n, r) = n! / (r! * (n-r)!)
#
# 組み合わせの漸化式:
#     C(n, r) = C(n, r-1) * (n-r+1) / r
#
# 漸化式が成立することの説明:
#  1. C(n, r) の r に r-1 を代入すると C(n, r-1) になる
#     C(n, r-1) = n! / ((r-1)! * (n-r+1)!)
#  2. C(n, r-1) に何を掛ければ C(n, r) になるか考える
#     (r-1)! を r! にするには r を掛ければよい
#     (n-r+1)! を (n-r)! にするには (n-r+1) で割ればよい
#  3. よって以下の漸化式が成立する
#     C(n, r) = C(n, r-1) * r / (n-r+1)
#

def main
    (0..10).each do |n|
        (0..n).each do |r|
            puts "C(#{n}, #{r}) = #{combination(n, r)}"
        end
        puts
    end
end

def combination(n, r)
    if n == 0 || r == 0 || n == r
        1
    else
        combination(n, r - 1) * (n - r + 1) / r
    end
end

main if $0 == __FILE__

