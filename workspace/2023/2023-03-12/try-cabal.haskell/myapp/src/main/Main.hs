module Main where

import NumericalSequence

main :: IO ()
main = do
    print $ map factorial [1..10]
    print $ map fibonacci [1..10]

