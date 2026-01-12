module BinarySearchTreeTest where

import BinarySearchTree
import Data.List (permutations)
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (Test)
import TestUtils ((==>))
import TestUtils (testsFromActualExpectedPairs)

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests = TestList [
    appendsTests,
    toListTests]

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

appendsTests :: Test
appendsTests =
    let
        pairs = foldl (++) [] [
            map (\tree -> (tree, appends tree [])) [tree0, tree1, tree2, tree3],
            map (\xs -> (tree1, appends tree0 xs)) (permutations [5]),
            map (\xs -> (tree2, appends tree1 xs)) (permutations [3, 7]),
            map (\xs -> (tree3, appends tree2 xs)) (permutations [1, 4, 6, 9])]
    in
        testsFromActualExpectedPairs "appends" pairs

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

