import Data.Char
import Text.Printf

main = do
    let s = "Hello, World!"
    let n = 1
    let encoded = encode n s
    let decoded = decode n encoded
    printf "s = %s\n" s
    printf "n = %d\n" n
    printf "encoded = %s\n" encoded
    printf "decoded = %s\n" decoded

encode :: Int -> String -> String
encode n s = [rotate n c | c <- s]

decode :: Int -> String -> String
decode n = encode (26 - n)

rotate :: Int -> Char -> Char
rotate n c | isLower c = rotateLower n c
           | isUpper c = rotateUpper n c
           | otherwise = c
    where
        rotateLower = rotate (charToInt 'a') (intToChar 'a')
        rotateUpper = rotate (charToInt 'A') (intToChar 'A')
        charToInt base c = ord c - ord base
        intToChar base n = chr $ n + ord base
        rotate charToInt intToChar n c = intToChar $ (charToInt c + n) `mod` 26

