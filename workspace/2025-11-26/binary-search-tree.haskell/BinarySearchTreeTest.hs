import BinarySearchTree
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (Test)
import TestUtils ((==>))
import TestUtils (testsFromActualExpectedPairs)
import TestUtils (testsFromArgumentsExpectedPairs)

main :: IO ()
main = runTestTTAndExit allTests

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

allTests = TestList [
    fromValueTests,
    fromValuesTests,
    appendTests,
    toListTests]

fromValueTests = testsFromArgumentsExpectedPairs "fromValue" fromValue [
    1 ==> Node 1 EmptyTree EmptyTree,
    2 ==> Node 2 EmptyTree EmptyTree,
    3 ==> Node 3 EmptyTree EmptyTree]

fromValuesTests = testsFromArgumentsExpectedPairs "fromValues" fromValues [
    -- tree0
    [] ==> tree0,
    -- tree1
    [5] ==> tree1,
    -- tree2
    [5, 3, 7] ==> tree2,
    [5, 7, 3] ==> tree2,
    -- tree3
    [5, 3, 1, 4, 7, 6, 9] ==> tree3,
    [5, 3, 1, 4, 7, 9, 6] ==> tree3,
    [5, 3, 1, 7, 4, 6, 9] ==> tree3,
    [5, 3, 1, 7, 4, 9, 6] ==> tree3,
    [5, 3, 1, 7, 6, 4, 9] ==> tree3,
    [5, 3, 1, 7, 6, 9, 4] ==> tree3,
    [5, 3, 1, 7, 9, 4, 6] ==> tree3,
    [5, 3, 1, 7, 9, 6, 4] ==> tree3,
    [5, 3, 4, 1, 7, 6, 9] ==> tree3,
    [5, 3, 4, 1, 7, 9, 6] ==> tree3,
    [5, 3, 4, 7, 1, 6, 9] ==> tree3,
    [5, 3, 4, 7, 1, 9, 6] ==> tree3,
    [5, 3, 4, 7, 6, 1, 9] ==> tree3,
    [5, 3, 4, 7, 6, 9, 1] ==> tree3,
    [5, 3, 4, 7, 9, 1, 6] ==> tree3,
    [5, 3, 4, 7, 9, 6, 1] ==> tree3,
    [5, 3, 7, 1, 4, 6, 9] ==> tree3,
    [5, 3, 7, 1, 4, 9, 6] ==> tree3,
    [5, 3, 7, 1, 6, 4, 9] ==> tree3,
    [5, 3, 7, 1, 6, 9, 4] ==> tree3,
    [5, 3, 7, 1, 9, 4, 6] ==> tree3,
    [5, 3, 7, 1, 9, 6, 4] ==> tree3,
    [5, 3, 7, 4, 1, 6, 9] ==> tree3,
    [5, 3, 7, 4, 1, 9, 6] ==> tree3,
    [5, 3, 7, 4, 6, 1, 9] ==> tree3,
    [5, 3, 7, 4, 6, 9, 1] ==> tree3,
    [5, 3, 7, 4, 9, 1, 6] ==> tree3,
    [5, 3, 7, 4, 9, 6, 1] ==> tree3,
    [5, 3, 7, 6, 1, 4, 9] ==> tree3,
    [5, 3, 7, 6, 1, 9, 4] ==> tree3,
    [5, 3, 7, 6, 4, 1, 9] ==> tree3,
    [5, 3, 7, 6, 4, 9, 1] ==> tree3,
    [5, 3, 7, 6, 9, 1, 4] ==> tree3,
    [5, 3, 7, 6, 9, 4, 1] ==> tree3,
    [5, 3, 7, 9, 1, 4, 6] ==> tree3,
    [5, 3, 7, 9, 1, 6, 4] ==> tree3,
    [5, 3, 7, 9, 4, 1, 6] ==> tree3,
    [5, 3, 7, 9, 4, 6, 1] ==> tree3,
    [5, 3, 7, 9, 6, 1, 4] ==> tree3,
    [5, 3, 7, 9, 6, 4, 1] ==> tree3,
    [5, 7, 3, 1, 4, 6, 9] ==> tree3,
    [5, 7, 3, 1, 4, 9, 6] ==> tree3,
    [5, 7, 3, 1, 6, 4, 9] ==> tree3,
    [5, 7, 3, 1, 6, 9, 4] ==> tree3,
    [5, 7, 3, 1, 9, 4, 6] ==> tree3,
    [5, 7, 3, 1, 9, 6, 4] ==> tree3,
    [5, 7, 3, 4, 1, 6, 9] ==> tree3,
    [5, 7, 3, 4, 1, 9, 6] ==> tree3,
    [5, 7, 3, 4, 6, 1, 9] ==> tree3,
    [5, 7, 3, 4, 6, 9, 1] ==> tree3,
    [5, 7, 3, 4, 9, 1, 6] ==> tree3,
    [5, 7, 3, 4, 9, 6, 1] ==> tree3,
    [5, 7, 3, 6, 1, 4, 9] ==> tree3,
    [5, 7, 3, 6, 1, 9, 4] ==> tree3,
    [5, 7, 3, 6, 4, 1, 9] ==> tree3,
    [5, 7, 3, 6, 4, 9, 1] ==> tree3,
    [5, 7, 3, 6, 9, 1, 4] ==> tree3,
    [5, 7, 3, 6, 9, 4, 1] ==> tree3,
    [5, 7, 3, 9, 1, 4, 6] ==> tree3,
    [5, 7, 3, 9, 1, 6, 4] ==> tree3,
    [5, 7, 3, 9, 4, 1, 6] ==> tree3,
    [5, 7, 3, 9, 4, 6, 1] ==> tree3,
    [5, 7, 3, 9, 6, 1, 4] ==> tree3,
    [5, 7, 3, 9, 6, 4, 1] ==> tree3,
    [5, 7, 6, 3, 1, 4, 9] ==> tree3,
    [5, 7, 6, 3, 1, 9, 4] ==> tree3,
    [5, 7, 6, 3, 4, 1, 9] ==> tree3,
    [5, 7, 6, 3, 4, 9, 1] ==> tree3,
    [5, 7, 6, 3, 9, 1, 4] ==> tree3,
    [5, 7, 6, 3, 9, 4, 1] ==> tree3,
    [5, 7, 6, 9, 3, 1, 4] ==> tree3,
    [5, 7, 6, 9, 3, 4, 1] ==> tree3,
    [5, 7, 9, 3, 1, 4, 6] ==> tree3,
    [5, 7, 9, 3, 1, 6, 4] ==> tree3,
    [5, 7, 9, 3, 4, 1, 6] ==> tree3,
    [5, 7, 9, 3, 4, 6, 1] ==> tree3,
    [5, 7, 9, 3, 6, 1, 4] ==> tree3,
    [5, 7, 9, 3, 6, 4, 1] ==> tree3,
    [5, 7, 9, 6, 3, 1, 4] ==> tree3,
    [5, 7, 9, 6, 3, 4, 1] ==> tree3]

