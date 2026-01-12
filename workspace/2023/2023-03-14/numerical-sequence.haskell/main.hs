{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit
import Text.Printf

main :: IO ()
main = do
    printf "==== demonstration\n"
    demonstration
    printf "==== test\n"
    _ <- runTestTT allTestList
    pure ()

demonstration :: IO ()
demonstration = do
    printf "factorial : %s\n" $ show $ map factorial [1..10]
    printf "fibonacci : %s\n" $ show $ map fibonacci [1..10]
    printf "fizzbuzz  : %s\n" $ show $ map fizzbuzz [1..15]

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

allTestList = test [
    factorialTestList,
    fibonacciTestList,
    fizzbuzzTestList]

factorialTestList = test [
    "factorial"
        ~: "#1"
        ~: [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800]
        ~=? map factorial [0..10]]

fibonacciTestList = test [
    "fibonacci"
        ~: "#1"
        ~: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
        ~=? map fibonacci [0..10]]

fizzbuzzTestList = test [
    "fizzbuzz"
        ~: "#1"
        ~: ["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]
        ~=? map fizzbuzz [1..15]]

