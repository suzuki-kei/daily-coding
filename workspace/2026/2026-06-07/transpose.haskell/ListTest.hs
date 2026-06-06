module ListTest where

import List (transpose)
import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (test)
import Test.HUnit (Test)

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests = TestList [transposeTests]

transposeTests :: Test
transposeTests = test [
    "transpose #1" ~: transpose ([] :: [[Int]])          ~?= [],
    "transpose #2" ~: transpose [[1]]                    ~?= [[1]],
    "transpose #3" ~: transpose [[1], [2]]               ~?= [[1, 2]],
    "transpose #4" ~: transpose [[1], [2], [3]]          ~?= [[1, 2, 3]],
    "transpose #5" ~: transpose [[1, 2]]                 ~?= [[1], [2]],
    "transpose #6" ~: transpose [[1, 2, 3]]              ~?= [[1], [2], [3]],
    "transpose #7" ~: transpose [[1, 2], [3], [4, 5, 6]] ~?= [[1, 3, 4], [2, 5], [6]]]

