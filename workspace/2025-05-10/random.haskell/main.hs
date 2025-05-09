import Data.List (intercalate)
import System.Random (StdGen)
import System.Random (getStdGen)
import System.Random (randomR)
import Text.Printf (printf)

main :: IO ()
main = do
    gen <- getStdGen
    let (xs, gen') = generateRandomValues 20 gen
    printList xs

generateRandomValues :: Int -> StdGen -> ([Int], StdGen)
generateRandomValues n gen = foldl folder ([], gen) [1..n]
    where
        folder (xs, gen) n = ((x : xs), gen')
            where
                (x, gen') = randomR (10, 99) gen

printList :: [Int] -> IO ()
printList xs = printf "%s\n" $ listToString xs
    where
        toString = printf "%d"
        listToString = (intercalate " ") . (map toString)

