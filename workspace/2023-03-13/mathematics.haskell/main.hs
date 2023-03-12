import Prelude hiding (minimum, maximum, sum, product)

main :: IO ()
main = do
    print $ map factorial [1..10]
    print $ map fibonacci [1..10]
    print $ map fizzbuzz [1..15]
    print $ count [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]
    print $ minimum [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]
    print $ maximum [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]
    print $ sum [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]
    print $ product [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]
    print $ average [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]
    print $ variance [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]
    print $ stddev [6, 8, 5, 0, 1, 2, 9, 7, 4, 3]

factorial :: Int -> Int
factorial(0) = 1
factorial(n) = n * factorial (n - 1)

fibonacci :: Int -> Int
fibonacci(0) = 0
fibonacci(1) = 1
fibonacci(n) = fibonacci (n - 1) + fibonacci (n - 2)

fizzbuzz :: Int -> String
fizzbuzz(n)
    | n `mod` 15 == 0 = "FizzBuzz"
    | n `mod`  5 == 0 = "Buzz"
    | n `mod`  3 == 0 = "Fizz"
    | otherwise       = show n

count :: [a] -> Int
count [] = 0
count (x:xs) = 1 + count xs

less :: (Real a) => a -> a -> a
less a b
    | a < b     = a
    | otherwise = b

minimum :: (Real a) => [a] -> a
minimum (x:[]) = x
minimum (x1:x2:xs) = minimum $ less x1 x2 : xs

greater :: (Real a) => a -> a -> a
greater a b
    | a > b     = a
    | otherwise = b

maximum :: (Real a) => [a] -> a
maximum (x:[]) = x
maximum (x1:x2:xs) = maximum $ greater x1 x2 : xs

sum :: (Num a) => [a] -> a
sum [] = 0
sum (x:xs) = x + sum xs

product :: (Num a) => [a] -> a
product [] = 0
product (x:xs) = x * product xs

average :: (Real a, Floating b) => [a] -> b
average xs = realToFrac (sum xs) / realToFrac (count xs)

variance :: (Real a, Floating b) => [a] -> b
variance xs = realToFrac (sum squareOfDifferences) / realToFrac (count xs)
    where
        square x = x * x
        difference x = x - average xs
        squareOfDifferences = map (square . difference . realToFrac) xs

stddev :: (Real a, Floating b) => [a] -> b
stddev xs = sqrt $ variance xs

