
def encode(n, s)
    s.chars.map{|c| rotate(n, c)}.join
end

def decode(n, s)
    encode(26 - n, s)
end

def rotate(n, c)
    if lower?(c)
        offset = 'a'.ord
        c = ((c.ord + n - offset) % 26 + offset).chr
    end

    if upper?(c)
        offset = 'A'.ord
        c = ((c.ord + n - offset) % 26 + offset).chr
    end

    c
end

def lower?(c)
    ('a'..'z').include?(c)
end

def upper?(c)
    ('A'..'Z').include?(c)
end

