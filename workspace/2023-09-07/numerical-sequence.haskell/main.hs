import Data.List
import Text.Printf

main :: IO ()
main = do
    printSequence "factorials" factorial 1 10
    printSequence "fibonacci numbers" fibonacci 0 20
    printSequence "fizz buzz values" fizzBuzz 1 100

printSequence :: (Show a) => String -> (Int -> a) -> Int -> Int -> IO ()
printSequence description f min max = do
    let values = map (show . f) [min..max]
    let string = foldl (++) "" $ intersperse " " values
    printf "%s:\n%s\n" description string

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

