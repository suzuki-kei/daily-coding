import Data.Char
import Text.Printf

main :: IO ()
main = do
    let s = "Hello, World!"
    demonstration s [1..26]

demonstration :: String -> [Int] -> IO ()
demonstration s [] = printf ""
demonstration s (n:ns) = do
    let encoded = encode n s
    let decoded = decode n encoded
    printf "(n=%d) \"%s\" -> \"%s\" -> \"%s\"\n" n s encoded decoded
    demonstration s ns

encode :: Int -> String -> String
encode n s = map (rotate n) s

decode :: Int -> String -> String
decode n s = encode (26 - n) s

rotate :: Int -> Char -> Char
rotate n c
    | isLower c = rotateLower n c
    | isUpper c = rotateUpper n c
    | otherwise = rotateNonAlphabet n c
    where
        rotateLower = rotateChar $ ord 'a'
        rotateUpper = rotateChar $ ord 'A'
        rotateNonAlphabet n c = c
        rotateChar offset n c = chr $ (ord c + n - offset) `mod` 26 + offset

