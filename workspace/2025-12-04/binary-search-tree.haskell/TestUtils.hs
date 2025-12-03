module TestUtils where

import Test.HUnit ((~:))
import Test.HUnit ((~=?))
import Test.HUnit (test)
import Test.HUnit (Test)
import Text.Printf (printf)

infix 1 ==>
(==>) :: a -> b -> (a, b)
(==>) a b = (a, b)

testsFromActualExpectedPairs ::
    (Eq a, Show a) => String -> [(a, a)] -> Test
testsFromActualExpectedPairs label pairs =
    let
        ns     = [1..] :: [Int]
        mapper = \n -> printf "%s #%d" label n
        labels = map mapper ns
        zipper = \label (actual, expected) -> label ~: actual ~=? expected
        tests  = zipWith zipper labels pairs
    in
        test tests

testsFromArgumentsExpectedPairs ::
    (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
testsFromArgumentsExpectedPairs label f pairs =
    let
        mapper = \(arguments, expected) -> (f arguments, expected)
        pairs' = map mapper pairs
    in
        testsFromActualExpectedPairs label pairs'

