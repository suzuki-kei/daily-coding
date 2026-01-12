module BinarySearchTreeTest where

import BinarySearchTree
import Test.HUnit ((~:))
import Test.HUnit ((~=?))
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (test)
import Text.Printf (printf)

main :: IO ()
main = runTestTTAndExit allTests

infix 1 ==>
(==>) :: a -> b -> (a, b)
(==>) a b = (a, b)

testsFromActualExpectedPairs :: (Show a, Eq a) => String -> [(a, a)] -> Test
testsFromActualExpectedPairs label pairs =
    let
        ns     = [1..] :: [Int]
        labels = map (\n -> printf "%s #%d" label n) ns
        zipper = \label (actual, expected) -> label ~: actual ~=? expected
        tests  = zipWith zipper labels pairs
    in
        test tests

testsFromArgumentsExpectedPairs :: (Show b, Eq b) => String -> (a -> b) -> [(a, b)] -> Test
testsFromArgumentsExpectedPairs label f pairs =
    let
        mapper = \(arguments, expected) -> (f arguments, expected)
        pairs' = map mapper pairs
    in
        testsFromActualExpectedPairs label pairs'

allTests :: Test
allTests = TestList [
    fromValueTests,
    fromValuesTests,
    appendTests,
    appendsTests,
    toListTests,
    popMinTests,
    popMaxTests,
    fmapTreeTests]

fromValueTests :: Test
fromValueTests = testsFromArgumentsExpectedPairs "fromValue" fromValue [
    1 ==> Node 1 EmptyTree EmptyTree,
    2 ==> Node 2 EmptyTree EmptyTree,
    3 ==> Node 3 EmptyTree EmptyTree]

