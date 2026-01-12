
main :: IO ()
main = do
    print "factorials:"
    print $ map factorial [1..10]
    print "fibonacci numbers:"
    print $ map fibonacci [0..20]
    print "FizzBuzz values:"
    print $ map fizzbuzz [1..100]

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

fizzbuzz :: Int -> String
fizzbuzz n
    | n `mod` 15 == 0 = "FizzBuzz"
    | n `mod`  5 == 0 = "Buzz"
    | n `mod`  3 == 0 = "Fizz"
    | otherwise       = show n

