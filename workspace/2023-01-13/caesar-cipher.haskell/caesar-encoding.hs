import Data.Char

main = print $ decode key $ encode key "HAL"

key :: Int
key = 1

encode :: Int -> String -> String
encode = rotateString

decode :: Int -> (String -> String)
decode n = rotateString (-n)

rotateString :: Int -> String -> String
rotateString n s = [rotateChar n c | c <- s]

rotateChar :: Int -> Char -> Char
rotateChar n c | isLower c = intToLowerChar $ lowerCharToInt c + n
               | isUpper c = intToUpperChar $ upperCharToInt c + n
               | otherwise = c
    where
        lowerCharToInt c = ord c - ord 'a'
        upperCharToInt c = ord c - ord 'A'
        intToLowerChar n = chr $ (n + 26 `mod` 26) + ord 'a'
        intToUpperChar n = chr $ (n + 26 `mod` 26) + ord 'A'