fromValuesTests :: Test
fromValuesTests =
    let
        expected2 = Node 5 (Node 3 EmptyTree EmptyTree)
                           (Node 7 EmptyTree EmptyTree)
        expected3 = Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                                   (Node 4 EmptyTree EmptyTree))
                           (Node 7 (Node 6 EmptyTree EmptyTree)
                                   (Node 9 EmptyTree EmptyTree))
    in
        testsFromArgumentsExpectedPairs "fromValues" fromValues [
            -- depth=0
            [] ==> EmptyTree,

            -- depth=1
            [1] ==> Node 1 EmptyTree EmptyTree,
            [2] ==> Node 2 EmptyTree EmptyTree,
            [3] ==> Node 3 EmptyTree EmptyTree,

            -- depth=2
            [5, 3, 7] ==> expected2,
            [5, 7, 3] ==> expected2,

            -- depth=3
            [5, 3, 1, 4, 7, 6, 9] ==> expected3,
            [5, 3, 1, 4, 7, 9, 6] ==> expected3,
            [5, 3, 1, 7, 4, 6, 9] ==> expected3,
            [5, 3, 1, 7, 4, 9, 6] ==> expected3,
            [5, 3, 1, 7, 6, 4, 9] ==> expected3,
            [5, 3, 1, 7, 6, 9, 4] ==> expected3,
            [5, 3, 1, 7, 9, 4, 6] ==> expected3,
            [5, 3, 1, 7, 9, 6, 4] ==> expected3,
            [5, 3, 4, 1, 7, 6, 9] ==> expected3,
            [5, 3, 4, 1, 7, 9, 6] ==> expected3,
            [5, 3, 4, 7, 1, 6, 9] ==> expected3,
            [5, 3, 4, 7, 1, 9, 6] ==> expected3,
            [5, 3, 4, 7, 6, 1, 9] ==> expected3,
            [5, 3, 4, 7, 6, 9, 1] ==> expected3,
            [5, 3, 4, 7, 9, 1, 6] ==> expected3,
            [5, 3, 4, 7, 9, 6, 1] ==> expected3,
            [5, 3, 7, 1, 4, 6, 9] ==> expected3,
            [5, 3, 7, 1, 4, 9, 6] ==> expected3,
            [5, 3, 7, 1, 6, 4, 9] ==> expected3,
            [5, 3, 7, 1, 6, 9, 4] ==> expected3,
            [5, 3, 7, 1, 9, 4, 6] ==> expected3,
            [5, 3, 7, 1, 9, 6, 4] ==> expected3,
            [5, 3, 7, 4, 1, 6, 9] ==> expected3,
            [5, 3, 7, 4, 1, 9, 6] ==> expected3,
            [5, 3, 7, 4, 6, 1, 9] ==> expected3,
            [5, 3, 7, 4, 6, 9, 1] ==> expected3,
            [5, 3, 7, 4, 9, 1, 6] ==> expected3,
            [5, 3, 7, 4, 9, 6, 1] ==> expected3,
            [5, 3, 7, 6, 1, 4, 9] ==> expected3,
            [5, 3, 7, 6, 1, 9, 4] ==> expected3,
            [5, 3, 7, 6, 4, 1, 9] ==> expected3,
            [5, 3, 7, 6, 4, 9, 1] ==> expected3,
            [5, 3, 7, 6, 9, 1, 4] ==> expected3,
            [5, 3, 7, 6, 9, 4, 1] ==> expected3,
            [5, 3, 7, 9, 1, 4, 6] ==> expected3,
            [5, 3, 7, 9, 1, 6, 4] ==> expected3,
            [5, 3, 7, 9, 4, 1, 6] ==> expected3,
            [5, 3, 7, 9, 4, 6, 1] ==> expected3,
            [5, 3, 7, 9, 6, 1, 4] ==> expected3,
            [5, 3, 7, 9, 6, 4, 1] ==> expected3,
            [5, 7, 3, 1, 4, 6, 9] ==> expected3,
            [5, 7, 3, 1, 4, 9, 6] ==> expected3,
            [5, 7, 3, 1, 6, 4, 9] ==> expected3,
            [5, 7, 3, 1, 6, 9, 4] ==> expected3,
            [5, 7, 3, 1, 9, 4, 6] ==> expected3,
            [5, 7, 3, 1, 9, 6, 4] ==> expected3,
            [5, 7, 3, 4, 1, 6, 9] ==> expected3,
            [5, 7, 3, 4, 1, 9, 6] ==> expected3,
            [5, 7, 3, 4, 6, 1, 9] ==> expected3,
            [5, 7, 3, 4, 6, 9, 1] ==> expected3,
            [5, 7, 3, 4, 9, 1, 6] ==> expected3,
            [5, 7, 3, 4, 9, 6, 1] ==> expected3,
            [5, 7, 3, 6, 1, 4, 9] ==> expected3,
            [5, 7, 3, 6, 1, 9, 4] ==> expected3,
            [5, 7, 3, 6, 4, 1, 9] ==> expected3,
            [5, 7, 3, 6, 4, 9, 1] ==> expected3,
            [5, 7, 3, 6, 9, 1, 4] ==> expected3,
            [5, 7, 3, 6, 9, 4, 1] ==> expected3,
            [5, 7, 3, 9, 1, 4, 6] ==> expected3,
            [5, 7, 3, 9, 1, 6, 4] ==> expected3,
            [5, 7, 3, 9, 4, 1, 6] ==> expected3,
            [5, 7, 3, 9, 4, 6, 1] ==> expected3,
            [5, 7, 3, 9, 6, 1, 4] ==> expected3,
            [5, 7, 3, 9, 6, 4, 1] ==> expected3,
            [5, 7, 6, 3, 1, 4, 9] ==> expected3,
            [5, 7, 6, 3, 1, 9, 4] ==> expected3,
            [5, 7, 6, 3, 4, 1, 9] ==> expected3,
            [5, 7, 6, 3, 4, 9, 1] ==> expected3,
            [5, 7, 6, 3, 9, 1, 4] ==> expected3,
            [5, 7, 6, 3, 9, 4, 1] ==> expected3,
            [5, 7, 6, 9, 3, 1, 4] ==> expected3,
            [5, 7, 6, 9, 3, 4, 1] ==> expected3,
            [5, 7, 9, 3, 1, 4, 6] ==> expected3,
            [5, 7, 9, 3, 1, 6, 4] ==> expected3,
            [5, 7, 9, 3, 4, 1, 6] ==> expected3,
            [5, 7, 9, 3, 4, 6, 1] ==> expected3,
            [5, 7, 9, 3, 6, 1, 4] ==> expected3,
            [5, 7, 9, 3, 6, 4, 1] ==> expected3,
            [5, 7, 9, 6, 3, 1, 4] ==> expected3,
            [5, 7, 9, 6, 3, 4, 1] ==> expected3]

