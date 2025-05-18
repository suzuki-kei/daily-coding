
main :: IO ()
main = getContents >>= mapM_ putStrLn . map reverse . lines

