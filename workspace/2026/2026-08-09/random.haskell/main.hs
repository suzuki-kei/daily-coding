import Control.Monad (replicateM)
import Control.Monad.State (runState)
import Control.Monad.State (state)
import Control.Monad.State (State)
import Data.List (intercalate)
import System.Random (getStdGen)
import System.Random (randomR)
import System.Random (StdGen)
import Text.Printf (printf)

main :: IO ()
main = do
    gen <- getStdGen
    let
        (xs, gen') = runState run gen
        run = generateRandomValues (10, 99) 20
    printList xs

generateRandomValues :: (Int, Int) -> Int -> State StdGen [Int]
generateRandomValues range n =
    replicateM n (state (randomR range))

printList :: [Int] -> IO ()
printList xs = putStrLn (listToString xs)

listToString :: [Int] -> String
listToString xs = intercalate " " $ map toString xs
    where
        toString x = printf "%d" x

