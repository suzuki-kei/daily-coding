{- cabal:
    build-depends: base, HUnit
-}

import Prelude hiding (reverse)
import Test.HUnit

main :: IO ()
main = do
    runTestTT testLists
    pure ()

testLists = TestList [
    reverseTestList,
    prefixesTestList,
    properPrefixesTestList,
    suffixesTestList,
    properSuffixesTestList,
    longerTestList,
    containsTestList,
    intersectionTestList,
    lpsTestList,
    lpsArrayTestList]

reverse :: [a] -> [a]
reverse xs = accumulate xs []
    where
        accumulate [] reversed = reversed
        accumulate (x:xs) reversed = accumulate xs (x:reversed)

reverseTestList = test [
    "reverse" ~: "#1" ~: ""    ~=? reverse "",
    "reverse" ~: "#2" ~: "a"   ~=? reverse "a",
    "reverse" ~: "#3" ~: "ba"  ~=? reverse "ab",
    "reverse" ~: "#4" ~: "cba" ~=? reverse "abc"]

prefixes :: [a] -> [[a]]
prefixes xs = accumulate xs [] []
    where
        accumulate [] prefix prefixes =
            reverse $ map reverse (prefix:prefixes)
        accumulate (x:xs) prefix prefixes =
            accumulate xs (x:prefix) (prefix:prefixes)

prefixesTestList = test [
    "prefixes" ~: "#1" ~: [""]                   ~=? prefixes "",
    "prefixes" ~: "#2" ~: ["", "a"]              ~=? prefixes "a",
    "prefixes" ~: "#3" ~: ["", "a", "ab"]        ~=? prefixes "ab",
    "prefixes" ~: "#4" ~: ["", "a", "ab", "abc"] ~=? prefixes "abc"]

properPrefixes :: [a] -> [[a]]
properPrefixes xs = accumulate xs [] []
    where
        accumulate [] prefix prefixes =
            reverse $ map reverse prefixes
        accumulate (x:xs) prefix prefixes =
            accumulate xs (x:prefix) (prefix:prefixes)

properPrefixesTestList = test [
    "properPrefixes" ~: "#1" ~: []              ~=? properPrefixes "",
    "properPrefixes" ~: "#2" ~: [""]            ~=? properPrefixes "a",
    "properPrefixes" ~: "#3" ~: ["", "a"]       ~=? properPrefixes "ab",
    "properPrefixes" ~: "#4" ~: ["", "a", "ab"] ~=? properPrefixes "abc"]

suffixes :: [a] -> [[a]]
suffixes xs = accumulate xs []
    where
        accumulate [] suffixes = ([]:suffixes)
        accumulate xs suffixes = accumulate (tail xs) (xs:suffixes)

suffixesTestList = test [
    "suffixes" ~: "#1" ~: [""]                   ~=? suffixes "",
    "suffixes" ~: "#2" ~: ["", "a"]              ~=? suffixes "a",
    "suffixes" ~: "#3" ~: ["", "b", "ab"]        ~=? suffixes "ab",
    "suffixes" ~: "#4" ~: ["", "c", "bc", "abc"] ~=? suffixes "abc"]

properSuffixes :: [a] -> [[a]]
properSuffixes [] = []
properSuffixes xs = suffixes $ tail xs

properSuffixesTestList = test [
    "properSuffixes" ~: "#1" ~: []              ~=? properSuffixes "",
    "properSuffixes" ~: "#2" ~: [""]            ~=? properSuffixes "a",
    "properSuffixes" ~: "#3" ~: ["", "b"]       ~=? properSuffixes "ab",
    "properSuffixes" ~: "#4" ~: ["", "c", "bc"] ~=? properSuffixes "abc"]

longer :: [a] -> [a] -> [a]
longer xs ys
    | length xs > length ys = xs
    | otherwise             = ys

longerTestList = test [
    "longer" ~: "#1" ~: "" ~=? longer "" "",
    "longer" ~: "#2" ~: "a" ~=? longer "a" "",
    "longer" ~: "#3" ~: "ab" ~=? longer "a" "ab",
    "longer" ~: "#4" ~: "abc" ~=? longer "abc" "ab"]

contains :: (Eq a) => a -> [a] -> Bool
contains target [] = False
contains target (x:xs) = or [x == target, contains target xs]

