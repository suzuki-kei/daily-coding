module TestUtils where

import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (test)
import Test.HUnit (Test)
import Text.Printf (printf)

infix 1 ==>
(==>) ::
    a -> b -> (a, b)
(==>) a b =
    (a, b)

testsFromActualExpectedPairs ::
    (Eq a, Show a) => String -> [(a, a)] -> Test
testsFromActualExpectedPairs label pairs =
    test tests
        where
            labels = map mapper ns
                where
                    mapper = \n -> printf "%s #%d" label n
                    ns = [1..] :: [Int]
            tests = zipWith zipper labels pairs
                where
                    zipper = \label (actual, expected) -> label ~: actual ~?= expected

testsFromArgumentExpectedPairs ::
    (Eq b, Show b) => String -> (a -> b) -> [(a, b)] -> Test
testsFromArgumentExpectedPairs label f pairs =
    let
        mapper = \(argument, expected) -> (f argument, expected)
        pairs' = map mapper pairs
    in
        testsFromActualExpectedPairs label pairs'

