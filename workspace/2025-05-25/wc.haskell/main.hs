import Data.Char (isSpace)

main :: IO ()
main = getContents >>= print . wc

type LineCount = Int
type WordCount = Int
type CharCount = Int

wc :: String -> (LineCount, WordCount, CharCount)
wc s =
    let
        (inWord, lineCount, wordCount, charCount) = foldl folder (False, 0, 0, 0) s
    in
        (lineCount, wordCount, charCount)
    where
        folder (inWord, lineCount, wordCount, charCount) c
            | isNewLine c = (False, lineCount + 1, wordCount, charCount + 1)
            | isSpace c   = (False, lineCount, wordCount, charCount + 1)
            | inWord      = (True, lineCount, wordCount, charCount + 1)
            | otherwise   = (True, lineCount, wordCount + 1, charCount + 1)
        isNewLine c = c == '\n'

