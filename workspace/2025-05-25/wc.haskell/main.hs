import Data.Char (isSpace)

main :: IO ()
main = getContents >>= print . wc

type LineCount = Int
type WordCount = Int
type CharCount = Int

wc :: String -> (LineCount, WordCount, CharCount)
wc s = accumulate s False 0 0 0
    where
        accumulate "" inWord lineCount wordCount charCount =
            (lineCount, wordCount, charCount)
        accumulate (c : chars) inWord lineCount wordCount charCount
            | isNewLine c = accumulate chars False (lineCount + 1) wordCount (charCount + 1)
            | isSpace c   = accumulate chars False lineCount wordCount (charCount + 1)
            | otherwise   =
                if inWord then
                    accumulate chars True lineCount wordCount (charCount + 1)
                else
                    accumulate chars True lineCount (wordCount + 1) (charCount + 1)
        isNewLine c = c == '\n'

