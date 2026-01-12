{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit

main :: IO ()
main = do
    runTestTT allTestList
    pure ()

allTestList = TestList [
    factorialTestList,
    fibonacciTestList,
    fizzBuzzTestList]

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

fizzBuzzTestList = test [
    "fizzBuzz"
    ~: "#1"
    ~: ["1",     "2",     "Fizz",  "4",     "Buzz",      "Fizz",  "7",     "8",     "Fizz",  "Buzz",
        "11",    "Fizz",  "13",    "14",    "FizzBuzz",  "16",    "17",    "Fizz",  "19",    "Buzz",
        "Fizz",  "22",    "23",    "Fizz",  "Buzz",      "26",    "Fizz",  "28",    "29",    "FizzBuzz",
        "31",    "32",    "Fizz",  "34",    "Buzz",      "Fizz",  "37",    "38",    "Fizz",  "Buzz",
        "41",    "Fizz",  "43",    "44",    "FizzBuzz",  "46",    "47",    "Fizz",  "49",    "Buzz",
        "Fizz",  "52",    "53",    "Fizz",  "Buzz",      "56",    "Fizz",  "58",    "59",    "FizzBuzz",
        "61",    "62",    "Fizz",  "64",    "Buzz",      "Fizz",  "67",    "68",    "Fizz",  "Buzz",
        "71",    "Fizz",  "73",    "74",    "FizzBuzz",  "76",    "77",    "Fizz",  "79",    "Buzz",
        "Fizz",  "82",    "83",    "Fizz",  "Buzz",      "86",    "Fizz",  "88",    "89",    "FizzBuzz",
        "91",    "92",    "Fizz",  "94",    "Buzz",      "Fizz",  "97",    "98",    "Fizz",  "Buzz"]
    ~=? map fizzBuzz [1..100]]

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

