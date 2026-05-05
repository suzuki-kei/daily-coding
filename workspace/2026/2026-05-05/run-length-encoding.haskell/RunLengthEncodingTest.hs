module RunLengthEncodingTest where

import RunLengthEncoding (decode)
import RunLengthEncoding (encode)
import RunLengthEncoding (EncodedRun)
import Test.HUnit ((~:))
import Test.HUnit ((~?=))
import Test.HUnit (runTestTTAndExit)
import Test.HUnit (Test (TestList))
import Test.HUnit (test)
import Test.HUnit (Test)
import Text.Printf (printf)

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests = TestList [
    encodeTests,
    decodeTests]

testDataTuples :: [(String, [EncodedRun Char])]
testDataTuples = [
    -- (xs, [EncodedRun])
    ("",       []),
    ("a",      [('a', 1)]),
    ("aa",     [('a', 2)]),
    ("aaa",    [('a', 3)]),
    ("ab",     [('a', 1), ('b', 1)]),
    ("abb",    [('a', 1), ('b', 2)]),
    ("abba",   [('a', 1), ('b', 2), ('a', 1)]),
    ("aabccc", [('a', 2), ('b', 1), ('c', 3)])]

testsWithTestDataTuples :: (String -> [EncodedRun Char] -> Test) -> Test
testsWithTestDataTuples assert =
    let
        ns     = [1..] :: [Int]
        mapper = \n -> printf "#%d" n
        labels = map mapper ns
        zipper = \label (xs, encoded) -> label ~: assert xs encoded
        tests  = zipWith zipper labels testDataTuples
    in
        test tests

encodeTests :: Test
encodeTests = testsWithTestDataTuples assert
    where
        assert xs encoded = encoded ~?= encode xs

decodeTests :: Test
decodeTests = testsWithTestDataTuples assert
    where
        assert xs encoded = xs ~?= decode encoded

