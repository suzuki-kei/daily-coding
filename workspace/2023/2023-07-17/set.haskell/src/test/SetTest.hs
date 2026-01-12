module SetTest where

import Test.HUnit
import qualified Set

testList = TestList [
    fromListTestList,
    isSetTestList,
    isSubsetTestList,
    equalsTestList,
    unionTestList,
    differenceTestList,
    intersectionTestList]

fromListTestList = test [
    -- 空リスト
    "fromList" ~: "#1" ~: True ~=? (Set.equals [] $ Set.fromList ([]::[Int])),

    -- 1 要素のリスト
    "fromList" ~: "#1" ~: True ~=? (Set.equals [1] $ Set.fromList [1]),

    -- 2 要素のリスト
    "fromList" ~: "#1" ~: True ~=? (Set.equals [1]    $ Set.fromList [1, 1]),
    "fromList" ~: "#2" ~: True ~=? (Set.equals [1, 2] $ Set.fromList [1, 2]),
    "fromList" ~: "#3" ~: True ~=? (Set.equals [1, 2] $ Set.fromList [2, 1]),
    "fromList" ~: "#4" ~: True ~=? (Set.equals [2]    $ Set.fromList [2, 2]),

    -- 複数要素のリスト
    "fromList" ~: "#1" ~: True ~=? (Set.equals [1, 2, 3] $ Set.fromList [1, 2, 2, 3, 3, 3])]

isSetTestList = test [
    -- 空リスト
    "isSet" ~: "#1" ~: True  ~=? Set.isSet ([]::[Int]),

    -- 1 要素のリスト
    "isSet" ~: "#1" ~: True  ~=? Set.isSet [1],

    -- 2 要素のリスト
    "isSet" ~: "#1" ~: False ~=? Set.isSet [1, 1],
    "isSet" ~: "#2" ~: True  ~=? Set.isSet [1, 2],
    "isSet" ~: "#3" ~: True  ~=? Set.isSet [2, 1],
    "isSet" ~: "#4" ~: False ~=? Set.isSet [2, 2],

    -- 3 要素のリスト
    "isSet" ~: "#1"  ~: False ~=? Set.isSet [1, 1, 1],
    "isSet" ~: "#2"  ~: False ~=? Set.isSet [1, 1, 2],
    "isSet" ~: "#3"  ~: False ~=? Set.isSet [1, 1, 3],
    "isSet" ~: "#4"  ~: False ~=? Set.isSet [1, 2, 1],
    "isSet" ~: "#5"  ~: False ~=? Set.isSet [1, 2, 2],
    "isSet" ~: "#6"  ~: True  ~=? Set.isSet [1, 2, 3],
    "isSet" ~: "#7"  ~: False ~=? Set.isSet [1, 3, 1],
    "isSet" ~: "#8"  ~: True  ~=? Set.isSet [1, 3, 2],
    "isSet" ~: "#9"  ~: False ~=? Set.isSet [1, 3, 3],
    "isSet" ~: "#10" ~: False ~=? Set.isSet [1, 3, 3],
    "isSet" ~: "#11" ~: False ~=? Set.isSet [2, 1, 1],
    "isSet" ~: "#12" ~: False ~=? Set.isSet [2, 1, 2],
    "isSet" ~: "#13" ~: True  ~=? Set.isSet [2, 1, 3],
    "isSet" ~: "#14" ~: False ~=? Set.isSet [2, 2, 1],
    "isSet" ~: "#15" ~: False ~=? Set.isSet [2, 2, 2],
    "isSet" ~: "#15" ~: False ~=? Set.isSet [2, 2, 3],
    "isSet" ~: "#16" ~: True  ~=? Set.isSet [2, 3, 1],
    "isSet" ~: "#17" ~: False ~=? Set.isSet [2, 3, 2],
    "isSet" ~: "#18" ~: False ~=? Set.isSet [2, 3, 3],
    "isSet" ~: "#19" ~: False ~=? Set.isSet [3, 1, 1],
    "isSet" ~: "#20" ~: True  ~=? Set.isSet [3, 1, 2],
    "isSet" ~: "#21" ~: False ~=? Set.isSet [3, 1, 3],
    "isSet" ~: "#22" ~: True  ~=? Set.isSet [3, 2, 1],
    "isSet" ~: "#23" ~: False ~=? Set.isSet [3, 2, 2],
    "isSet" ~: "#23" ~: False ~=? Set.isSet [3, 2, 3],
    "isSet" ~: "#24" ~: False ~=? Set.isSet [3, 3, 1],
    "isSet" ~: "#25" ~: False ~=? Set.isSet [3, 3, 2],
    "isSet" ~: "#26" ~: False ~=? Set.isSet [3, 3, 3]]

