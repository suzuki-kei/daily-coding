module ListToRunsTest where

import ListToRuns (listToRuns1)
import ListToRuns (listToRuns2)
import ListToRuns (listToRuns3)
import ListToRuns (Run)
import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (test)
import Test.HUnit (Test)
import Text.Printf (printf)

type ListToRuns a = [a] -> [Run a]

infix 1 ==>
(==>) :: (Eq a, Show a) => a -> a -> Test
(==>) = (~?=)

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests = TestList [
    listToRuns1Tests,
    listToRuns2Tests,
    listToRuns3Tests]

listToRuns1Tests :: Test
listToRuns1Tests = listToRunsToTest "listToRuns1" listToRuns1

listToRuns2Tests :: Test
listToRuns2Tests = listToRunsToTest "listToRuns1" listToRuns1

listToRuns3Tests :: Test
listToRuns3Tests = listToRunsToTest "listToRuns1" listToRuns1

listToRunsToTest :: String -> ListToRuns Char -> Test
listToRunsToTest label listToRuns =
    testWithAssertions label [
        listToRuns ""       ==> [],
        listToRuns "a"      ==> ["a"],
        listToRuns "aa"     ==> ["aa"],
        listToRuns "aaa"    ==> ["aaa"],
        listToRuns "ab"     ==> ["a", "b"],
        listToRuns "abb"    ==> ["a", "bb"],
        listToRuns "abba"   ==> ["a", "bb", "a"],
        listToRuns "aabccc" ==> ["aa", "b", "ccc"]
    ]

testWithAssertions :: String -> [Test] -> Test
testWithAssertions label assertions = test tests
    where
        labels = map mapper ns
            where
                ns = [1..] :: [Int]
                mapper n = printf "%s #%d" label n
        tests = zipWith zipper labels assertions
            where
                zipper = (~:)

