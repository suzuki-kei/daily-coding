import Text.Printf

main :: IO ()
main = do
    printf "factorial:\n"
    printf "%s\n\n" $ join " " $ map (show . factorial) [1..10]

    printf "fibonacci:\n"
    printf "%s\n\n" $ join " " $ map (show . fibonacci) [1..20]

    printf "FizzBuzz:\n"
    printf "%s\n\n" $ join " " $ map fizzBuzz [1..100]

join :: String -> [String] -> String
join delimiter [] = ""
join delimiter (x:[]) = x
join delimiter (x:xs) = x ++ delimiter ++ (join delimiter xs)

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

fizzBuzz :: Int -> String
fizzBuzz n
    | n `mod` 15 == 0 = "FizzBuzz"
    | n `mod`  5 == 0 = "Buzz"
    | n `mod`  3 == 0 = "Fizz"
    | otherwise       = show n

