{- cabal:
    build-depends: base, HUnit
-}

import Test.HUnit ((~:))
import Test.HUnit ((~=?))
import Test.HUnit (Test)
import Test.HUnit (test)
import Test.HUnit (runTestTTAndExit)

main :: IO ()
main = runTestTTAndExit intersperseTests

intersperse :: a -> [a] -> [a]
intersperse separator [] = []
intersperse separator [x] = [x]
intersperse separator (x : xs) = (x : separator : intersperse separator xs)

intersperseTests :: Test
intersperseTests = test [
    "#1" ~: "" ~=? (intersperse '_' ""),
    "#2" ~: "a" ~=? (intersperse '_' "a"),
    "#3" ~: "a_b" ~=? (intersperse '_' "ab"),
    "#4" ~: "a_b_c" ~=? (intersperse '_' "abc"),
    "#5" ~: "axbxc" ~=? (intersperse 'x' "abc")]

