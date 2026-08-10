module BinarySearchTreeTest where

import BinarySearchTree (append)
import BinarySearchTree (appends)
import BinarySearchTree (fromValue)
import BinarySearchTree (fromValues)
import BinarySearchTree (popMax)
import BinarySearchTree (popMin)
import BinarySearchTree (toList)
import BinarySearchTree (Tree (EmptyTree))
import BinarySearchTree (Tree (Node))
import Data.List (permutations)
import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (test)
import Test.HUnit (Test)
import Text.Printf (printf)

main ::
    IO ()
main =
    runTestTTAndExit allTests

allTests ::
    Test
allTests =
    TestList [fromValueTests,
              fromValuesTests,
              appendTests,
              appendsTests,
              toListTests]

labelledTests ::
    String -> [Test] -> Test
labelledTests label unlabelledTests =
    let
        labels = map mapper ns
            where
                ns = [1..] :: [Int]
                mapper n = printf "%s #%d" label n
        tests = zipWith zipper labels unlabelledTests
            where
                zipper label unlabelledTest = label ~: unlabelledTest
    in
        test tests

tree0 ::
    Tree Int
tree0 =
    EmptyTree

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

fromValueTests ::
    Test
fromValueTests =
    labelledTests "fromValue" [
        fromValue 1 ~?= Node 1 EmptyTree EmptyTree,
        fromValue 2 ~?= Node 2 EmptyTree EmptyTree,
        fromValue 3 ~?= Node 3 EmptyTree EmptyTree]

fromValuesTests ::
    Test
fromValuesTests =
    labelledTests "fromValues" [
        fromValues ([] :: [Int])         ~?= EmptyTree,
        fromValues [5]                   ~?= tree1,
        fromValues [5, 3, 7]             ~?= tree2,
        fromValues [5, 3, 7, 4, 6, 1, 9] ~?= tree3]

appendTests ::
    Test
appendTests =
    labelledTests "append" [
        append EmptyTree 1 ~?=
            Node 1 EmptyTree EmptyTree,
        append EmptyTree 2 ~?=
            Node 2 EmptyTree EmptyTree,
        append EmptyTree 3 ~?=
            Node 3 EmptyTree EmptyTree]

appendsTests ::
    Test
appendsTests =
    let
        assertionsList = [
            map (\tree -> appends tree [] ~?= tree) [tree0, tree1, tree2, tree3],
            map (\xs -> appends tree0 xs ~?= tree1) (permutations [5]),
            map (\xs -> appends tree1 xs ~?= tree2) (permutations [3, 7]),
            map (\xs -> appends tree2 xs ~?= tree3) (permutations [1, 4, 6, 9])]
        assertions = foldl (++) [] assertionsList
    in
        labelledTests "appends" assertions

toListTests ::
    Test
toListTests =
    labelledTests "toList" [
        toList popMin tree0 ~?= [],
        toList popMin tree1 ~?= [5],
        toList popMin tree2 ~?= [3, 5, 7],
        toList popMin tree3 ~?= [1, 3, 4, 5, 6, 7, 9],
        toList popMax tree0 ~?= [],
        toList popMax tree1 ~?= [5],
        toList popMax tree2 ~?= [7, 5, 3],
        toList popMax tree3 ~?= [9, 7, 6, 5, 4, 3, 1]]

