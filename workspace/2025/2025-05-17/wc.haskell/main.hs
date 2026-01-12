import Data.Char (isSpace)

main :: IO ()
main = do
    (lineCount, wordCount, charCount) <- wc <$> getContents
    print (lineCount, wordCount, charCount)

wc :: String -> (Int, Int, Int)
wc text = accumulate text False (0, 0, 0)
    where
        accumulate "" inWord (lineCount, wordCount, charCount) =
            (lineCount, wordCount, charCount)
        accumulate (c : chars) inWord (lineCount, wordCount, charCount)
            | c == '\n' = accumulate chars False (lineCount + 1, wordCount, charCount + 1)
            | isSpace c = accumulate chars False (lineCount, wordCount, charCount + 1)
            | otherwise =
                if inWord then
                    accumulate chars True (lineCount, wordCount, charCount + 1)
                else
                    accumulate chars True (lineCount, wordCount + 1, charCount + 1)

