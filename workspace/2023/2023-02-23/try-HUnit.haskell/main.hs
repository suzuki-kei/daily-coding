{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit

main :: IO ()
main = do
    runTestTT allTestList
    pure ()

allTestList = TestList [
    addTestList,
    subtractTestList,
    multiplyTestList,
    divideTestList]

addTestList = test [
    "add" ~: "#1" ~:  0 ~=? (0 + 0),
    "add" ~: "#2" ~:  3 ~=? (1 + 2),
    "add" ~: "#3" ~:  7 ~=? (3 + 4),
    "add" ~: "#4" ~: 11 ~=? (5 + 6),
    "add" ~: "#5" ~: 15 ~=? (7 + 8)]

subtractTestList = test [
    "subtract" ~: "#1" ~: 0 ~=? (1 - 1),
    "subtract" ~: "#2" ~: 1 ~=? (3 - 2),
    "subtract" ~: "#3" ~: 2 ~=? (5 - 3),
    "subtract" ~: "#4" ~: 3 ~=? (7 - 4),
    "subtract" ~: "#5" ~: 4 ~=? (9 - 5)]

multiplyTestList = test [
    "multiply" ~: "#1" ~:  0 ~=? (0 * 0),
    "multiply" ~: "#2" ~:  1 ~=? (1 * 1),
    "multiply" ~: "#3" ~:  4 ~=? (2 * 2),
    "multiply" ~: "#4" ~:  9 ~=? (3 * 3),
    "multiply" ~: "#5" ~: 16 ~=? (4 * 4)]

divideTestList = test [
    "divide" ~: "#1" ~: 0 ~=? ( 0 / 1),
    "divide" ~: "#2" ~: 1 ~=? ( 2 / 2),
    "divide" ~: "#3" ~: 2 ~=? ( 6 / 3),
    "divide" ~: "#4" ~: 3 ~=? (12 / 4),
    "divide" ~: "#5" ~: 4 ~=? (20 / 5)]

