{-# LANGUAGE NoImplicitPrelude #-}

module Oreno.Data.ListTest where

import Data.Bool
import Data.Functor
import Data.Int
import Data.Maybe
import Data.Ord
import Data.Tuple
import Oreno.Data.List
import Oreno.Test.Utils
import Prelude ((.))
import Prelude ((*))
import Prelude ((+))
import Prelude (($))
import Prelude (undefined)
import Prelude (take)
import System.IO
import Test.HUnit

allTests :: Test
allTests = TestList [
    operatorPlusPlusTests,
    headTests,
    lastTests,
    tailTests,
    initTests,
    unconsTests,
    unsnocTests,
    singletonTests,
    nullTests,
    lengthTests,
    compareLengthTests,
    mapTests,
    reverseTests,
    intersperseTests,
    intercalateTests,
    transposeTests]

operatorPlusPlusTests :: Test
operatorPlusPlusTests = testsFromActualExpectedPairs "++" [
    "" ++ ""       ==> "",
    "" ++ "a"      ==> "a",
    "a" ++ ""      ==> "a",
    "" ++ "ab"     ==> "ab",
    "ab" ++ ""     ==> "ab",
    "" ++ "abc"    ==> "abc",
    "abc" ++ ""    ==> "abc",
    "abc" ++ "def" ==> "abcdef"]

headTests :: Test
headTests = testsFromActualExpectedPairs "head" [
    head "c"   ==> 'c',
    head "bc"  ==> 'b',
    head "abc" ==> 'a']

lastTests :: Test
lastTests = testsFromActualExpectedPairs "last" [
    last "a"   ==> 'a',
    last "ab"  ==> 'b',
    last "abc" ==> 'c']

tailTests :: Test
tailTests = testsFromActualExpectedPairs "tail" [
    tail "a"   ==> "",
    tail "ab"  ==> "b",
    tail "abc" ==> "bc"]

initTests :: Test
initTests = testsFromActualExpectedPairs "init" [
    init "a"   ==> "",
    init "ab"  ==> "a",
    init "abc" ==> "ab"]

unconsTests :: Test
unconsTests = testsFromActualExpectedPairs "uncons" [
    uncons ""    ==> Nothing,
    uncons "a"   ==> Just ('a', ""),
    uncons "ab"  ==> Just ('a', "b"),
    uncons "abc" ==> Just ('a', "bc")]

unsnocTests :: Test
unsnocTests = testsFromActualExpectedPairs "unsnoc" [
    unsnoc ""    ==> Nothing,
    unsnoc "a"   ==> Just ("", 'a'),
    unsnoc "ab"  ==> Just ("a", 'b'),
    unsnoc "abc" ==> Just ("ab", 'c'),

    -- laziness test
    (fmap fst $ unsnoc [undefined :: Int]) ==> Just [],
    (fmap (head . fst) $ unsnoc (1 : 2 : undefined :: [Int])) ==> Just 1]

singletonTests :: Test
singletonTests = testsFromActualExpectedPairs "singleton" [
    singleton 'a' ==> "a",
    singleton 'b' ==> "b",
    singleton 'c' ==> "c"]

nullTests :: Test
nullTests = testsFromActualExpectedPairs "null" [
    null ""    ==> True,
    null "a"   ==> False,
    null "ab"  ==> False,
    null "abc" ==> False,

    -- nested list
    null [[]] ==> False,

    -- infinite list
    null [1..] ==> False]

lengthTests :: Test
lengthTests = testsFromActualExpectedPairs "length" [
    length ""    ==> 0,
    length "a"   ==> 1,
    length "ab"  ==> 2,
    length "abc" ==> 3]

compareLengthTests :: Test
compareLengthTests = testsFromActualExpectedPairs "compareLength" [
    compareLength "" 0 ==> EQ,
    compareLength "" 1 ==> LT,

    compareLength "a" 0 ==> GT,
    compareLength "a" 1 ==> EQ,
    compareLength "a" 2 ==> LT,

    compareLength "ab" 1 ==> GT,
    compareLength "ab" 2 ==> EQ,
    compareLength "ab" 3 ==> LT,

    -- infinite list
    compareLength [1..] 100 ==> GT,

    -- laziness test
    compareLength undefined (-1) ==> GT,
    compareLength ('a' : undefined) 0 ==> GT]

mapTests :: Test
mapTests = testsFromActualExpectedPairs "map" [
    map (+1) []         ==> [],
    map (+1) [1]        ==> [2],
    map (+1) [1, 2]     ==> [2, 3],
    map (+1) [1, 2, 3]  ==> [2, 3, 4],
    map (*10) [1, 2, 3] ==> [10, 20, 30]]

reverseTests :: Test
reverseTests = testsFromActualExpectedPairs "reverse" [
    reverse ""    ==> "",
    reverse "a"   ==> "a",
    reverse "ab"  ==> "ba",
    reverse "abc" ==> "cba",

    -- laziness test
    head (reverse [undefined, 1]) ==> 1]

intersperseTests :: Test
intersperseTests = testsFromActualExpectedPairs "intersperse" [
    intersperse '-' ""    ==> "",
    intersperse '-' "a"   ==> "a",
    intersperse '-' "ab"  ==> "a-b",
    intersperse '-' "abc" ==> "a-b-c",

    -- laziness test
    take 1 (intersperse undefined ('a' : undefined)) ==> "a"]

intercalateTests :: Test
intercalateTests = testsFromActualExpectedPairs "intercalate" [
    intercalate "-" []              ==> "",
    intercalate "-" ["a"]           ==> "a",
    intercalate "-" ["a", "b"]      ==> "a-b",
    intercalate "-" ["a", "b", "c"] ==> "a-b-c",

    -- laziness test
    take 5 (intercalate undefined ("Lorem" : undefined)) ==> "Lorem"]

transposeTests :: Test
transposeTests = testsFromActualExpectedPairs "transpose" [
    transpose [[1, 2, 3], [4, 5, 6]] ==>
        [[1, 4], [2, 5], [3, 6]],

    -- laziness test
    take 1 (transpose ['a' : undefined, 'b' : undefined]) ==>
        ["ab"]
    ]

