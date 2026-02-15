module BinarySearchTreeTest where

import BinarySearchTree ()
import BinarySearchTree (append)
import BinarySearchTree (appends)
import BinarySearchTree (fromValue)
import BinarySearchTree (fromValues)
import BinarySearchTree (parseNonEmptyTree)
import BinarySearchTree (popMax)
import BinarySearchTree (popMin)
import BinarySearchTree (toList)
import BinarySearchTree (Tree (EmptyTree))
import BinarySearchTree (Tree (Node))
import BinarySearchTree (Tree (nodeLeft))
import BinarySearchTree (Tree (nodeRight))
import BinarySearchTree (Tree (nodeValue))
import BinarySearchTree (Tree)
import Data.List (permutations)
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (Test)
import TestUtils ((==>))
import TestUtils (testsFromActualExpectedPairs)
import TestUtils (testsFromArgumentExpectedPairs)

main ::
    IO ()
main =
    runTestTTAndExit allTests

tree1 ::
    Tree Int
tree1 =
    Node 5 EmptyTree EmptyTree

tree2 ::
    Tree Int
tree2 =
    Node 5 (Node 3 EmptyTree EmptyTree)
           (Node 7 EmptyTree EmptyTree)

tree3 ::
    Tree Int
tree3 =
    Node 5 (Node 3 (Node 1 EmptyTree EmptyTree)
                   (Node 4 EmptyTree EmptyTree))
           (Node 7 (Node 6 EmptyTree EmptyTree)
                   (Node 9 EmptyTree EmptyTree))

allTests ::
    Test
allTests =
    TestList [
        parseNonEmptyTreeTests,
        fromValueTests,
        fromValuesTests,
        appendTests,
        appendsTests,
        toListTests,
        fmapTreeTests]

parseNonEmptyTreeTests ::
    Test
parseNonEmptyTreeTests =
    testsFromArgumentExpectedPairs "parseNonEmptyTree" parseNonEmptyTree [
        EmptyTree ==> Nothing,
        tree1 ==> Just (nodeValue tree1, nodeLeft tree1, nodeRight tree1),
        tree2 ==> Just (nodeValue tree2, nodeLeft tree2, nodeRight tree2),
        tree3 ==> Just (nodeValue tree3, nodeLeft tree3, nodeRight tree3)]

fromValueTests ::
    Test
fromValueTests =
    testsFromArgumentExpectedPairs "fromValue" fromValue [
        1 ==> Node 1 EmptyTree EmptyTree,
        2 ==> Node 2 EmptyTree EmptyTree,
        3 ==> Node 3 EmptyTree EmptyTree]

fromValuesTests ::
    Test
fromValuesTests =
    testsFromArgumentExpectedPairs "fromValues" fromValues [
        [] ==> EmptyTree,
        [5] ==> tree1,
        [5, 3, 7] ==> tree2,
        [5, 3, 7, 4, 6, 1, 9] ==> tree3]

appendTests ::
    Test
appendTests =
    testsFromActualExpectedPairs "append" [
        append EmptyTree 5 ==>
            Node 5 EmptyTree EmptyTree,
        append (Node 5 EmptyTree EmptyTree) 3 ==>
            Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
        append (Node 5 EmptyTree EmptyTree) 7 ==>
            Node 5 EmptyTree (Node 7 EmptyTree EmptyTree)]

appendsTests ::
    Test
appendsTests =
    let
        pairsList = [
            map (\tree -> appends tree [] ==> tree) [EmptyTree, tree1, tree2, tree3],
            map (\xs -> appends EmptyTree xs ==> tree1) (permutations [5]),
            map (\xs -> appends tree1 xs ==> tree2) (permutations [3, 7]),
            map (\xs -> appends tree2 xs ==> tree3) (permutations [1, 4, 6, 9])]
        pairs = foldl (++) [] pairsList
    in
        testsFromActualExpectedPairs "appends" pairs

toListTests ::
    Test
toListTests =
    testsFromActualExpectedPairs "toList" [
        toList popMin EmptyTree ==> [],
        toList popMin tree1 ==> [5],
        toList popMin tree2 ==> [3, 5, 7],
        toList popMin tree3 ==> [1, 3, 4, 5, 6, 7, 9],
        toList popMax EmptyTree ==> [],
        toList popMax tree1 ==> [5],
        toList popMax tree2 ==> [7, 5, 3],
        toList popMax tree3 ==> [9, 7, 6, 5, 4, 3, 1]]

fmapTreeTests ::
    Test
fmapTreeTests =
    testsFromActualExpectedPairs "fmap Tree" [
        fmap (+1) EmptyTree ==>
            EmptyTree,
        fmap (+1) tree1 ==>
            Node 6 EmptyTree EmptyTree,
        fmap (+1) tree2 ==>
            Node 6 (Node 4 EmptyTree EmptyTree)
                   (Node 8 EmptyTree EmptyTree),
        fmap (+1) tree3 ==>
            Node 6 (Node 4 (Node 2 EmptyTree EmptyTree)
                           (Node 5 EmptyTree EmptyTree))
                   (Node 8 (Node 7 EmptyTree EmptyTree)
                           (Node 10 EmptyTree EmptyTree)),
        fmap (*10) tree3 ==>
            Node 50 (Node 30 (Node 10 EmptyTree EmptyTree)
                             (Node 40 EmptyTree EmptyTree))
                    (Node 70 (Node 60 EmptyTree EmptyTree)
                             (Node 90 EmptyTree EmptyTree))]

