
main :: IO ()
main = getContents >>= mapM_ putStrLn . reverse . lines

