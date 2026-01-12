import System.IO (isEOF)

main :: IO ()
main = do
    eof <- isEOF
    if eof then
        pure ()
    else do
        line <- getLine
        putStrLn line
        main

