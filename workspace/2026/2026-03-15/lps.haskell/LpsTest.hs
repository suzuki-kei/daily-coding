module LpsTest where

import Lps (lps)
import Lps (lpsArray)
import Lps (prefixes)
import Lps (properPrefixes)
import Lps (properSuffixes)
import Lps (suffixes)
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (Test)
import TestUtils ((==>))
import TestUtils (testsFromArgumentExpectedPairs)

main ::
    IO ()
main =
    runTestTTAndExit allTests

allTests ::
    Test
allTests =
    TestList [
        prefixesTests,
        properPrefixesTests,
        suffixesTests,
        properSuffixesTests,
        lpsTests,
        lpsArrayTests]

prefixesTests ::
    Test
prefixesTests =
    testsFromArgumentExpectedPairs "prefixes" prefixes [
        ""    ==> [""],
        "a"   ==> ["", "a"],
        "ab"  ==> ["", "a", "ab"],
        "abc" ==> ["", "a", "ab", "abc"]]

properPrefixesTests ::
    Test
properPrefixesTests =
    testsFromArgumentExpectedPairs "properPrefixes" properPrefixes [
        ""    ==> [],
        "a"   ==> [""],
        "ab"  ==> ["", "a"],
        "abc" ==> ["", "a", "ab"]]

suffixesTests ::
    Test
suffixesTests =
    testsFromArgumentExpectedPairs "suffixes" suffixes [
        ""    ==> [""],
        "a"   ==> ["", "a"],
        "ab"  ==> ["", "b", "ab"],
        "abc" ==> ["", "c", "bc", "abc"]]

properSuffixesTests ::
    Test
properSuffixesTests =
    testsFromArgumentExpectedPairs "properSuffixes" properSuffixes [
        ""    ==> [],
        "a"   ==> [""],
        "ab"  ==> ["", "b"],
        "abc" ==> ["", "c", "bc"]]

lpsTests ::
    Test
lpsTests =
    testsFromArgumentExpectedPairs "lps" lps [
        ""           ==> "",
        "a"          ==> "",
        "aa"         ==> "a",
        "aaa"        ==> "aa",
        "ab"         ==> "",
        "aba"        ==> "a",
        "abab"       ==> "ab",
        "ababa"      ==> "aba",
        "ababab"     ==> "abab",
        "abc"        ==> "",
        "abca"       ==> "a",
        "abcab"      ==> "ab",
        "abcabc"     ==> "abc",
        "abcabca"    ==> "abca",
        "abcabcab"   ==> "abcab",
        "abcabcabc"  ==> "abcabc",
        "abcabcabcd" ==> ""]

lpsArrayTests ::
    Test
lpsArrayTests =
    testsFromArgumentExpectedPairs "lpsArray" lpsArray [
        ""           ==> [],
        "a"          ==> [0],
        "aa"         ==> [0, 1],
        "aaa"        ==> [0, 1, 2],
        "ab"         ==> [0, 0],
        "aba"        ==> [0, 0, 1],
        "abab"       ==> [0, 0, 1, 2],
        "ababa"      ==> [0, 0, 1, 2, 3],
        "ababab"     ==> [0, 0, 1, 2, 3, 4],
        "abc"        ==> [0, 0, 0],
        "abca"       ==> [0, 0, 0, 1],
        "abcab"      ==> [0, 0, 0, 1, 2],
        "abcabc"     ==> [0, 0, 0, 1, 2, 3],
        "abcabca"    ==> [0, 0, 0, 1, 2, 3, 4],
        "abcabcab"   ==> [0, 0, 0, 1, 2, 3, 4, 5],
        "abcabcabc"  ==> [0, 0, 0, 1, 2, 3, 4, 5, 6],
        "abcabcabcd" ==> [0, 0, 0, 1, 2, 3, 4, 5, 6, 0]]

