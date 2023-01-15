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
           | otherwise = c
    where
        rotateLower = rotateChar 'a'
        rotateUpper = rotateChar 'A'
        rotateChar offset n c = chr $ rotateInt 26 (ord offset) n (ord c)
        rotateInt base offset n x = (x + n - offset) `mod` base + offset

