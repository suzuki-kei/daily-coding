require 'caesar_cipher'

def main
    (1..26).each do |n|
        text = 'Hello, World!'
        encoded = encode(text, n)
        decoded = decode(encoded, n)
        puts "(n=#{n}) #{text} -> #{encoded} -> #{decoded}"
    end
end

main

