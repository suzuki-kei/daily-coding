import Data.Char
import Text.Printf

main = do
    let n = 1
    let s = "Hello, World!"
    let encoded = encode n s
    let decoded = decode n encoded
    printf "n = %d\n" n
    printf "s = %s\n" s
    printf "encoded = %s\n" encoded
    printf "decoded = %s\n" decoded

encode :: Int -> String -> String
encode n s = map (rotate n) s

decode :: Int -> String -> String
decode n = encode (26 - n)

rotate :: Int -> Char -> Char
rotate n c | isLower c = rotateLower n c
           | isUpper c = rotateUpper n c
           | otherwise = rotateNonAlphabet n c
    where
        rotateLower = rotateChar $ ord 'a'
        rotateUpper = rotateChar $ ord 'A'
        rotateNonAlphabet n c = c
        rotateChar offset n c = chr $ (ord c + n - offset) `mod` 26 + offset

