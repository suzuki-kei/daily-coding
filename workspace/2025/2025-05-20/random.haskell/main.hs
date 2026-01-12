import System.Random (StdGen)
import System.Random (getStdGen)
import System.Random (randomR)

main :: IO ()
main = do
    gen <- getStdGen
    let (xs, gen') = generateRandomValues 20 gen
    print xs

generateRandomValues :: Int -> StdGen -> ([Int], StdGen)
generateRandomValues n gen = foldl folder ([], gen) [1..n]
    where
        folder (xs, gen) n =
            let
                (x, gen') = randomR (10, 99) gen
            in
                ((x : xs), gen')