containsTestList = test [
    "contains" ~: "#1" ~: False ~=? contains 'a' "",
    "contains" ~: "#2" ~: True  ~=? contains 'a' "ace",
    "contains" ~: "#3" ~: False ~=? contains 'b' "ace",
    "contains" ~: "#4" ~: True  ~=? contains 'c' "ace",
    "contains" ~: "#5" ~: False ~=? contains 'd' "ace",
    "contains" ~: "#6" ~: True  ~=? contains 'e' "ace"]

intersection :: (Eq a) => [a] -> [a] -> [a]
intersection xs ys = filter (\x -> contains x ys) xs

intersectionTestList = test [
    "intersection" ~: "#1" ~: ""    ~=? intersection "" "",
    "intersection" ~: "#2" ~: ""    ~=? intersection "a" "",
    "intersection" ~: "#3" ~: ""    ~=? intersection "" "a",
    "intersection" ~: "#4" ~: "a"   ~=? intersection "a" "a",
    "intersection" ~: "#5" ~: "cde" ~=? intersection "abcde" "cdefg"]

lps :: (Eq a) => [a] -> [a]
lps xs = foldl longer [] $ intersection (properPrefixes xs) (properSuffixes xs)

lpsTestList = test [
    "lps" ~: "#1"  ~: ""       ~=? lps "",
    "lps" ~: "#2"  ~: ""       ~=? lps "a",
    "lps" ~: "#3"  ~: "a"      ~=? lps "aa",
    "lps" ~: "#4"  ~: "aa"     ~=? lps "aaa",
    "lps" ~: "#5"  ~: ""       ~=? lps "ab",
    "lps" ~: "#6"  ~: "a"      ~=? lps "aba",
    "lps" ~: "#7"  ~: "ab"     ~=? lps "abab",
    "lps" ~: "#8"  ~: "aba"    ~=? lps "ababa",
    "lps" ~: "#9"  ~: "abab"   ~=? lps "ababab",
    "lps" ~: "#10" ~: ""       ~=? lps "abc",
    "lps" ~: "#11" ~: "a"      ~=? lps "abca",
    "lps" ~: "#12" ~: "ab"     ~=? lps "abcab",
    "lps" ~: "#13" ~: "abc"    ~=? lps "abcabc",
    "lps" ~: "#14" ~: "abca"   ~=? lps "abcabca",
    "lps" ~: "#15" ~: "abcab"  ~=? lps "abcabcab",
    "lps" ~: "#16" ~: "abcabc" ~=? lps "abcabcabc"]

lpsArray :: (Eq a) => [a] -> [Int]
lpsArray xs = map (\prefix -> length $ lps prefix) (tail $ prefixes xs)

lpsArrayTestList = test [
    "lpsArray" ~: "#1"  ~: []                          ~=? lpsArray "",
    "lpsArray" ~: "#2"  ~: [0]                         ~=? lpsArray "a",
    "lpsArray" ~: "#3"  ~: [0, 1]                      ~=? lpsArray "aa",
    "lpsArray" ~: "#4"  ~: [0, 1, 2]                   ~=? lpsArray "aaa",
    "lpsArray" ~: "#5"  ~: [0, 0]                      ~=? lpsArray "ab",
    "lpsArray" ~: "#6"  ~: [0, 0, 1]                   ~=? lpsArray "aba",
    "lpsArray" ~: "#7"  ~: [0, 0, 1, 2]                ~=? lpsArray "abab",
    "lpsArray" ~: "#8"  ~: [0, 0, 1, 2, 3]             ~=? lpsArray "ababa",
    "lpsArray" ~: "#9"  ~: [0, 0, 1, 2, 3, 4]          ~=? lpsArray "ababab",
    "lpsArray" ~: "#10" ~: [0, 0, 0]                   ~=? lpsArray "abc",
    "lpsArray" ~: "#11" ~: [0, 0, 0, 1]                ~=? lpsArray "abca",
    "lpsArray" ~: "#12" ~: [0, 0, 0, 1, 2]             ~=? lpsArray "abcab",
    "lpsArray" ~: "#13" ~: [0, 0, 0, 1, 2, 3]          ~=? lpsArray "abcabc",
    "lpsArray" ~: "#14" ~: [0, 0, 0, 1, 2, 3, 4]       ~=? lpsArray "abcabca",
    "lpsArray" ~: "#15" ~: [0, 0, 0, 1, 2, 3, 4, 5]    ~=? lpsArray "abcabcab",
    "lpsArray" ~: "#16" ~: [0, 0, 0, 1, 2, 3, 4, 5, 6] ~=? lpsArray "abcabcabc"]

