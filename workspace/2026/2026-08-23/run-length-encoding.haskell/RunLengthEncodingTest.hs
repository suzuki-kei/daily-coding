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

type TestData = (String, [EncodedRun Char])

main ::
    IO ()
main =
    runTestTTAndExit allTests

testDataList ::
    [TestData]
testDataList =
    [
        ("",       []),
        ("a",      [('a', 1)]),
        ("aa",     [('a', 2)]),
        ("aaa",    [('a', 3)]),
        ("ab",     [('a', 1), ('b', 1)]),
        ("abb",    [('a', 1), ('b', 2)]),
        ("abba",   [('a', 1), ('b', 2), ('a', 1)]),
        ("aabccc", [('a', 2), ('b', 1), ('c', 3)])
    ]

testWithDataList ::
    String -> (a -> Test) -> [a] -> Test
testWithDataList label assert tuples =
    let
        labels = map mapper ([1..] :: [Int])
            where
                mapper n = printf "%s #%d" label n
        tests = zipWith zipper labels tuples
            where
                zipper label tuple = label ~: assert tuple
    in
        test tests

allTests ::
    Test
allTests =
    TestList [
        encodeTests,
        decodeTests
    ]

encodeTests ::
    Test
encodeTests =
    testWithDataList "encode" assert testDataList
        where
            assert (xs, encodedRuns) = encode xs ~?= encodedRuns

decodeTests ::
    Test
decodeTests =
    testWithDataList "decode" assert testDataList
        where
            assert (xs, encodedRuns) = decode encodedRuns ~?= xs

