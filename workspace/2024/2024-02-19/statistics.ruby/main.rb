
def main
    puts "xs       = #{xs = [96, 70, 59, 54, 49, 41, 38, 36, 33, 24]}"
    puts "n        = #{n = xs.size}"
    puts "sum      = #{sum = xs.sum}"
    puts "mean     = #{mean = sum.to_f / n}"
    puts "variance = #{variance = xs.map{|x| (x - mean) ** 2}.sum.to_f / n}"
    puts "stddev   = #{stddev = Math.sqrt(variance)}"
    puts

    puts '偏差値'
    xs.each do |x|
        t_score = (x - mean) / stddev * 10 + 50
        puts "    点数=#{x}, 偏差値=#{t_score}"
    end
    puts
end

main if $0 == __FILE__

