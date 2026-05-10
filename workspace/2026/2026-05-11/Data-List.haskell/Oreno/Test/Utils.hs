module Oreno.Test.Utils where

import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (test)
import Test.HUnit (Test)
import Text.Printf (printf)

infix 1 ==>
(==>) :: (Eq a, Show a) => a -> a -> Test
(==>) = (~?=)

testsFromActualExpectedPairs :: String -> [Test] -> Test
testsFromActualExpectedPairs label assertions =
    let
        labels = map mapper ns
            where
                ns = [1..] :: [Int]
                mapper n = printf "%s #%d" label n
        tests = zipWith zipper labels assertions
            where
                zipper label assertion = label ~: assertion
    in
        test tests

