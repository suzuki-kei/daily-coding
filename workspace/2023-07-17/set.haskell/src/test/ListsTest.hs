module ListsTest where

import Test.HUnit
import qualified Lists

testList = TestList [
    containsTestList]

containsTestList = test [
    -- 空リスト
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [],

    -- 1 要素のリスト
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [1],
    "contains" ~: "#2" ~: True  ~=? Lists.contains 1 [1],
    "contains" ~: "#3" ~: False ~=? Lists.contains 2 [1],

    -- 2 要素のリスト
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [1, 2],
    "contains" ~: "#2" ~: True  ~=? Lists.contains 1 [1, 2],
    "contains" ~: "#3" ~: True  ~=? Lists.contains 2 [1, 2],
    "contains" ~: "#4" ~: False ~=? Lists.contains 3 [1, 2],

    -- 2 要素のリスト (逆順)
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [2, 1],
    "contains" ~: "#2" ~: True  ~=? Lists.contains 1 [2, 1],
    "contains" ~: "#3" ~: True  ~=? Lists.contains 2 [2, 1],
    "contains" ~: "#4" ~: False ~=? Lists.contains 3 [2, 1],

    -- 3 要素のリスト
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [1, 2, 3],
    "contains" ~: "#2" ~: True  ~=? Lists.contains 1 [1, 2, 3],
    "contains" ~: "#3" ~: True  ~=? Lists.contains 2 [1, 2, 3],
    "contains" ~: "#4" ~: True  ~=? Lists.contains 3 [1, 2, 3],
    "contains" ~: "#5" ~: False ~=? Lists.contains 4 [1, 2, 3],

    -- 3 要素のリスト (逆順)
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [3, 2, 1],
    "contains" ~: "#2" ~: True  ~=? Lists.contains 1 [3, 2, 1],
    "contains" ~: "#3" ~: True  ~=? Lists.contains 2 [3, 2, 1],
    "contains" ~: "#4" ~: True  ~=? Lists.contains 3 [3, 2, 1],
    "contains" ~: "#5" ~: False ~=? Lists.contains 4 [3, 2, 1],

    -- 重複のあるリスト
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [1, 1, 2, 2, 3, 3],
    "contains" ~: "#2" ~: True  ~=? Lists.contains 1 [1, 1, 2, 2, 3, 3],
    "contains" ~: "#3" ~: True  ~=? Lists.contains 2 [1, 1, 2, 2, 3, 3],
    "contains" ~: "#4" ~: True  ~=? Lists.contains 3 [1, 1, 2, 2, 3, 3],
    "contains" ~: "#5" ~: False ~=? Lists.contains 4 [1, 1, 2, 2, 3, 3],

    -- 重複のあるリスト (逆順)
    "contains" ~: "#1" ~: False ~=? Lists.contains 0 [3, 3, 2, 2, 1, 1],
    "contains" ~: "#2" ~: True  ~=? Lists.contains 1 [3, 3, 2, 2, 1, 1],
    "contains" ~: "#3" ~: True  ~=? Lists.contains 2 [3, 3, 2, 2, 1, 1],
    "contains" ~: "#4" ~: True  ~=? Lists.contains 3 [3, 3, 2, 2, 1, 1],
    "contains" ~: "#5" ~: False ~=? Lists.contains 4 [3, 3, 2, 2, 1, 1]]

