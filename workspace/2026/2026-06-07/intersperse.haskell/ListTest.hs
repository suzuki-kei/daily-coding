module ListTest where

import List (intersperse)
import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (test)
import Test.HUnit (Test)

main :: IO ()
main = runTestTTAndExit intersperseTests

intersperseTests :: Test
intersperseTests = test [
    "intersperse #1" ~: intersperse ' ' "" ~?= "",
    "intersperse #2" ~: intersperse ' ' "a" ~?= "a",
    "intersperse #3" ~: intersperse ' ' "ab" ~?= "a b",
    "intersperse #4" ~: intersperse ' ' "abc" ~?= "a b c",
    "intersperse #5" ~: intersperse '-' "abc" ~?= "a-b-c"]

