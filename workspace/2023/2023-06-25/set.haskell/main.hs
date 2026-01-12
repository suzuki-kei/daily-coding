{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit

main :: IO ()
main = do
    runTestTT allTestList
    pure ()

allTestList = TestList [
    includesTestList,
    makeSetTestList,
    isSetTestList,
    subsetTestList,
    setEqualsTestList,
    unionTestList,
    differenceTestList,
    intersectionTestList]

includes :: Int -> [Int] -> Bool
includes value [] = False
includes value (x:xs)
    | value == x = True
    | otherwise  = includes value xs

includesTestList = test [
    "includes" ~: "#1" ~: False ~=? includes 0 [],
    "includes" ~: "#2" ~: False ~=? includes 0 [1],
    "includes" ~: "#3" ~: True  ~=? includes 1 [1],
    "includes" ~: "#4" ~: False ~=? includes 2 [1],
    "includes" ~: "#5" ~: False ~=? includes 0 [1, 2, 3],
    "includes" ~: "#6" ~: True  ~=? includes 1 [1, 2, 3],
    "includes" ~: "#7" ~: True  ~=? includes 2 [1, 2, 3],
    "includes" ~: "#8" ~: True  ~=? includes 3 [1, 2, 3],
    "includes" ~: "#9" ~: False ~=? includes 4 [1, 2, 3]]

makeSet :: [Int] -> [Int]
makeSet [] = []
makeSet (x:xs)
    | x `includes` xs = makeSet xs
    | otherwise       = x : makeSet xs

makeSetTestList = test [
    "makeSet" ~: "#1" ~: []        ~=? makeSet [],
    "makeSet" ~: "#2" ~: [1]       ~=? makeSet [1],
    "makeSet" ~: "#3" ~: [1]       ~=? makeSet [1, 1],
    "makeSet" ~: "#4" ~: [1, 2, 3] ~=? makeSet [1, 1, 2, 3, 3]]

isSet :: [Int] -> Bool
isSet [] = True
isSet (x:xs)
    | x `includes` xs = False
    | otherwise       = isSet xs

isSetTestList = test [
    "isSet" ~: "#1" ~: True  ~=? isSet [],
    "isSet" ~: "#2" ~: True  ~=? isSet [1],
    "isSet" ~: "#3" ~: False ~=? isSet [1, 1],
    "isSet" ~: "#4" ~: True  ~=? isSet [1, 2, 3],
    "isSet" ~: "#5" ~: False ~=? isSet [1, 2, 3, 3]]

subset :: [Int] -> [Int] -> Bool
subset [] _ = True
subset (x:xs) set
    | x `includes` set = xs `subset` set
    | otherwise        = False

subsetTestList = test [
    "subset" ~:  "#1" ~: True  ~=? subset [] [],
    "subset" ~:  "#2" ~: False ~=? subset [1] [],
    "subset" ~:  "#3" ~: True  ~=? subset [] [1],
    "subset" ~:  "#4" ~: False ~=? subset [0] [1],
    "subset" ~:  "#5" ~: True  ~=? subset [1] [1],
    "subset" ~:  "#6" ~: False ~=? subset [2] [1],
    "subset" ~:  "#7" ~: True  ~=? subset [] [1, 2, 3],
    "subset" ~:  "#8" ~: True  ~=? subset [1] [1, 2, 3],
    "subset" ~:  "#9" ~: True  ~=? subset [1, 2] [1, 2, 3],
    "subset" ~: "#10" ~: True  ~=? subset [1, 2, 3] [1, 2, 3]]

setEquals :: [Int] -> [Int] -> Bool
setEquals set1 set2 = and [
    set1 `subset` set2,
    set2 `subset` set1]

setEqualsTestList = test [
    "setEquals" ~: "#1" ~: True  ~=? setEquals [] [],
    "setEquals" ~: "#2" ~: False ~=? setEquals [] [1],
    "setEquals" ~: "#3" ~: False ~=? setEquals [1] [],
    "setEquals" ~: "#4" ~: True  ~=? setEquals [1] [1],
    "setEquals" ~: "#5" ~: False ~=? setEquals [0, 1, 2] [1, 2, 3],
    "setEquals" ~: "#6" ~: True  ~=? setEquals [1, 2, 3] [1, 2, 3],
    "setEquals" ~: "#7" ~: False ~=? setEquals [2, 3, 4] [1, 2, 3],
    "setEquals" ~: "#8" ~: True ~=? setEquals [1, 2, 3] [3, 2, 1]]

union :: [Int] -> [Int] -> [Int]
union [] [] = []
union [] set2 = set2
union set1 [] = set1
union set1 (x:xs)
    | x `includes` set1 = union set1 xs
    | otherwise         = union (set1 ++ [x]) xs

unionTestList = test [
    "union" ~:  "#1" ~: []              ~=? union [] [],
    "union" ~:  "#2" ~: [1]             ~=? union [] [1],
    "union" ~:  "#3" ~: [1, 2]          ~=? union [] [1, 2],
    "union" ~:  "#4" ~: [1, 2, 3]       ~=? union [] [1, 2, 3],
    "union" ~:  "#5" ~: [1]             ~=? union [1] [],
    "union" ~:  "#6" ~: [1, 2]          ~=? union [1, 2] [],
    "union" ~:  "#7" ~: [1, 2, 3]       ~=? union [1, 2, 3] [],
    "union" ~:  "#8" ~: [1, 2, 3]       ~=? union [1, 2, 3] [3],
    "union" ~:  "#9" ~: [1, 2, 3, 4]    ~=? union [1, 2, 3] [3, 4],
    "union" ~: "#10" ~: [1, 2, 3, 4, 5] ~=? union [1, 2, 3] [3, 4, 5]]

difference :: [Int] -> [Int] -> [Int]
difference [] set2 = []
difference set1 [] = set1
difference (x:xs) set2
    | x `includes` set2 = difference xs set2
    | otherwise         = x : difference xs set2

differenceTestList = test [
    "difference" ~:  "#1" ~: []        ~=? difference [] [],
    "difference" ~:  "#2" ~: []        ~=? difference [] [1],
    "difference" ~:  "#3" ~: [1, 2, 3] ~=? difference [1, 2, 3] [0],
    "difference" ~:  "#4" ~: [2, 3]    ~=? difference [1, 2, 3] [0, 1],
    "difference" ~:  "#5" ~: [3]       ~=? difference [1, 2, 3] [0, 1, 2],
    "difference" ~:  "#6" ~: []        ~=? difference [1, 2, 3] [0, 1, 2, 3],
    "difference" ~:  "#7" ~: []        ~=? difference [1, 2, 3] [1, 2, 3],
    "difference" ~:  "#8" ~: [1]       ~=? difference [1, 2, 3] [2, 3, 4],
    "difference" ~:  "#9" ~: [1, 2]    ~=? difference [1, 2, 3] [3, 4, 5],
    "difference" ~: "#10" ~: [1, 2, 3] ~=? difference [1, 2, 3] [4, 5, 6]]

intersection :: [Int] -> [Int] -> [Int]
intersection [] _ = []
intersection _ [] = []
intersection (x:xs) set2
    | x `includes` set2 = x : intersection xs set2
    | otherwise         = intersection xs set2

intersectionTestList = test [
    "intersection" ~: "#1" ~: []        ~=? intersection [] [],
    "intersection" ~: "#2" ~: []        ~=? intersection [] [1],
    "intersection" ~: "#3" ~: []        ~=? intersection [1] [],
    "intersection" ~: "#4" ~: [1, 2, 3] ~=? intersection [1, 2, 3] [1, 2, 3],
    "intersection" ~: "#5" ~: [2, 3]    ~=? intersection [1, 2, 3] [2, 3, 4],
    "intersection" ~: "#6" ~: [3]       ~=? intersection [1, 2, 3] [3, 4, 5],
    "intersection" ~: "#7" ~: []        ~=? intersection [1, 2, 3] [4, 5, 6]]

