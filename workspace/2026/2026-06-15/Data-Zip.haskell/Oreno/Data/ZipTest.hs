module Oreno.Data.ZipTest where

import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (Test (TestList))
import Test.HUnit (test)
import Test.HUnit (Test)

allTests :: Test
allTests = TestList [
    zipTests,
    unzipTests]

zipTests :: Test
zipTests = test [
    "zip #1" ~: zip ([] :: [Int]) ([] :: [Int]) ~?= [],
    "zip #2" ~: zip [1] ([] :: [Int]) ~?= [],
    "zip #3" ~: zip ([] :: [Int]) [2] ~?= [],
    "zip #4" ~: zip [1] [2] ~?= [(1, 2)],
    "zip #5" ~: zip [1, 3] [2, 4] ~?= [(1, 2), (3, 4)],
    "zip #6" ~: zip [1, 3, 5] [2, 4, 6] ~?= [(1, 2), (3, 4), (5, 6)],
    "zip #7" ~: zip [1, 2, 3] ["one", "two", "three"] ~?= [(1, "one"), (2, "two"), (3, "three")]]

unzipTests :: Test
unzipTests = test [
    "unzip #1" ~: unzip ([] :: [(Int, Int)]) ~?= ([], []),
    "unzip #2" ~: unzip [(1, 2)] ~?= ([1], [2]),
    "unzip #3" ~: unzip [(1, 2), (3, 4)] ~?= ([1, 3], [2, 4]),
    "unzip #4" ~: unzip [(1, 2), (3, 4), (5, 6)] ~?= ([1, 3, 5], [2, 4, 6])]

