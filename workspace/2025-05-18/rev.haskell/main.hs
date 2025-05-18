
main :: IO ()
main = getContents >>= printStringList . map reverse . lines

printStringList :: [String] -> IO ()
printStringList [] =
    pure ()
printStringList (row : rows) = do
    putStrLn row
    printStringList rows