isSubsetTestList = test [
    -- 空リスト
    "isSubset" ~: "#1" ~: True  ~=? Set.isSubset ([]::[Int]) ([]::[Int]),
    "isSubset" ~: "#2" ~: False ~=? Set.isSubset [1] [],

    -- 1 要素のリスト
    "isSubset" ~: "#1" ~: True  ~=? Set.isSubset [] [1],
    "isSubset" ~: "#2" ~: False ~=? Set.isSubset [0] [1],
    "isSubset" ~: "#3" ~: True  ~=? Set.isSubset [1] [1],
    "isSubset" ~: "#4" ~: False ~=? Set.isSubset [2] [1],

    -- 2 要素のリスト
    "isSubset" ~: "#1" ~: True  ~=? Set.isSubset [] [1, 2],
    "isSubset" ~: "#2" ~: False ~=? Set.isSubset [0] [1, 2],
    "isSubset" ~: "#3" ~: True  ~=? Set.isSubset [1] [1, 2],
    "isSubset" ~: "#4" ~: True  ~=? Set.isSubset [2] [1, 2],
    "isSubset" ~: "#5" ~: False ~=? Set.isSubset [3] [1, 2],
    "isSubset" ~: "#6" ~: False ~=? Set.isSubset [0, 1] [1, 2],
    "isSubset" ~: "#7" ~: True  ~=? Set.isSubset [1, 2] [1, 2],
    "isSubset" ~: "#8" ~: False ~=? Set.isSubset [2, 3] [1, 2],

    -- 3 要素のリスト
    "isSubset" ~: "#1" ~: True  ~=? Set.isSubset [] [1, 2, 3],
    "isSubset" ~: "#2" ~: False ~=? Set.isSubset [0] [1, 2, 3],
    "isSubset" ~: "#3" ~: True  ~=? Set.isSubset [1] [1, 2, 3],
    "isSubset" ~: "#4" ~: True  ~=? Set.isSubset [2] [1, 2, 3],
    "isSubset" ~: "#5" ~: True  ~=? Set.isSubset [3] [1, 2, 3],
    "isSubset" ~: "#6" ~: False ~=? Set.isSubset [4] [1, 2, 3],
    "isSubset" ~: "#7" ~: False ~=? Set.isSubset [0, 1, 2] [1, 2, 3],
    "isSubset" ~: "#8" ~: True  ~=? Set.isSubset [1, 2, 3] [1, 2, 3],
    "isSubset" ~: "#9" ~: False ~=? Set.isSubset [2, 3, 4] [1, 2, 3]]

equalsTestList = test [
    -- 空リスト
    "equals" ~: "#1" ~: True  ~=? Set.equals ([]::[Int]) ([]::[Int]),

    -- 1 要素のリスト
    "equals" ~: "#1" ~: True  ~=? Set.equals [1] [1],
    "equals" ~: "#2" ~: False ~=? Set.equals [1] [2],
    "equals" ~: "#3" ~: False ~=? Set.equals [2] [1],
    "equals" ~: "#4" ~: True  ~=? Set.equals [2] [2],

    -- 2 要素のリスト
    "equals" ~: "#1" ~: False ~=? Set.equals [0, 1] [1, 2],
    "equals" ~: "#2" ~: True  ~=? Set.equals [1, 2] [1, 2],
    "equals" ~: "#3" ~: False ~=? Set.equals [2, 3] [1, 2],

    -- 3 要素のリスト
    "equals" ~: "#1" ~: False ~=? Set.equals [0, 1, 2] [1, 2, 3],
    "equals" ~: "#2" ~: True  ~=? Set.equals [1, 2, 3] [1, 2, 3],
    "equals" ~: "#3" ~: False ~=? Set.equals [2, 3, 4] [1, 2, 3]]

