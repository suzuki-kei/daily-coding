import Data.Char
import Text.Printf

main :: IO ()
main = do
    demonstration [1..26] "Hello, World!"

demonstration :: [Int] -> String -> IO ()
demonstration [] s = printf ""
demonstration (n:ns) s = do
    let encoded = encode n s
    let decoded = decode n encoded
    printf "(n = %2d): \"%s\" -> \"%s\" -> \"%s\"\n" n s encoded decoded
    demonstration ns s

encode :: Int -> String -> String
encode n s = map (rotate n) s

decode :: Int -> String -> String
decode n s = encode (26 - n) s

rotate :: Int -> Char -> Char
rotate n c | isLower c = rotateLower n c
           | isUpper c = rotateUpper n c
           | otherwise = rotateNonAlphabet n c
    where
        rotateLower = rotateChar $ ord 'a'
        rotateUpper = rotateChar $ ord 'A'
        rotateNonAlphabet n c = c
        rotateChar offset n c = chr $ (ord c + n - offset) `mod` 26 + offset

