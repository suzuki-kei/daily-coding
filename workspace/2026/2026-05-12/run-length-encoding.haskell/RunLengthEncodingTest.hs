module RunLengthEncodingTest where

import RunLengthEncoding (decode)
import RunLengthEncoding (encode)
import RunLengthEncoding (EncodedRun)
import Test.HUnit ((~:))
import Test.HUnit ((~=?))
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

type TestDataTuple = (String, [EncodedRun Char])

testDataTuples :: [TestDataTuple]
testDataTuples = [
    ("",       []),
    ("a",      [('a', 1)]),
    ("aa",     [('a', 2)]),
    ("aaa",    [('a', 3)]),
    ("ab",     [('a', 1), ('b', 1)]),
    ("abb",    [('a', 1), ('b', 2)]),
    ("abba",   [('a', 1), ('b', 2), ('a', 1)]),
    ("aabccc", [('a', 2), ('b', 1), ('c', 3)])]

testWithTestDataTuples :: String -> (String -> [EncodedRun Char] -> Test) -> Test
testWithTestDataTuples label assert = test tests
    where
        labels = map mapper ns
            where
                ns = [1..] :: [Int]
                mapper n = printf "%s #%d" label n
        tests = zipWith zipper labels testDataTuples
            where
                zipper label (xs, encodedRuns) = label ~: assert xs encodedRuns

encodeTests :: Test
encodeTests = testWithTestDataTuples "encode" assert
    where
        assert xs encodedRuns = encode xs ~=? encodedRuns

decodeTests :: Test
decodeTests = testWithTestDataTuples "decode" assert
    where
        assert xs encodedRuns = decode encodedRuns ~=? xs