unionTestList = test [
    -- 空リスト
    "union" ~: "#1" ~: True ~=? (Set.equals ([]::[Int]) $ Set.union ([]::[Int]) ([]::[Int])),

    -- 1 要素のリスト
    "union" ~: "#1" ~: True ~=? (Set.equals [1]    $ Set.union [1] [1]),
    "union" ~: "#2" ~: True ~=? (Set.equals [1, 2] $ Set.union [1] [2]),
    "union" ~: "#3" ~: True ~=? (Set.equals [1, 2] $ Set.union [2] [1]),
    "union" ~: "#4" ~: True ~=? (Set.equals [2]    $ Set.union [2] [2]),

    -- 複数要素のリスト
    "union" ~: "#1" ~: True ~=? (Set.equals [0, 1, 2, 3]       $ Set.union [0, 1, 2] [1, 2, 3]),
    "union" ~: "#2" ~: True ~=? (Set.equals [1, 2, 3]          $ Set.union [1, 2, 3] [1, 2, 3]),
    "union" ~: "#3" ~: True ~=? (Set.equals [1, 2, 3, 4]       $ Set.union [2, 3, 4] [1, 2, 3]),
    "union" ~: "#4" ~: True ~=? (Set.equals [1, 2, 3, 4, 5]    $ Set.union [3, 4, 5] [1, 2, 3]),
    "union" ~: "#5" ~: True ~=? (Set.equals [1, 2, 3, 4, 5, 6] $ Set.union [4, 5, 6] [1, 2, 3])]

differenceTestList = test [
    -- 空リスト
    "difference" ~: "#1" ~: True ~=? (Set.equals ([]::[Int]) $ Set.difference ([]::[Int]) ([]::[Int])),

    -- 1 要素のリスト
    "difference" ~: "#1" ~: True ~=? (Set.equals [1] $ Set.difference [1] [0]),
    "difference" ~: "#2" ~: True ~=? (Set.equals []  $ Set.difference [1] [1]),
    "difference" ~: "#3" ~: True ~=? (Set.equals [1] $ Set.difference [1] [2]),

    -- 複数要素のリスト
    "difference" ~: "#1" ~: True ~=? (Set.equals [3]       $ Set.difference [1, 2, 3] [0, 1, 2]),
    "difference" ~: "#2" ~: True ~=? (Set.equals []        $ Set.difference [1, 2, 3] [1, 2, 3]),
    "difference" ~: "#3" ~: True ~=? (Set.equals [1]       $ Set.difference [1, 2, 3] [2, 3, 4]),
    "difference" ~: "#4" ~: True ~=? (Set.equals [1, 2]    $ Set.difference [1, 2, 3] [3, 4, 5]),
    "difference" ~: "#5" ~: True ~=? (Set.equals [1, 2, 3] $ Set.difference [1, 2, 3] [4, 5, 6])]

intersectionTestList = test [
    -- 空リスト
    "intersection" ~: "#1" ~: True ~=? (Set.equals ([]::[Int]) $ Set.intersection ([]::[Int]) ([]::[Int])),

    -- 1 要素のリスト
    "intersection" ~: "#1" ~: True ~=? (Set.equals []  $ Set.intersection [1] [0]),
    "intersection" ~: "#2" ~: True ~=? (Set.equals [1] $ Set.intersection [1] [1]),
    "intersection" ~: "#3" ~: True ~=? (Set.equals []  $ Set.intersection [1] [2]),

    -- 複数要素のリスト
    "intersection" ~: "#1" ~: True ~=? (Set.equals [1, 2]    $ Set.intersection [1, 2, 3] [0, 1, 2]),
    "intersection" ~: "#2" ~: True ~=? (Set.equals [1, 2, 3] $ Set.intersection [1, 2, 3] [1, 2, 3]),
    "intersection" ~: "#3" ~: True ~=? (Set.equals [2, 3]    $ Set.intersection [1, 2, 3] [2, 3, 4]),
    "intersection" ~: "#4" ~: True ~=? (Set.equals [3]       $ Set.intersection [1, 2, 3] [3, 4, 5]),
    "intersection" ~: "#5" ~: True ~=? (Set.equals []        $ Set.intersection [1, 2, 3] [4, 5, 6])]

