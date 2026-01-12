{- cabal:
    build-depends: base, HUnit
-}

import Data.List
import Test.HUnit

main :: IO ()
main = do
    runTestTT allTestList
    pure ()

allTestList = TestList [
    containsTestList,
    isSetTestList,
    isSubsetTestList,
    setEqualTestList,
    setUnionTestList,
    setDifferenceTestList,
    setIntersectionTestList]

contains :: Int -> [Int] -> Bool
contains _ [] = False
contains value (x:xs)
    | value == x = True
    | otherwise  = contains value xs

containsTestList = test [
    "contains" ~: "#1" ~: False ~=? (contains 0 []),
    "contains" ~: "#2" ~: False ~=? (contains 0 [1..3]),
    "contains" ~: "#3" ~: True  ~=? (contains 1 [1..3]),
    "contains" ~: "#4" ~: True  ~=? (contains 3 [1..3]),
    "contains" ~: "#5" ~: False ~=? (contains 4 [1..3])]

isSet :: [Int] -> Bool
isSet [] = True
isSet (x:xs)
    | contains x xs = False
    | otherwise     = isSet xs

isSetTestList = test [
    "isSet" ~: "#1" ~: True  ~=? (isSet []),
    "isSet" ~: "#2" ~: True  ~=? (isSet [1]),
    "isSet" ~: "#3" ~: True  ~=? (isSet [1, 2, 3]),
    "isSet" ~: "#4" ~: False ~=? (isSet [1, 1]),
    "isSet" ~: "#5" ~: False ~=? (isSet [1, 2, 3, 2, 1])]

isSubset :: [Int] -> [Int] -> Bool
isSubset [] ys = True
isSubset xs [] = False
isSubset (x:xs) ys
    | contains x ys = isSubset xs ys
    | otherwise     = False

isSubsetTestList = test [
    "isSubset" ~: "#1" ~: True  ~=? (isSubset [] []),
    "isSubset" ~: "#2" ~: True  ~=? (isSubset [] [1]),
    "isSubset" ~: "#3" ~: False ~=? (isSubset [1] []),
    "isSubset" ~: "#4" ~: True  ~=? (isSubset [1, 2, 3] [1, 2, 3]),
    "isSubset" ~: "#5" ~: False ~=? (isSubset [1, 2, 3] [2, 3, 4]),
    "isSubset" ~: "#6" ~: False ~=? (isSubset [1, 2, 3] [3, 4, 5]),
    "isSubset" ~: "#7" ~: False ~=? (isSubset [1, 2, 3] [4, 5, 6])]

setEqual :: [Int] -> [Int] -> Bool
setEqual set1 set2 = and [
    (isSubset set1 set2),
    (isSubset set2 set1)]

setEqualTestList = test [
    "setEqual" ~: "#1" ~: True  ~=? (setEqual [] []),
    "setEqual" ~: "#2" ~: False ~=? (setEqual [1] []),
    "setEqual" ~: "#3" ~: False ~=? (setEqual [] [1]),
    "setEqual" ~: "#4" ~: True  ~=? (setEqual [1] [1]),
    "setEqual" ~: "#5" ~: True  ~=? (setEqual [1, 2, 3] [1, 2, 3]),
    "setEqual" ~: "#6" ~: False ~=? (setEqual [1, 2, 3] [2, 3, 4]),
    "setEqual" ~: "#7" ~: False ~=? (setEqual [1, 2, 3] [3, 4, 5]),
    "setEqual" ~: "#8" ~: False ~=? (setEqual [1, 2, 3] [4, 5, 6])]

setUnion :: [Int] -> [Int] -> [Int]
setUnion set1 [] = set1
setUnion union (x:xs)
    | contains x union = setUnion union xs
    | otherwise        = setUnion (x:union) xs

setUnionTestList = test [
    "setUnion" ~: "#1" ~: [] ~=? (sort $ setUnion [] []),
    "setUnion" ~: "#2" ~: [1] ~=? (sort $ setUnion [1] []),
    "setUnion" ~: "#3" ~: [1] ~=? (sort $ setUnion [] [1]),
    "setUnion" ~: "#4" ~: [1] ~=? (sort $ setUnion [1] [1]),
    "setUnion" ~: "#5" ~: [1, 2, 3] ~=? (sort $ setUnion [1, 2, 3] [1, 2, 3]),
    "setUnion" ~: "#6" ~: [1, 2, 3, 4] ~=? (sort $ setUnion [1, 2, 3] [2, 3, 4]),
    "setUnion" ~: "#7" ~: [1, 2, 3, 4, 5] ~=? (sort $ setUnion [1, 2, 3] [3, 4, 5]),
    "setUnion" ~: "#8" ~: [1, 2, 3, 4, 5, 6] ~=? (sort $ setUnion [1, 2, 3] [4, 5, 6])]

setDifference :: [Int] -> [Int] -> [Int]
setDifference set1 set2 = setDifference' [] set1 set2
    where
        setDifference' :: [Int] -> [Int] -> [Int] -> [Int]
        setDifference' difference [] _ = difference
        setDifference' difference (x:xs) set
            | contains x set = setDifference' difference xs set
            | otherwise      = setDifference' (x:difference) xs set

setDifferenceTestList = test [
    "setDifference" ~: "#1" ~: [] ~=? (sort $ setDifference [] []),
    "setDifference" ~: "#2" ~: [1] ~=? (sort $ setDifference [1] []),
    "setDifference" ~: "#3" ~: [] ~=? (sort $ setDifference [] [1]),
    "setDifference" ~: "#4" ~: [] ~=? (sort $ setDifference [1] [1]),
    "setDifference" ~: "#5" ~: [] ~=? (sort $ setDifference [1, 2, 3] [1, 2, 3]),
    "setDifference" ~: "#6" ~: [1] ~=? (sort $ setDifference [1, 2, 3] [2, 3, 4]),
    "setDifference" ~: "#7" ~: [1, 2] ~=? (sort $ setDifference [1, 2, 3] [3, 4, 5]),
    "setDifference" ~: "#8" ~: [1, 2, 3] ~=? (sort $ setDifference [1, 2, 3] [4, 5, 6])]

setIntersection :: [Int] -> [Int] -> [Int]
setIntersection set1 set2 = setIntersection' [] set1 set2
    where
        setIntersection' :: [Int] -> [Int] -> [Int] -> [Int]
        setIntersection' intersection [] _ = intersection
        setIntersection' intersection (x:xs) set
            | contains x set = setIntersection' (x:intersection) xs set
            | otherwise      = setIntersection' intersection xs set

setIntersectionTestList = test [
    "setIntersection" ~: "#1" ~: [] ~=? (sort $ setIntersection [] []),
    "setIntersection" ~: "#2" ~: [] ~=? (sort $ setIntersection [1] []),
    "setIntersection" ~: "#3" ~: [] ~=? (sort $ setIntersection [] [1]),
    "setIntersection" ~: "#4" ~: [1] ~=? (sort $ setIntersection [1] [1]),
    "setIntersection" ~: "#5" ~: [1, 2, 3] ~=? (sort $ setIntersection [1, 2, 3] [1, 2, 3]),
    "setIntersection" ~: "#6" ~: [2, 3] ~=? (sort $ setIntersection [1, 2, 3] [2, 3, 4]),
    "setIntersection" ~: "#7" ~: [3] ~=? (sort $ setIntersection [1, 2, 3] [3, 4, 5]),
    "setIntersection" ~: "#8" ~: [] ~=? (sort $ setIntersection [1, 2, 3] [4, 5, 6])]