appendTests :: Test
appendTests = testsFromActualExpectedPairs "append" [
    append EmptyTree 1 ==> Node 1 EmptyTree EmptyTree,
    append EmptyTree 2 ==> Node 2 EmptyTree EmptyTree,
    append EmptyTree 3 ==> Node 3 EmptyTree EmptyTree,

    append (Node 5 EmptyTree EmptyTree) 3
        ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
    append (Node 5 EmptyTree EmptyTree) 7
        ==> Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)]

appendsTests :: Test
appendsTests = testsFromActualExpectedPairs "appends" [
    appends EmptyTree []
        ==> EmptyTree,
    appends EmptyTree [5, 3, 7, 1, 4, 6, 9]
        ==> Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                           (Node 4 EmptyTree EmptyTree))
                   (Node 7 (Node 6 EmptyTree EmptyTree)
                           (Node 9 EmptyTree EmptyTree))]

toListTests :: Test
toListTests = testsFromActualExpectedPairs "toList" [
    toList (fromValues []) ==> [],
    toList (fromValues [5]) ==> [5],
    toList (fromValues [5, 3]) ==> [3, 5],
    toList (fromValues [5, 3, 1]) ==> [1, 3, 5],
    toList (fromValues [5, 3, 1, 4]) ==> [1, 3, 4, 5],
    toList (fromValues [5, 3, 1, 4, 7]) ==> [1, 3, 4, 5, 7],
    toList (fromValues [5, 3, 1, 4, 7, 6]) ==> [1, 3, 4, 5, 6, 7],
    toList (fromValues [5, 3, 1, 4, 7, 6, 9]) ==> [1, 3, 4, 5, 6, 7, 9]]

popMinTests :: Test
popMinTests = testsFromArgumentsExpectedPairs "popMin" popMin [
    EmptyTree ==> Nothing,
    Node 1 EmptyTree EmptyTree ==> Just (1, EmptyTree),
    Node 2 EmptyTree EmptyTree ==> Just (2, EmptyTree),
    Node 3 EmptyTree EmptyTree ==> Just (3, EmptyTree),
    Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree ==> Just (3, Node 5 EmptyTree EmptyTree),
    Node 5 EmptyTree (Node 7 EmptyTree EmptyTree) ==> Just (5, Node 7 EmptyTree EmptyTree)]

popMaxTests :: Test
popMaxTests = testsFromArgumentsExpectedPairs "popMax" popMax [
    EmptyTree ==> Nothing,
    Node 1 EmptyTree EmptyTree ==> Just (1, EmptyTree),
    Node 2 EmptyTree EmptyTree ==> Just (2, EmptyTree),
    Node 3 EmptyTree EmptyTree ==> Just (3, EmptyTree),
    Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree ==> Just (5, Node 3 EmptyTree EmptyTree),
    Node 5 EmptyTree (Node 7 EmptyTree EmptyTree) ==> Just (7, Node 5 EmptyTree EmptyTree)]

fmapTreeTests :: Test
fmapTreeTests = testsFromActualExpectedPairs "fmap (Tree a)" [
    fmap (+1) EmptyTree
        ==> EmptyTree,
    fmap (+1) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree)))
        ==> Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                           (Node 5 EmptyTree EmptyTree))
                   (Node 8 (Node 7 EmptyTree EmptyTree)
                           (Node 10 EmptyTree EmptyTree)),
    fmap (*2) (Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                              (Node 4 EmptyTree EmptyTree))
                      (Node 7 (Node 6 EmptyTree EmptyTree)
                              (Node 9 EmptyTree EmptyTree)))
        ==> Node 10 (Node 6 (Node 2 EmptyTree EmptyTree)
                            (Node 8 EmptyTree EmptyTree))
                    (Node 14 (Node 12 EmptyTree EmptyTree)
                             (Node 18 EmptyTree EmptyTree))]

