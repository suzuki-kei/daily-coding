import Data.List (intersperse)
import Text.Printf (printf)

main :: IO ()
main = do
    printSequence "factorials" factorial [1..10]
    printSequence "fibonacci numbers" fibonacci [0..20]
    printSequence "fizz buzz values" fizzBuzz [1..100]

class ToString a where
    toString :: a -> String

instance ToString String where
    toString s = s

instance ToString Int where
    toString x = printf "%d" x

printSequence :: (ToString a) => String -> (Int -> a) -> [Int] -> IO ()
printSequence description f ns = do
    let values = map f ns
    let string = foldl (++) "" $ intersperse " " $ map toString values
    printf "%s:\n%s\n" description string

factorial :: Int -> Int
factorial n = factorial n 1
    where
        factorial 0 fn = fn
        factorial n fm = factorial (n - 1) (fm * n)

fibonacci :: Int -> Int
fibonacci n = fibonacci n 0 1
    where
        fibonacci 0 a b = a
        fibonacci n a b = fibonacci (n - 1) b (a + b)

fizzBuzz :: Int -> String
fizzBuzz n
    | n `mod` 15 == 0 = "FizzBuzz"
    | n `mod`  5 == 0 = "Buzz"
    | n `mod`  3 == 0 = "Fizz"
    | otherwise       = toString n

