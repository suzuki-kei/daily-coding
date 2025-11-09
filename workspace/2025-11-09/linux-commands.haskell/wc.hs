import Text.Printf (printf)

type NLines = Int
type NWords = Int
type NChars = Int
type Wc = (NLines, NWords, NChars)

main :: IO ()
main = getContents >>= putStrLn . formatWc . wc

wc :: String -> Wc
wc s = (nLines, nWords, nChars)
    where
        (insideWord, nLines, nWords, nChars) =
            foldl folder (False, 0, 0, 0) s
        folder (insideWord, nLines, nWords, nChars) c
            | isNewLine c = (False, nLines + 1, nWords,     nChars + 1)
            | isSpace   c = (False, nLines,     nWords,     nChars + 1)
            | insideWord  = (True,  nLines,     nWords,     nChars + 1)
            | otherwise   = (True,  nLines,     nWords + 1, nChars + 1)

formatWc :: Wc -> String
formatWc (nLines, nWords, nChars) = printf "%7d %7d %7d" nLines nWords nChars

isNewLine :: Char -> Bool
isNewLine c = c == '\n'

isSpace :: Char -> Bool
isSpace c = c `elem` ['\t', '\n', '\v', '\f', '\r', ' ']

