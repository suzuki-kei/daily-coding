
main :: IO ()
main = print $ fizzBuzz 100

fizzBuzz :: Int -> [String]
fizzBuzz n = map fizzBuzzValue [1..n]

fizzBuzzValue :: Int -> String
fizzBuzzValue n | n `mod` 15 == 0 = "FizzBuzz"
                | n `mod`  5 == 0 = "Buzz"
                | n `mod`  3 == 0 = "Fizz"
                | otherwise       = show n

