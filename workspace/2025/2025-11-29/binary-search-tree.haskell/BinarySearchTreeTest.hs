module BinarySearchTreeTest where

import BinarySearchTree
import Data.List (permutations)
import Test.HUnit (Test (TestList))
import Test.HUnit (Test)
import TestUtils ((==>))
import TestUtils (testsFromActualExpectedPairs)
import TestUtils (testsFromArgumentsExpectedPairs)

allTests :: Test
allTests = TestList [
    appendTests,
    appendsTests,
    fromValueTests,
    fromValuesTests,
    toListTests,
    fmapTreeTests]

tree0 :: Tree Int
tree0 = EmptyTree

tree1 :: Tree Int
tree1 = Node 5 EmptyTree EmptyTree

tree2 :: Tree Int
tree2 = Node 5 (Node 3 EmptyTree EmptyTree)
               (Node 7 EmptyTree EmptyTree)

tree3 :: Tree Int
tree3 = Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                       (Node 4 EmptyTree EmptyTree))
               (Node 7 (Node 6 EmptyTree EmptyTree)
                       (Node 9 EmptyTree EmptyTree))

appendTests :: Test
appendTests = testsFromActualExpectedPairs "append" [
    append EmptyTree 1 ==> Node 1 EmptyTree EmptyTree,
    append EmptyTree 2 ==> Node 2 EmptyTree EmptyTree,
    append EmptyTree 3 ==> Node 3 EmptyTree EmptyTree,
    append tree1 3 ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
    append tree1 7 ==> Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)]

appendsTests :: Test
appendsTests =
    let
        pairs = foldl (++) [] [
            map (\tree -> appends tree [] ==> tree) [tree0, tree1, tree2],
            map (\xs -> appends tree0 xs ==> tree1) (permutations [5]),
            map (\xs -> appends tree1 xs ==> tree2) (permutations [3, 7]),
            map (\xs -> appends tree2 xs ==> tree3) (permutations [1, 4, 6, 9])]
    in
        testsFromActualExpectedPairs "appends" pairs

fromValueTests :: Test
fromValueTests = testsFromArgumentsExpectedPairs "fromValue" fromValue [
    1 ==> Node 1 EmptyTree EmptyTree,
    2 ==> Node 2 EmptyTree EmptyTree,
    3 ==> Node 3 EmptyTree EmptyTree]

fromValuesTests :: Test
fromValuesTests = testsFromArgumentsExpectedPairs "fromValues" fromValues [
    [] ==> tree0,
    [5] ==> tree1,
    [5, 3, 7] ==> tree2,
    [5, 3, 7, 1, 4, 6, 9] ==> tree3]

toListTests :: Test
toListTests = testsFromActualExpectedPairs "toList" [
    toList popMin tree0 ==> [],
    toList popMin tree1 ==> [5],
    toList popMin tree2 ==> [3, 5, 7],
    toList popMin tree3 ==> [1, 3, 4, 5, 6, 7, 9],
    toList popMax tree0 ==> [],
    toList popMax tree1 ==> [5],
    toList popMax tree2 ==> [7, 5, 3],
    toList popMax tree3 ==> [9, 7, 6, 5, 4, 3, 1]]

fmapTreeTests :: Test
fmapTreeTests = testsFromActualExpectedPairs "fmap Tree" [
    fmap (+1) tree0 ==> EmptyTree,
    fmap (+1) tree1 ==> Node 6 EmptyTree EmptyTree,
    fmap (+1) tree2 ==> Node 6 (Node 4 EmptyTree EmptyTree)
                               (Node 8 EmptyTree EmptyTree),
    fmap (*10) tree3 ==> Node 50 (Node 30 (Node 10 EmptyTree EmptyTree)
                                          (Node 40 EmptyTree EmptyTree))
                                 (Node 70 (Node 60 EmptyTree EmptyTree)
                                          (Node 90 EmptyTree EmptyTree))]
