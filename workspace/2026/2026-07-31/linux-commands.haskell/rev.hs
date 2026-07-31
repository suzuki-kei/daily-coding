
main :: IO ()
main = interact $ unlines . map reverse . lines

