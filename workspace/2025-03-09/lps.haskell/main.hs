{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit
import Data.List (intersect)

main :: IO ()
main = do
    runTestTT testLists
    pure ()

testLists = TestList [
    prefixesTestList,
    properPrefixesTestList,
    suffixesTestList,
    properSuffixesTestList,
    lpsTestList,
    lpsArrayTestList]

prefixes :: [a] -> [[a]]
prefixes xs = accumulate xs [] []
    where
        accumulate [] prefix prefixes = reverse $ map reverse (prefix:prefixes)
        accumulate (x:xs) prefix prefixes = accumulate xs (x:prefix) (prefix:prefixes)

prefixesTestList = test [
    "prefixes" ~: "#1" ~: [""]                   ~=? prefixes "",
    "prefixes" ~: "#2" ~: ["", "a"]              ~=? prefixes "a",
    "prefixes" ~: "#3" ~: ["", "a", "ab"]        ~=? prefixes "ab",
    "prefixes" ~: "#4" ~: ["", "a", "ab", "abc"] ~=? prefixes "abc"]

properPrefixes :: [a] -> [[a]]
properPrefixes xs = accumulate xs [] []
    where
        accumulate [] prefix prefixes = reverse $ map reverse prefixes
        accumulate (x:xs) prefix prefixes = accumulate xs (x:prefix) (prefix:prefixes)

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

lps :: (Eq a) => [a] -> [a]
lps xs = foldl longer [] $ intersect (properPrefixes xs) (properSuffixes xs)
    where
        longer xs ys
            | length xs >= length ys = xs
            | otherwise              = ys

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
    "lps" ~: "#16" ~: "abcabc" ~=? lps "abcabcabc",
    "lps" ~: "#17" ~: ""       ~=? lps "abcabcabcd"]

lpsArray :: (Eq a) => [a] -> [Int]
lpsArray xs = map (length . lps) (tail $ prefixes xs)

lpsArrayTestList = test [
    "lpsArray" ~: "#1"  ~: []                             ~=? lpsArray "",
    "lpsArray" ~: "#2"  ~: [0]                            ~=? lpsArray "a",
    "lpsArray" ~: "#3"  ~: [0, 1]                         ~=? lpsArray "aa",
    "lpsArray" ~: "#4"  ~: [0, 1, 2]                      ~=? lpsArray "aaa",
    "lpsArray" ~: "#5"  ~: [0, 0]                         ~=? lpsArray "ab",
    "lpsArray" ~: "#6"  ~: [0, 0, 1]                      ~=? lpsArray "aba",
    "lpsArray" ~: "#7"  ~: [0, 0, 1, 2]                   ~=? lpsArray "abab",
    "lpsArray" ~: "#8"  ~: [0, 0, 1, 2, 3]                ~=? lpsArray "ababa",
    "lpsArray" ~: "#9"  ~: [0, 0, 1, 2, 3, 4]             ~=? lpsArray "ababab",
    "lpsArray" ~: "#10" ~: [0, 0, 0]                      ~=? lpsArray "abc",
    "lpsArray" ~: "#11" ~: [0, 0, 0, 1]                   ~=? lpsArray "abca",
    "lpsArray" ~: "#12" ~: [0, 0, 0, 1, 2]                ~=? lpsArray "abcab",
    "lpsArray" ~: "#13" ~: [0, 0, 0, 1, 2, 3]             ~=? lpsArray "abcabc",
    "lpsArray" ~: "#14" ~: [0, 0, 0, 1, 2, 3, 4]          ~=? lpsArray "abcabca",
    "lpsArray" ~: "#15" ~: [0, 0, 0, 1, 2, 3, 4, 5]       ~=? lpsArray "abcabcab",
    "lpsArray" ~: "#16" ~: [0, 0, 0, 1, 2, 3, 4, 5, 6]    ~=? lpsArray "abcabcabc",
    "lpsArray" ~: "#17" ~: [0, 0, 0, 1, 2, 3, 4, 5, 6, 0] ~=? lpsArray "abcabcabcd"]

