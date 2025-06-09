import Data.Char (isSpace)
import Text.Printf (printf)

main :: IO ()
main = getContents >>= printWc . wc

type NLines = Int
type NWords = Int
type NChars = Int

wc :: String -> (NLines, NWords, NChars)
wc s =
    let
        (inWord, nLines, nWords, nChars) = foldl folder (False, 0, 0, 0) s
    in
        (nLines, nWords, nChars)
    where
        folder (inWord, nLines, nWords, nChars) c
            | isNewLine c = (False, nLines + 1, nWords, nChars + 1)
            | isSpace c   = (False, nLines, nWords, nChars + 1)
            | otherwise   =
                if inWord then
                    (True, nLines, nWords, nChars + 1)
                else
                    (True, nLines, nWords + 1, nChars + 1)
        isNewLine = (== '\n')

printWc :: (NLines, NWords, NChars) -> IO ()
printWc (nLines, nWords, nChars) = printf "%7d %7d %7d\n" nLines nWords nChars

