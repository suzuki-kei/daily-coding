require 'caesar_cipher'

def main
    s = 'Hello, World!'

    (1..26).each do |n|
        encoded = encode(n, s)
        decoded = decode(n, encoded)
        puts "(n=#{n}) #{s} -> #{encoded} -> #{decoded}"
    end
end

main

