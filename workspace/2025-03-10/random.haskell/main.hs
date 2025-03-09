import System.Random (StdGen, getStdGen, randomRs)

main :: IO ()
main = do
    gen <- getStdGen
    print $ generateRandomValues gen 20

generateRandomValues :: StdGen -> Int -> [Int]
generateRandomValues gen n = take n $ randomRs (10, 99) gen

