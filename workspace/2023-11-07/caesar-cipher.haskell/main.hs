{- cabal:
    build-depends: base
-}

import Data.Char
import Text.Printf

main :: IO ()
main = demonstration "Hello, World!" [1..26]

demonstration :: String -> [Int] -> IO ()
demonstration s [] = pure ()
demonstration s (n:ns) = do
    let encoded = encode n s
    let decoded = decode n encoded
    printf "(n = %2d) %s -> %s -> %s\n" n s encoded decoded
    demonstration s ns

encode :: Int -> String -> String
encode n s = map (rotate n) s

decode :: Int -> String -> String
decode n s = map (rotate (26 - n)) s

rotate :: Int -> Char -> Char
rotate n c
    | isLower c = rotateLower n c
    | isUpper c = rotateUpper n c
    | otherwise = rotateNonAlphabet n c
    where
        rotateChar offset n c = chr $ (ord c + n - offset) `mod` 26 + offset
        rotateLower = rotateChar (ord 'a')
        rotateUpper = rotateChar (ord 'A')
        rotateNonAlphabet n c = c

