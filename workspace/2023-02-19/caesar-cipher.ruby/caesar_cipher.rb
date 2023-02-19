
def encode(text, n)
    chars = text.chars
    encoded_chars = chars.map{|char| rotate(char, n)}
    encoded_chars.join
end

def decode(encoded_text, n)
    encode(encoded_text, 26 - n)
end

def rotate(char, n)
    case
        when lower?(char)
            rotate_alphabet(char, n, 'a'.ord)
        when upper?(char)
            rotate_alphabet(char, n, 'A'.ord)
        else
            char
    end
end

def lower?(char)
    ('a'..'z').include?(char)
end

def upper?(char)
    ('A'..'Z').include?(char)
end

def rotate_alphabet(char, n, offset)
    ((char.ord + n - offset) % 26 + offset).chr
end

