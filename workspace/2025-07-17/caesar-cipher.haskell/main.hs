import Control.Monad (forM_)
import Data.Char (chr)
import Data.Char (isLower)
import Data.Char (isUpper)
import Data.Char (ord)
import Text.Printf (printf)

main :: IO ()
main = demonstration "Hello, World!" [0..26]

demonstration :: String -> [Int] -> IO ()
demonstration s [] = pure ()
demonstration s ns = forM_ ns step
    where
        step n =
            let
                encoded = encode n s
                decoded = decode n encoded
            in do
                printf "(n = %2d) %s -> %s -> %s\n" n s encoded decoded

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
        rotate offset n c = chr $ (ord c + n - offset) `mod` 26 + offset
        rotateLower = rotate (ord 'a')
        rotateUpper = rotate (ord 'A')
        rotateNonAlphabet n = id

