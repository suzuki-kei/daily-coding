
def main
    (0...32).each do |y|
        puts (0...32).map {|x| x & y == 0 ? '＊' : '　'}.join
    end
end

if $0 == __FILE__
    main
end