appendTests = testsFromActualExpectedPairs "append" [
    -- tree0
    append tree0 1 ==> Node 1 EmptyTree EmptyTree,
    append tree0 2 ==> Node 2 EmptyTree EmptyTree,
    append tree0 3 ==> Node 3 EmptyTree EmptyTree,
    -- tree1
    append tree1 3 ==> Node 5 (Node 3 EmptyTree EmptyTree) EmptyTree,
    append tree1 7 ==> Node 5 EmptyTree (Node 7 EmptyTree EmptyTree),
    -- tree2
    append tree2 1 ==>
        Node 5 (Node 3 (Node 1 EmptyTree EmptyTree) EmptyTree)
               (Node 7 EmptyTree EmptyTree),
    append tree2 4 ==>
        Node 5 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
               (Node 7 EmptyTree EmptyTree),
    append tree2 6 ==>
        Node 5 (Node 3 EmptyTree EmptyTree)
               (Node 7 (Node 6 EmptyTree EmptyTree) EmptyTree),
    append tree2 9 ==>
        Node 5 (Node 3 EmptyTree EmptyTree)
               (Node 7 EmptyTree (Node 9 EmptyTree EmptyTree))]

toListTests = testsFromActualExpectedPairs "toList" [
    -- popMin
    toList popMin (fromValues []) ==> [],
    toList popMin (fromValues [5]) ==> [5],
    toList popMin (fromValues [5, 3]) ==> [3, 5],
    toList popMin (fromValues [5, 3, 7]) ==> [3, 5, 7],
    toList popMin (fromValues [5, 3, 7, 1]) ==> [1, 3, 5, 7],
    toList popMin (fromValues [5, 3, 7, 1, 4]) ==> [1, 3, 4, 5, 7],
    toList popMin (fromValues [5, 3, 7, 1, 4, 6]) ==> [1, 3, 4, 5, 6, 7],
    toList popMin (fromValues [5, 3, 7, 1, 4, 6, 9]) ==> [1, 3, 4, 5, 6, 7, 9],
    -- popMax
    toList popMax (fromValues [5]) ==> [5],
    toList popMax (fromValues [5, 3]) ==> [5, 3],
    toList popMax (fromValues [5, 3, 7]) ==> [7, 5, 3],
    toList popMax (fromValues [5, 3, 7, 1]) ==> [7, 5, 3, 1],
    toList popMax (fromValues [5, 3, 7, 1, 4]) ==> [7, 5, 4, 3, 1],
    toList popMax (fromValues [5, 3, 7, 1, 4, 6]) ==> [7, 6, 5, 4, 3, 1],
    toList popMax (fromValues [5, 3, 7, 1, 4, 6, 9]) ==> [9, 7, 6, 5, 4, 3, 1]]

