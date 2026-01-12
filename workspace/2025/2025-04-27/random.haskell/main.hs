import Data.List (intercalate)
import System.Random (StdGen)
import System.Random (getStdGen)
import System.Random (randomR)
import Text.Printf (printf)

main :: IO ()
main = do
    gen <- getStdGen
    let (xs, gen') = generateRandomValues 20 gen
    printf "%s\n" $ listToString " " xs

toString :: Int -> String
toString = printf "%d"

listToString :: String -> [Int] -> String
listToString separator xs = intercalate separator $ map toString xs

generateRandomValues :: Int -> StdGen -> ([Int], StdGen)
generateRandomValues n gen = accumulate [] n gen
    where
        accumulate xs 0 gen =
            (xs, gen)
        accumulate xs n gen =
            let
                (x, gen') = randomR (10, 99) gen
            in
                accumulate (x:xs) (n - 1) gen'

