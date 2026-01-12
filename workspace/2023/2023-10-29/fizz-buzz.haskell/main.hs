{- cabal:
    build-depends: base
-}

import Data.List
import Text.Printf

main :: IO ()
main = do
    let values = map fizzBuzz [1..100]
    let string = concat $ intersperse " " values
    printf "%s\n" string

fizzBuzz :: Int -> String
fizzBuzz n
    | n `mod` 15 == 0 = "FizzBuzz"
    | n `mod`  5 == 0 = "Buzz"
    | n `mod`  3 == 0 = "Fizz"
    | otherwise       = show n

