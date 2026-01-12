module Main where

import Test.HUnit
import NumericalSequence

main :: IO ()
main = do
    _ <- runTestTT allTestList
    pure ()

allTestList :: Test
allTestList = TestList [
    factorialTestList,
    fibonacciTestList]

factorialTestList :: Test
factorialTestList = test [
    "factorial"
    ~: "#1"
    ~: [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800]
    ~=? map factorial [0..10]]

fibonacciTestList :: Test
fibonacciTestList = test [
    "fibonacci"
    ~: "#1"
    ~: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    ~=? map fibonacci [0..10]]

