{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit

main :: IO ()
main = do
    runTestTT allTestList
    pure ()

allTestList = TestList [
    addTestList]

addTestList = test [
    "add" ~: "#1" ~:  0 ~=? (0 + 0),
    "add" ~: "#2" ~:  1 ~=? (0 + 1),
    "add" ~: "#3" ~:  3 ~=? (1 + 2),
    "add" ~: "#4" ~:  5 ~=? (2 + 3),
    "add" ~: "#5" ~:  7 ~=? (3 + 4),
    "add" ~: "#6" ~:  9 ~=? (4 + 5)]

